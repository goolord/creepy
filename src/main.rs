#[macro_use]
extern crate clap;
extern crate html5ever;
extern crate rayon;
extern crate ref_cast;
extern crate reqwest;
extern crate scraper;
extern crate select;
extern crate serde;
extern crate serde_regex;
extern crate url;
mod types;
use rayon::prelude::*;
use ref_cast::RefCast;
use regex::Regex;
use scraper::{Html, Selector};
use std::collections::HashSet;
use std::fs::File;
use std::hash::{Hash};
use std::io::prelude::*;
use std::iter::FromIterator;
use std::thread::sleep;
use std::time::Duration;
use types::*;
use url::Url;
use std::fs;

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

fn singleton_hashset<A>(item: A) -> HashSet<A> 
    where A: Eq + Hash, {
    let mut set = HashSet::new();
    set.insert(item);
    return set;
}

fn vec_to_set<A>(vec: Vec<A>) -> HashSet<A> 
    where A: Eq + Hash, {
    HashSet::from_iter(vec)
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
    ).get_matches();

    // CONFIGURE
    if let Some(configure_matches) = matches.subcommand_matches("configure") {
        if configure_matches.is_present("default") {
            let default_config: Config = Config {
                domains: HashSet::new(),
                blacklist: Vec::new(),
                whitelist: Vec::new(),
                super_blacklist: Vec::new(),
                respect_robots_txt: false,
                link_criteria: None,
                match_criteria: None,
                period: Duration::from_secs(0),
                basic_auth: None,
            };
            println!("{}", toml::to_string_pretty(&default_config).unwrap())
        }
        if configure_matches.is_present("full") {
            let full_config: Config = Config {
                domains: singleton_hashset(PartialUrl(Url::parse("https://github.com/goolord").unwrap())),
                blacklist: vec![Regex::new(".*").unwrap()],
                whitelist: vec![Regex::new("https://github.com/goolord.*").unwrap()],
                super_blacklist: vec![Regex::new(".*\\.jpg").unwrap()],
                respect_robots_txt: true,
                link_criteria: Some(StrSelector(Selector::parse("a[href]").unwrap())),
                match_criteria: Some(StrSelector(Selector::parse("form").unwrap())),
                period: Duration::from_secs(1),
                basic_auth: Some(BasicAuthCreds {
                    user: String::from("username"),
                    pass: String::from("pass"),
                }),
            };
            println!("link_criteria = 'a.is-link:not(button)'");
            println!("match_criteria = 'form.is-form'");
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
            .any(|domain| !config.valid_domain(&domain.0))
        {
            panic!("Your blacklist overrides domains you have set")
        }
        // crawl
        let mut visited: HashSet<PartialUrl> = HashSet::new(); // visited domains
        let link_selector = match &config.link_criteria {
            None => Selector::parse("a[href]").unwrap(), // default link selector
            Some(selector) => selector.0.to_owned(),
        };
        let client: reqwest::Client = reqwest::Client::builder()
            .danger_accept_invalid_certs(true)
            .timeout(Duration::from_secs(8)) // 8 second timeout
            .build()
            .unwrap();
        let crawler: Vec<PartialUrl> = crawl_multi(config.domains.to_owned(), &config, &link_selector, &client, &mut visited);
        let domains_str: String = crawler
            .par_iter()
            .fold( || String::new()
                 , |acc, x| acc + "\n" + x.0.as_str()
                 )
            .collect();
        match write_file("hits.txt", &domains_str) {
            Ok(_) => println!("Done. Exported hits to hits.txt"),
            Err(e) => {
                eprintln!("Error writing file: {}", e);
                eprintln!("Dumping hits to stdout");
                println!("{}", domains_str);
            }
        }
    }
}

fn write_file(file_name: &'static str, file_contents: &String) -> Result<(), std::io::Error> {
    fs::write(file_name, file_contents)
}

fn crawl_multi
    ( domains: HashSet<PartialUrl>
    , config: &Config
    , link_selector: &Selector
    , client: &reqwest::Client
    , visited: &mut HashSet<PartialUrl>
    ) -> Vec<PartialUrl> {
    visited.extend(domains.clone());
    let single_crawls: HashSet<SingleCrawl> = domains.par_iter().map(|domain| {
        crawl_single(&domain.0, config, client, link_selector, visited)
    }).collect();
    let mut hits = Vec::new();
    for crawl in single_crawls.into_iter() {
        if crawl.is_hit {
            hits.push(PartialUrl(crawl.domain));
        }
        let mut new_hits = crawl_multi(vec_to_set(crawl.unexhausted_domains), config, link_selector, client, visited);
        hits.append(&mut new_hits);
    }
    return hits;
}

fn crawl_single
    ( domain: &Url
    , config: &Config
    , client: &reqwest::Client
    , link_selector: &Selector
    , visited: &HashSet<PartialUrl>
    ) -> SingleCrawl {
    println!("crawling {}", domain);
    let domain_str = domain.as_str();
    let mut response: reqwest::Response = {
        let response_e = match &config.basic_auth {
            Some(auth) => client
                .get(domain_str)
                .header("ACCEPT", "text/html")
                .header("AUTHORIZATION", format!("{}:{}", auth.user, auth.pass))
                .send(),
            None => client.get(domain_str).header("ACCEPT", "text/html").send(),
        };
        match response_e {
            Ok(x) => x,
            Err(e) => {
                eprintln!("Error: {}", e);
                return SingleCrawl {
                    domain: domain.to_owned(),
                    is_hit: false,
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
                domain: domain.to_owned(),
                is_hit: false,
                unexhausted_domains: Vec::new(),
            };
        }
    };
    let document: Html = Html::parse_document(&body);

    let is_hit: bool = match &config.match_criteria {
        Some(StrSelector(sel)) => {
            let hits = document.select(&sel);
            hits.into_iter().next().is_some()
        }
        None => true,
    };

    let mut legs: Vec<PartialUrl> = Vec::new(); // additional domains to crawl

    let mut push_url = |url: Url| {
        let valid_domain = config.valid_domain(&url);
        if valid_domain && !visited.contains(PartialUrl::ref_cast(&url)) {
            legs.push(PartialUrl(url))
        }
    };

    let links = document.select(link_selector);
    for link in links.into_iter() {
        link.value().attr("href").map(|url| {
            match Url::parse(url) {
                Ok(url_parsed) => push_url(url_parsed),
                Err(e) => match e {
                    url::ParseError::RelativeUrlWithoutBase => match url.chars().next() {
                        Some('#') => (),
                        Some(_) => match Url::parse(&format!(
                            "{}://{}{}",
                            domain.scheme(),
                            domain.host_str().unwrap_or("EMPTY"),
                            url
                        )) {
                            Ok(url_parsed) => push_url(url_parsed),
                            _ => eprintln!("Could not parse URL \"{}\": {}", url, e),
                        },
                        None => (),
                    },
                    _ => eprintln!("Could not parse URL \"{}\": {}", url, e),
                },
            };
        });
    }

    sleep(config.period); // polite delay

    return SingleCrawl {
        domain: domain.to_owned(),
        unexhausted_domains: legs,
        is_hit,
    };
}
