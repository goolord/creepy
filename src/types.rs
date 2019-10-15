use regex::Regex;
use scraper::Selector;
use serde::{Deserialize, Deserializer, Serialize};
use std::time::Duration;

#[derive(Deserialize, Serialize)]
pub struct Config {
    pub domains: Vec<String>,
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
    pub period: Duration,
}

impl Config {
    pub fn valid_domain(&self, domain: &str) -> bool {
        let in_blacklist = self
            .blacklist
            .iter()
            .fold(false, |acc, rx| rx.is_match(domain) || acc);
        let in_whitelist = self
            .whitelist
            .iter()
            .fold(false, |acc, rx| rx.is_match(domain) || acc);
        return !in_blacklist || in_whitelist;
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
    pub unexhausted_domains: Vec<String>,
    pub hits: Vec<String>,
    pub misses: Vec<String>,
}


#[derive(Debug)]
pub struct SingleCrawl {
    pub unexhausted_domains: Vec<String>,
    pub is_hit: bool,
    pub domain: String,
}
