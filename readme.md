# 🐛 Creepy crawly web crawler

## Usage

```
creepy 1.0
Zachary Churchill <zacharyachurchill@gmail.com>
🐛 Creepy crawly web crawler

USAGE:
    creepy [SUBCOMMAND]

FLAGS:
    -h, --help       Prints help information
    -V, --version    Prints version information

SUBCOMMANDS:
    configure    Configuration options
    crawly       Web crawling
    help         Prints this message or the help of the given subcommand(s)
```

```
creepy-configure
Configuration options

USAGE:
    creepy configure [FLAGS]

FLAGS:
        --default    generate a default configuration
        --full       generate a full default configuration
    -h, --help       Prints help information
    -V, --version    Prints version information
```

```
Web crawling

USAGE:
    creepy crawly --config <CONFIG>

FLAGS:
    -h, --help       Prints help information
    -V, --version    Prints version information

OPTIONS:
    -c, --config <CONFIG>    Config file: domains, blacklist, etc
```
