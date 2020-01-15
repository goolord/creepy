use ref_cast::RefCast;
use regex::Regex;
use scraper::Selector;
use serde::{Deserialize, Deserializer, Serialize};
use std::collections::HashSet;
use std::hash::{Hash, Hasher};
use std::time::Duration;
use std::cmp::Ordering;
use url::Url;

#[derive(Deserialize, Serialize)]
pub struct Config {
    pub domains: HashSet<PartialUrl>,
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
    pub clean_output: bool,
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
        let in_blacklist = self.blacklist.iter().any(|rx| rx.is_match(domain_str));
        let in_whitelist = self.whitelist.iter().any(|rx| rx.is_match(domain_str));
        let in_domains = self.domains.iter().any(|dm| domain.host() == dm.0.host());
        let in_super_blacklist = self
            .super_blacklist
            .iter()
            .any(|rx| rx.is_match(domain_str));
        (!in_blacklist || in_whitelist || in_domains) && !in_super_blacklist
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

#[derive(Debug)]
pub struct Crawler {
    pub hits: Vec<Url>,
    pub misses: Vec<Url>,
}

#[derive(Debug, PartialEq, Eq, Hash)]
pub struct SingleCrawl {
    pub domain: Url,
    pub unexhausted_domains: Vec<PartialUrl>,
    pub is_hit: bool,
}

#[derive(RefCast, Serialize, Deserialize, Clone, Debug)]
#[repr(transparent)]
pub struct PartialUrl(pub Url);

impl PartialEq for PartialUrl {
    fn eq(&self, other: &Self) -> bool {
           self.0.host() == other.0.host() 
        && self.0.path() == other.0.path()
    }
}

impl Eq for PartialUrl {}

impl Hash for PartialUrl {
    fn hash<H: Hasher>(&self, state: &mut H) {
        self.0.host().hash(state);
        self.0.path().hash(state);
    }
}

impl PartialOrd for PartialUrl {
    fn partial_cmp(&self, other: &Self) -> Option<Ordering> {
        Some(self.cmp(other))
    }
}

impl Ord for PartialUrl {
    fn cmp(&self, other: &Self) -> Ordering {
       match self.0.host().cmp(&other.0.host()) {
           Ordering::Equal => self.0.path().cmp(&other.0.path()),
           x => x
       }
    }
}

