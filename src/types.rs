use regex::Regex;
use scraper::Selector;
use serde::{Deserialize, Deserializer, Serialize};
use std::time::Duration;
use url::Url;
use ref_cast::RefCast;

#[derive(Deserialize, Serialize)]
pub struct Config {
    pub domains: Vec<Url>,
    #[serde(default)]
    #[serde(with = "serde_regex")]
    pub blacklist: Vec<Regex>,
    #[serde(default)]
    #[serde(with = "serde_regex")]
    pub whitelist: Vec<Regex>,
    #[serde(default)]
    #[serde(with = "serde_regex")]
    pub super_blacklist: Vec<Regex>,
    pub respect_robots_txt: bool,
    #[serde(default)]
    #[serde(skip_serializing)]
    pub match_criteria: Option<StrSelector>,
    #[serde(default)]
    #[serde(skip_serializing)]
    pub link_criteria: Option<StrSelector>,
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
            .any(|rx| rx.is_match(domain_str));
        let in_whitelist = self
            .whitelist
            .iter()
            .any(|rx| rx.is_match(domain_str));
        let in_domains = self
            .domains
            .iter()
            .any(|dm| domain.host() == dm.host());
        let in_super_blacklist = self
            .super_blacklist
            .iter()
            .any(|rx| rx.is_match(domain_str));
        return (!in_blacklist || in_whitelist || in_domains) && !in_super_blacklist;
    }
}

#[derive(RefCast)]
#[repr(transparent)]
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

#[derive(Hash, RefCast)]
#[repr(transparent)]
pub struct PartialUrl(pub Url);

impl PartialEq for PartialUrl {
    fn eq(&self, other: &Self) -> bool {
           self.0.host() == other.0.host() 
        && self.0.path() == other.0.path()
    }
}

impl Eq for PartialUrl {}

pub enum Hit {
    Hit(Url),
    Miss(Url),
}
