#[macro_use]
extern crate clap;
extern crate html5ever;
extern crate reqwest;
extern crate scraper;
extern crate select;
extern crate serde;
extern crate serde_regex;
extern crate url;
mod types;
use regex::Regex;
use scraper::{Html, Selector};
use std::fs::File;
use std::io::prelude::*;
use std::thread::sleep;
use std::time::Duration;
use types::*;
use url::Url;

fn read_file_contents(file_name: &str) -> std::io::Result<String> {
    let mut file = File::open(file_name)?;
    let mut contents = String::new();
    file.read_to_string(&mut contents)?;
    return Ok(contents);
}

fn decode_toml<D: serde::de::DeserializeOwned>(file_name: &str) -> Result<D, toml::de::Error> {
    let contents = read_file_contents(file_name).expect("Could not read toml file");
    return toml::from_str(&contents);
}

fn main() {
    let matches = clap_app!( creepy =>
        (version: "1.0")
        (author: "Zachary Churchill <zacharyachurchill@gmail.com>")
        (about: "🐛 Creepy crawly web crawler")
        (@subcommand crawly =>
            (about: "Web crawling")
            (@arg CONFIG: --config -c +required +takes_value "Config file: domains, blacklist, etc")
        )
        (@subcommand configure =>
            (about: "Configuration options")
            (@arg default: --default conflicts_with("full") "generate a default configuration")
            (@arg full: --full conflicts_with("default") "generate a full default configuration")
        )
    )
    .get_matches();

    // CONFIGURE
    if let Some(configure_matches) = matches.subcommand_matches("configure") {
        if configure_matches.is_present("default") {
            let default_config: Config = Config {
                domains: Vec::new(),
                blacklist: Vec::new(),
                whitelist: Vec::new(),
                respect_robots_txt: false,
                link_criteria: Some(Vec::new()),
                match_criteria: Some(Vec::new()),
                period: Duration::from_secs(0),
            };
            println!("{}", toml::to_string_pretty(&default_config).unwrap())
        }
        if configure_matches.is_present("full") {
            let full_config: Config = Config {
                domains: vec![String::from("https://github.com/goolord")],
                blacklist: vec![Regex::new(".*").unwrap()],
                whitelist: vec![Regex::new("https://github.com/goolord.*").unwrap()],
                respect_robots_txt: true,
                link_criteria: Some(Vec::new()),
                match_criteria: Some(Vec::new()),
                period: Duration::from_secs(1),
            };
            println!("link_criteria = ['a.is-link:not(button)']");
            println!("match_criteria = ['form.is-form']");
            println!("{}", toml::to_string_pretty(&full_config).unwrap());
        }
    }

    // CRAWLY
    if let Some(crawly_matches) = matches.subcommand_matches("crawly") {
        // unwrap required args
        let config_file_name: &str = crawly_matches.value_of("CONFIG").unwrap();
        let config: Config = decode_toml(config_file_name).expect("Could not decode config");
        // validate the config
        if config
            .domains
            .iter()
            .fold(false, |acc, domain| !config.valid_domain(domain) || acc)
        {
            panic!("Your blacklist overrides domains you have set")
        }
        // crawl
        let mut visited: Vec<String> = Vec::new(); // visited domains
        let crawler: Crawler = crawl_multi(&config.domains, &config, &mut visited);
        println!("{:#?}", crawler);
    }
}

fn crawl_multi(domains: &Vec<String>, config: &Config, visited: &mut Vec<String>) -> Crawler {
    let unexhausted_domains: Vec<String> = Vec::new();
    let mut hits: Vec<String> = Vec::new(); // matched predicate
    let mut misses: Vec<String> = Vec::new(); // did not match predicate
    for domain in domains {
        if !visited.contains(domain) {
            let single_crawl: SingleCrawl = crawl_single(&domain, config, visited);
            if single_crawl.is_hit {
                hits.push(single_crawl.domain);
            } else {
                misses.push(single_crawl.domain);
            }
            visited.push(domain.to_owned());
            crawl_multi(&single_crawl.unexhausted_domains, config, visited);
        }
    }
    return Crawler {
        unexhausted_domains,
        hits,
        misses,
    };
}

fn crawl_single(domain: &str, config: &Config, visited: &Vec<String>) -> SingleCrawl {
    println!("crawling {}", domain);
    let mut response: reqwest::Response = match reqwest::get(domain) {
        Ok(x) => x,
        Err(e) => {
            eprintln!("Error: {}", e);
            return SingleCrawl {
                is_hit: false,
                domain: domain.to_owned(),
                unexhausted_domains: Vec::new(),
            };
        }
    };
    let body: String = response.text().unwrap();
    let document: Html = Html::parse_document(&body);
    let user_link_selectors: Option<Vec<Selector>> = config
        .link_criteria
        .as_ref()
        .map(|x| x.into_iter().map(|StrSelector(y)| y.to_owned()).collect());
    let link_selectors = match user_link_selectors {
        None => vec![Selector::parse("a[href]").unwrap()], // default link selector
        Some(selectors) => selectors,
    };

    let is_hit: bool = match &config.match_criteria {
        Some(hit_selectors) => hit_selectors.into_iter().any(|StrSelector(sel)| {
            let hits = document.select(&sel);
            return hits.into_iter().next().is_some();
        }),
        None => true,
    };

    let mut legs: Vec<String> = Vec::new(); // additional domains to crawl
    for sel in link_selectors {
        let links = document.select(&sel);
        for link in links.into_iter() {
            link.value().attr("href").map(|url| {
                match Url::parse(url) {
                    Ok(_) => {
                        let url_owned = url.to_owned();
                        if config.valid_domain(url) && (!visited.contains(&url_owned)) {
                            legs.push(url_owned)
                        }
                    }
                    Err(_) => (),
                };
            });
        }
    }

    sleep(config.period); // polite delay

    return SingleCrawl {
        unexhausted_domains: legs,
        is_hit,
        domain: domain.to_owned(),
    };
}
