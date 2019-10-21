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
use std::collections::HashSet;
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
                basic_auth: None,
            };
            println!("{}", toml::to_string_pretty(&default_config).unwrap())
        }
        if configure_matches.is_present("full") {
            let full_config: Config = Config {
                domains: vec![Url::parse("https://github.com/goolord").unwrap()],
                blacklist: vec![Regex::new(".*").unwrap()],
                whitelist: vec![Regex::new("https://github.com/goolord.*").unwrap()],
                respect_robots_txt: true,
                link_criteria: Some(Vec::new()),
                match_criteria: Some(Vec::new()),
                period: Duration::from_secs(1),
                basic_auth: Some(BasicAuthCreds {
                    user: String::from("username"),
                    pass: String::from("pass"),
                }),
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
        let mut visited: HashSet<PartialUrl> = HashSet::new(); // visited domains
        let crawler: Crawler = crawl_multi(&config.domains, &config, &mut visited);
        println!("{:#?}", crawler);
    }
}

fn crawl_multi(domains: &Vec<Url>, config: &Config, visited: &mut HashSet<PartialUrl>) -> Crawler {
    let unexhausted_domains: Vec<Url> = Vec::new();
    let mut hits: Vec<Url> = Vec::new(); // matched predicate
    let mut misses: Vec<Url> = Vec::new(); // did not match predicate
    for domain in domains {
        if !visited.contains(&PartialUrl(domain.to_owned())) {
            let single_crawl: SingleCrawl = crawl_single(&domain, config, visited);
            if single_crawl.is_hit {
                hits.push(single_crawl.domain);
            } else {
                misses.push(single_crawl.domain);
            }
            visited.insert(PartialUrl(domain.to_owned()));
            crawl_multi(&single_crawl.unexhausted_domains, config, visited);
        }
    }
    return Crawler {
        unexhausted_domains,
        hits,
        misses,
    };
}

fn crawl_single(domain: &Url, config: &Config, visited: &HashSet<PartialUrl>) -> SingleCrawl {
    println!("crawling {}", domain);

    let domain_str = domain.as_str();
    let mut response: reqwest::Response = {
        let client = reqwest::Client::builder()
            .danger_accept_invalid_certs(true)
            .timeout(Duration::from_secs(8)) // 8 second timeout
            .build()
            .unwrap()
            .get(domain_str)
            .header("ACCEPT", "text/*");
        let response_e = match &config.basic_auth {
            Some(auth) => client
                .header("AUTHORIZATION", format!("{}:{}", auth.user, auth.pass))
                .send(),
            None => client.send(),
        };
        match response_e {
            Ok(x) => x,
            Err(e) => {
                eprintln!("Error: {}", e);
                return SingleCrawl {
                    is_hit: false,
                    domain: domain.to_owned(),
                    unexhausted_domains: Vec::new(),
                };
            }
        }
    };
    let body: String = match response.text() {
        Ok(x) => x,
        Err(e) => {
            eprintln!("Error: response text error in {}", e);
            return SingleCrawl {
                is_hit: false,
                domain: domain.to_owned(),
                unexhausted_domains: Vec::new(),
            };
        }
    };
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

    let mut legs: Vec<Url> = Vec::new(); // additional domains to crawl
    for sel in link_selectors {
        let links = document.select(&sel);
        for link in links.into_iter() {
            link.value().attr("href").map(|url| {
                match Url::parse(url) {
                    Ok(url_parsed) => {
                        let valid_domain = config.valid_domain(&url_parsed);
                        let pu = PartialUrl(url_parsed);
                        if valid_domain && !visited.contains(&pu) {
                            legs.push(pu.0)
                        }
                    }
                    Err(e) => match e {
                        url::ParseError::RelativeUrlWithoutBase => match url.chars().next() {
                            Some('#') => (),
                            Some(_) => match Url::parse(&format!(
                                "{}://{}{}",
                                domain.scheme(),
                                domain.host_str().unwrap_or("EMPTY"),
                                url
                            )) {
                                Ok(url_parsed) => {
                                    let valid_domain = config.valid_domain(&url_parsed);
                                    let pu = PartialUrl(url_parsed);
                                    if valid_domain && (!visited.contains(&pu)) {
                                        legs.push(pu.0)
                                    }
                                }
                                _ => eprintln!("Could not parse URL \"{}\": {}", url, e),
                            },
                            None => (),
                        },
                        _ => eprintln!("Could not parse URL \"{}\": {}", url, e),
                    },
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
