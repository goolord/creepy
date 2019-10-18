use regex::Regex;
use scraper::Selector;
use serde::{Deserialize, Deserializer, Serialize};
use std::time::Duration;
use url::{Url};

#[derive(Deserialize, Serialize)]
pub struct Config {
    pub domains: Vec<Url>,
    #[serde(default)]
    #[serde(with = "serde_regex")]
    pub blacklist: Vec<Regex>,
    #[serde(default)]
    #[serde(with = "serde_regex")]
    pub whitelist: Vec<Regex>,
    pub respect_robots_txt: bool,
    #[serde(default)]
    #[serde(skip_serializing)]
    pub match_criteria: Option<Vec<StrSelector>>,
    #[serde(default)]
    #[serde(skip_serializing)]
    pub link_criteria: Option<Vec<StrSelector>>,
    pub basic_auth: Option<BasicAuthCreds>,
    pub period: Duration,
}

#[derive(Deserialize, Serialize)]
pub struct BasicAuthCreds {
    pub user: String,
    pub pass: String,
}

impl Config {
    pub fn valid_domain(&self, domain: &Url) -> bool {
        let domain_str = domain.as_str();
        let in_blacklist = self
            .blacklist
            .iter()
            .fold(false, |acc, rx| rx.is_match(domain_str) || acc);
        let in_whitelist = self
            .whitelist
            .iter()
            .fold(false, |acc, rx| rx.is_match(domain_str) || acc);
        let in_domains = self
            .domains
            .iter()
            .fold(false, |acc, dm| domain.host() == dm.host() || acc);
        return !in_blacklist || in_whitelist || in_domains;
    }
}

pub struct StrSelector(pub Selector);

impl<'de> Deserialize<'de> for StrSelector {
    fn deserialize<D>(deserializer: D) -> Result<Self, D::Error>
    where
        D: Deserializer<'de>,
    {
        // Deserialize the string and get individual components
        let s = String::deserialize(deserializer)?;

        // Parse individual components
        let selector: Selector = Selector::parse(&s).expect("Parse error in selector");

        // Convert to int and wrap in time
        Ok(StrSelector(selector))
    }
}

impl From<StrSelector> for Selector {
    fn from(x: StrSelector) -> Self {
        let StrSelector(sel) = x;
        return sel;
    }
}

#[derive(Debug)]
pub struct Crawler {
    pub unexhausted_domains: Vec<Url>,
    pub hits: Vec<Url>,
    pub misses: Vec<Url>,
}

#[derive(Debug)]
pub struct SingleCrawl {
    pub unexhausted_domains: Vec<Url>,
    pub is_hit: bool,
    pub domain: Url,
}
