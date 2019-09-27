#[macro_use]
use serde::{Deserialize, Serialize};
use regex::Regex;
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
    pub match_criteria: Vec<Criteria>,
    #[serde(default)]
    pub link_criteria: Vec<Criteria>,
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

#[derive(Deserialize, Serialize)]
pub struct Criteria {
    pub element: Option<Element>,
}

#[derive(Deserialize, Serialize)]
pub struct Element {
    pub node_name: String,
    pub present_attrs: Vec<Attr>,
    pub absent_attrs: Vec<Attr>,
}

pub type Attr = ();

