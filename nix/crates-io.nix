{ lib, buildRustCrate, buildRustCrateHelpers }:
with buildRustCrateHelpers;
let inherit (lib.lists) fold;
    inherit (lib.attrsets) recursiveUpdate;
in
rec {

# adler32-1.0.4

  crates.adler32."1.0.4" = deps: { features?(features_.adler32."1.0.4" deps {}) }: buildRustCrate {
    crateName = "adler32";
    version = "1.0.4";
    description = "Minimal Adler32 implementation for Rust.";
    authors = [ "Remi Rampin <remirampin@gmail.com>" ];
    sha256 = "157bfkgcy4p3cclfv378x7clxcj3l23jj7sckjbqkmdjbi72y134";
  };
  features_.adler32."1.0.4" = deps: f: updateFeatures f (rec {
    adler32."1.0.4".default = (f.adler32."1.0.4".default or true);
  }) [];


# end
# aho-corasick-0.7.6

  crates.aho_corasick."0.7.6" = deps: { features?(features_.aho_corasick."0.7.6" deps {}) }: buildRustCrate {
    crateName = "aho-corasick";
    version = "0.7.6";
    description = "Fast multiple substring searching.";
    authors = [ "Andrew Gallant <jamslam@gmail.com>" ];
    sha256 = "1srdggg7iawz7rfyb79qfnz6vmzkgl6g6gabyd9ad6pbx7zzj8gz";
    libName = "aho_corasick";
    dependencies = mapFeatures features ([
      (crates."memchr"."${deps."aho_corasick"."0.7.6"."memchr"}" deps)
    ]);
    features = mkFeatures (features."aho_corasick"."0.7.6" or {});
  };
  features_.aho_corasick."0.7.6" = deps: f: updateFeatures f (rec {
    aho_corasick = fold recursiveUpdate {} [
      { "0.7.6"."std" =
        (f.aho_corasick."0.7.6"."std" or false) ||
        (f.aho_corasick."0.7.6".default or false) ||
        (aho_corasick."0.7.6"."default" or false); }
      { "0.7.6".default = (f.aho_corasick."0.7.6".default or true); }
    ];
    memchr = fold recursiveUpdate {} [
      { "${deps.aho_corasick."0.7.6".memchr}"."use_std" =
        (f.memchr."${deps.aho_corasick."0.7.6".memchr}"."use_std" or false) ||
        (aho_corasick."0.7.6"."std" or false) ||
        (f."aho_corasick"."0.7.6"."std" or false); }
      { "${deps.aho_corasick."0.7.6".memchr}".default = (f.memchr."${deps.aho_corasick."0.7.6".memchr}".default or false); }
    ];
  }) [
    (features_.memchr."${deps."aho_corasick"."0.7.6"."memchr"}" deps)
  ];


# end
# ansi_term-0.11.0

  crates.ansi_term."0.11.0" = deps: { features?(features_.ansi_term."0.11.0" deps {}) }: buildRustCrate {
    crateName = "ansi_term";
    version = "0.11.0";
    description = "Library for ANSI terminal colours and styles (bold, underline)";
    authors = [ "ogham@bsago.me" "Ryan Scheel (Havvy) <ryan.havvy@gmail.com>" "Josh Triplett <josh@joshtriplett.org>" ];
    sha256 = "08fk0p2xvkqpmz3zlrwnf6l8sj2vngw464rvzspzp31sbgxbwm4v";
    dependencies = (if kernel == "windows" then mapFeatures features ([
      (crates."winapi"."${deps."ansi_term"."0.11.0"."winapi"}" deps)
    ]) else []);
  };
  features_.ansi_term."0.11.0" = deps: f: updateFeatures f (rec {
    ansi_term."0.11.0".default = (f.ansi_term."0.11.0".default or true);
    winapi = fold recursiveUpdate {} [
      { "${deps.ansi_term."0.11.0".winapi}"."consoleapi" = true; }
      { "${deps.ansi_term."0.11.0".winapi}"."errhandlingapi" = true; }
      { "${deps.ansi_term."0.11.0".winapi}"."processenv" = true; }
      { "${deps.ansi_term."0.11.0".winapi}".default = true; }
    ];
  }) [
    (features_.winapi."${deps."ansi_term"."0.11.0"."winapi"}" deps)
  ];


# end
# arrayvec-0.4.11

  crates.arrayvec."0.4.11" = deps: { features?(features_.arrayvec."0.4.11" deps {}) }: buildRustCrate {
    crateName = "arrayvec";
    version = "0.4.11";
    description = "A vector with fixed capacity, backed by an array (it can be stored on the stack too). Implements fixed capacity ArrayVec and ArrayString.";
    authors = [ "bluss" ];
    sha256 = "1bd08rakkyr9jlf538cs80s3ly464ni3afr63zlw860ndar1zfmv";
    dependencies = mapFeatures features ([
      (crates."nodrop"."${deps."arrayvec"."0.4.11"."nodrop"}" deps)
    ]);
    features = mkFeatures (features."arrayvec"."0.4.11" or {});
  };
  features_.arrayvec."0.4.11" = deps: f: updateFeatures f (rec {
    arrayvec = fold recursiveUpdate {} [
      { "0.4.11"."serde" =
        (f.arrayvec."0.4.11"."serde" or false) ||
        (f.arrayvec."0.4.11".serde-1 or false) ||
        (arrayvec."0.4.11"."serde-1" or false); }
      { "0.4.11"."std" =
        (f.arrayvec."0.4.11"."std" or false) ||
        (f.arrayvec."0.4.11".default or false) ||
        (arrayvec."0.4.11"."default" or false); }
      { "0.4.11".default = (f.arrayvec."0.4.11".default or true); }
    ];
    nodrop."${deps.arrayvec."0.4.11".nodrop}".default = (f.nodrop."${deps.arrayvec."0.4.11".nodrop}".default or false);
  }) [
    (features_.nodrop."${deps."arrayvec"."0.4.11"."nodrop"}" deps)
  ];


# end
# atty-0.2.13

  crates.atty."0.2.13" = deps: { features?(features_.atty."0.2.13" deps {}) }: buildRustCrate {
    crateName = "atty";
    version = "0.2.13";
    description = "A simple interface for querying atty";
    authors = [ "softprops <d.tangren@gmail.com>" ];
    sha256 = "0a1ii8h9fvvrq05bz7j135zjjz1sjz6n2invn2ngxqri0jxgmip2";
    dependencies = (if (kernel == "linux" || kernel == "darwin") then mapFeatures features ([
      (crates."libc"."${deps."atty"."0.2.13"."libc"}" deps)
    ]) else [])
      ++ (if kernel == "windows" then mapFeatures features ([
      (crates."winapi"."${deps."atty"."0.2.13"."winapi"}" deps)
    ]) else []);
  };
  features_.atty."0.2.13" = deps: f: updateFeatures f (rec {
    atty."0.2.13".default = (f.atty."0.2.13".default or true);
    libc."${deps.atty."0.2.13".libc}".default = (f.libc."${deps.atty."0.2.13".libc}".default or false);
    winapi = fold recursiveUpdate {} [
      { "${deps.atty."0.2.13".winapi}"."consoleapi" = true; }
      { "${deps.atty."0.2.13".winapi}"."minwinbase" = true; }
      { "${deps.atty."0.2.13".winapi}"."minwindef" = true; }
      { "${deps.atty."0.2.13".winapi}"."processenv" = true; }
      { "${deps.atty."0.2.13".winapi}"."winbase" = true; }
      { "${deps.atty."0.2.13".winapi}".default = true; }
    ];
  }) [
    (features_.libc."${deps."atty"."0.2.13"."libc"}" deps)
    (features_.winapi."${deps."atty"."0.2.13"."winapi"}" deps)
  ];


# end
# autocfg-0.1.6

  crates.autocfg."0.1.6" = deps: { features?(features_.autocfg."0.1.6" deps {}) }: buildRustCrate {
    crateName = "autocfg";
    version = "0.1.6";
    description = "Automatic cfg for Rust compiler features";
    authors = [ "Josh Stone <cuviper@gmail.com>" ];
    sha256 = "1yzawpsmrcy3x60i59hfwwg7mfdwc74199m2lgkc4vam5ijy8mz7";
  };
  features_.autocfg."0.1.6" = deps: f: updateFeatures f (rec {
    autocfg."0.1.6".default = (f.autocfg."0.1.6".default or true);
  }) [];


# end
# backtrace-0.3.38

  crates.backtrace."0.3.38" = deps: { features?(features_.backtrace."0.3.38" deps {}) }: buildRustCrate {
    crateName = "backtrace";
    version = "0.3.38";
    description = "A library to acquire a stack trace (backtrace) at runtime in a Rust program.\n";
    authors = [ "The Rust Project Developers" ];
    edition = "2018";
    sha256 = "0k41sw74xd19s9lsqab1rf94wi8l7ppfarib8hpd0y7q2iym5j41";
    dependencies = mapFeatures features ([
      (crates."cfg_if"."${deps."backtrace"."0.3.38"."cfg_if"}" deps)
      (crates."libc"."${deps."backtrace"."0.3.38"."libc"}" deps)
      (crates."rustc_demangle"."${deps."backtrace"."0.3.38"."rustc_demangle"}" deps)
    ]
      ++ (if features.backtrace."0.3.38".backtrace-sys or false then [ (crates.backtrace_sys."${deps."backtrace"."0.3.38".backtrace_sys}" deps) ] else []))
      ++ (if kernel == "windows" then mapFeatures features ([
]) else []);
    features = mkFeatures (features."backtrace"."0.3.38" or {});
  };
  features_.backtrace."0.3.38" = deps: f: updateFeatures f (rec {
    backtrace = fold recursiveUpdate {} [
      { "0.3.38"."addr2line" =
        (f.backtrace."0.3.38"."addr2line" or false) ||
        (f.backtrace."0.3.38".gimli-symbolize or false) ||
        (backtrace."0.3.38"."gimli-symbolize" or false); }
      { "0.3.38"."backtrace-sys" =
        (f.backtrace."0.3.38"."backtrace-sys" or false) ||
        (f.backtrace."0.3.38".libbacktrace or false) ||
        (backtrace."0.3.38"."libbacktrace" or false); }
      { "0.3.38"."compiler_builtins" =
        (f.backtrace."0.3.38"."compiler_builtins" or false) ||
        (f.backtrace."0.3.38".rustc-dep-of-std or false) ||
        (backtrace."0.3.38"."rustc-dep-of-std" or false); }
      { "0.3.38"."core" =
        (f.backtrace."0.3.38"."core" or false) ||
        (f.backtrace."0.3.38".rustc-dep-of-std or false) ||
        (backtrace."0.3.38"."rustc-dep-of-std" or false); }
      { "0.3.38"."dbghelp" =
        (f.backtrace."0.3.38"."dbghelp" or false) ||
        (f.backtrace."0.3.38".default or false) ||
        (backtrace."0.3.38"."default" or false); }
      { "0.3.38"."dladdr" =
        (f.backtrace."0.3.38"."dladdr" or false) ||
        (f.backtrace."0.3.38".default or false) ||
        (backtrace."0.3.38"."default" or false); }
      { "0.3.38"."findshlibs" =
        (f.backtrace."0.3.38"."findshlibs" or false) ||
        (f.backtrace."0.3.38".gimli-symbolize or false) ||
        (backtrace."0.3.38"."gimli-symbolize" or false); }
      { "0.3.38"."goblin" =
        (f.backtrace."0.3.38"."goblin" or false) ||
        (f.backtrace."0.3.38".gimli-symbolize or false) ||
        (backtrace."0.3.38"."gimli-symbolize" or false); }
      { "0.3.38"."libbacktrace" =
        (f.backtrace."0.3.38"."libbacktrace" or false) ||
        (f.backtrace."0.3.38".default or false) ||
        (backtrace."0.3.38"."default" or false); }
      { "0.3.38"."libunwind" =
        (f.backtrace."0.3.38"."libunwind" or false) ||
        (f.backtrace."0.3.38".default or false) ||
        (backtrace."0.3.38"."default" or false); }
      { "0.3.38"."memmap" =
        (f.backtrace."0.3.38"."memmap" or false) ||
        (f.backtrace."0.3.38".gimli-symbolize or false) ||
        (backtrace."0.3.38"."gimli-symbolize" or false); }
      { "0.3.38"."rustc-serialize" =
        (f.backtrace."0.3.38"."rustc-serialize" or false) ||
        (f.backtrace."0.3.38".serialize-rustc or false) ||
        (backtrace."0.3.38"."serialize-rustc" or false); }
      { "0.3.38"."serde" =
        (f.backtrace."0.3.38"."serde" or false) ||
        (f.backtrace."0.3.38".serialize-serde or false) ||
        (backtrace."0.3.38"."serialize-serde" or false); }
      { "0.3.38"."std" =
        (f.backtrace."0.3.38"."std" or false) ||
        (f.backtrace."0.3.38".default or false) ||
        (backtrace."0.3.38"."default" or false); }
      { "0.3.38".default = (f.backtrace."0.3.38".default or true); }
    ];
    backtrace_sys = fold recursiveUpdate {} [
      { "${deps.backtrace."0.3.38".backtrace_sys}"."rustc-dep-of-std" =
        (f.backtrace_sys."${deps.backtrace."0.3.38".backtrace_sys}"."rustc-dep-of-std" or false) ||
        (backtrace."0.3.38"."rustc-dep-of-std" or false) ||
        (f."backtrace"."0.3.38"."rustc-dep-of-std" or false); }
      { "${deps.backtrace."0.3.38".backtrace_sys}".default = true; }
    ];
    cfg_if = fold recursiveUpdate {} [
      { "${deps.backtrace."0.3.38".cfg_if}"."rustc-dep-of-std" =
        (f.cfg_if."${deps.backtrace."0.3.38".cfg_if}"."rustc-dep-of-std" or false) ||
        (backtrace."0.3.38"."rustc-dep-of-std" or false) ||
        (f."backtrace"."0.3.38"."rustc-dep-of-std" or false); }
      { "${deps.backtrace."0.3.38".cfg_if}".default = true; }
    ];
    libc = fold recursiveUpdate {} [
      { "${deps.backtrace."0.3.38".libc}"."rustc-dep-of-std" =
        (f.libc."${deps.backtrace."0.3.38".libc}"."rustc-dep-of-std" or false) ||
        (backtrace."0.3.38"."rustc-dep-of-std" or false) ||
        (f."backtrace"."0.3.38"."rustc-dep-of-std" or false); }
      { "${deps.backtrace."0.3.38".libc}".default = (f.libc."${deps.backtrace."0.3.38".libc}".default or false); }
    ];
    rustc_demangle = fold recursiveUpdate {} [
      { "${deps.backtrace."0.3.38".rustc_demangle}"."rustc-dep-of-std" =
        (f.rustc_demangle."${deps.backtrace."0.3.38".rustc_demangle}"."rustc-dep-of-std" or false) ||
        (backtrace."0.3.38"."rustc-dep-of-std" or false) ||
        (f."backtrace"."0.3.38"."rustc-dep-of-std" or false); }
      { "${deps.backtrace."0.3.38".rustc_demangle}".default = true; }
    ];
  }) [
    (features_.backtrace_sys."${deps."backtrace"."0.3.38"."backtrace_sys"}" deps)
    (features_.cfg_if."${deps."backtrace"."0.3.38"."cfg_if"}" deps)
    (features_.libc."${deps."backtrace"."0.3.38"."libc"}" deps)
    (features_.rustc_demangle."${deps."backtrace"."0.3.38"."rustc_demangle"}" deps)
  ];


# end
# backtrace-sys-0.1.31

  crates.backtrace_sys."0.1.31" = deps: { features?(features_.backtrace_sys."0.1.31" deps {}) }: buildRustCrate {
    crateName = "backtrace-sys";
    version = "0.1.31";
    description = "Bindings to the libbacktrace gcc library\n";
    authors = [ "Alex Crichton <alex@alexcrichton.com>" ];
    sha256 = "1gv41cypl4y5r32za4gx2fks43d76sp1r3yb5524i4gs50lrkypv";
    build = "build.rs";
    dependencies = mapFeatures features ([
      (crates."libc"."${deps."backtrace_sys"."0.1.31"."libc"}" deps)
    ]);

    buildDependencies = mapFeatures features ([
      (crates."cc"."${deps."backtrace_sys"."0.1.31"."cc"}" deps)
    ]);
    features = mkFeatures (features."backtrace_sys"."0.1.31" or {});
  };
  features_.backtrace_sys."0.1.31" = deps: f: updateFeatures f (rec {
    backtrace_sys = fold recursiveUpdate {} [
      { "0.1.31"."compiler_builtins" =
        (f.backtrace_sys."0.1.31"."compiler_builtins" or false) ||
        (f.backtrace_sys."0.1.31".rustc-dep-of-std or false) ||
        (backtrace_sys."0.1.31"."rustc-dep-of-std" or false); }
      { "0.1.31"."core" =
        (f.backtrace_sys."0.1.31"."core" or false) ||
        (f.backtrace_sys."0.1.31".rustc-dep-of-std or false) ||
        (backtrace_sys."0.1.31"."rustc-dep-of-std" or false); }
      { "0.1.31".default = (f.backtrace_sys."0.1.31".default or true); }
    ];
    cc."${deps.backtrace_sys."0.1.31".cc}".default = true;
    libc."${deps.backtrace_sys."0.1.31".libc}".default = (f.libc."${deps.backtrace_sys."0.1.31".libc}".default or false);
  }) [
    (features_.libc."${deps."backtrace_sys"."0.1.31"."libc"}" deps)
    (features_.cc."${deps."backtrace_sys"."0.1.31"."cc"}" deps)
  ];


# end
# base64-0.10.1

  crates.base64."0.10.1" = deps: { features?(features_.base64."0.10.1" deps {}) }: buildRustCrate {
    crateName = "base64";
    version = "0.10.1";
    description = "encodes and decodes base64 as bytes or utf8";
    authors = [ "Alice Maz <alice@alicemaz.com>" "Marshall Pierce <marshall@mpierce.org>" ];
    sha256 = "1zz3jq619hahla1f70ra38818b5n8cp4iilij81i90jq6z7hlfhg";
    dependencies = mapFeatures features ([
      (crates."byteorder"."${deps."base64"."0.10.1"."byteorder"}" deps)
    ]);
  };
  features_.base64."0.10.1" = deps: f: updateFeatures f (rec {
    base64."0.10.1".default = (f.base64."0.10.1".default or true);
    byteorder."${deps.base64."0.10.1".byteorder}".default = true;
  }) [
    (features_.byteorder."${deps."base64"."0.10.1"."byteorder"}" deps)
  ];


# end
# bit-set-0.5.1

  crates.bit_set."0.5.1" = deps: { features?(features_.bit_set."0.5.1" deps {}) }: buildRustCrate {
    crateName = "bit-set";
    version = "0.5.1";
    description = "A set of bits";
    authors = [ "Alexis Beingessner <a.beingessner@gmail.com>" ];
    sha256 = "1f6x1kv5bw1kkq3ms0vj6wf5jazq9390i23ywnjszm6h2x4qani1";
    dependencies = mapFeatures features ([
      (crates."bit_vec"."${deps."bit_set"."0.5.1"."bit_vec"}" deps)
    ]);
    features = mkFeatures (features."bit_set"."0.5.1" or {});
  };
  features_.bit_set."0.5.1" = deps: f: updateFeatures f (rec {
    bit_set = fold recursiveUpdate {} [
      { "0.5.1"."std" =
        (f.bit_set."0.5.1"."std" or false) ||
        (f.bit_set."0.5.1".default or false) ||
        (bit_set."0.5.1"."default" or false); }
      { "0.5.1".default = (f.bit_set."0.5.1".default or true); }
    ];
    bit_vec = fold recursiveUpdate {} [
      { "${deps.bit_set."0.5.1".bit_vec}"."nightly" =
        (f.bit_vec."${deps.bit_set."0.5.1".bit_vec}"."nightly" or false) ||
        (bit_set."0.5.1"."nightly" or false) ||
        (f."bit_set"."0.5.1"."nightly" or false); }
      { "${deps.bit_set."0.5.1".bit_vec}"."std" =
        (f.bit_vec."${deps.bit_set."0.5.1".bit_vec}"."std" or false) ||
        (bit_set."0.5.1"."std" or false) ||
        (f."bit_set"."0.5.1"."std" or false); }
      { "${deps.bit_set."0.5.1".bit_vec}".default = (f.bit_vec."${deps.bit_set."0.5.1".bit_vec}".default or false); }
    ];
  }) [
    (features_.bit_vec."${deps."bit_set"."0.5.1"."bit_vec"}" deps)
  ];


# end
# bit-vec-0.5.1

  crates.bit_vec."0.5.1" = deps: { features?(features_.bit_vec."0.5.1" deps {}) }: buildRustCrate {
    crateName = "bit-vec";
    version = "0.5.1";
    description = "A vector of bits";
    authors = [ "Alexis Beingessner <a.beingessner@gmail.com>" ];
    sha256 = "1irsn05qn4c7rd903ph69xvsa69b36mj76fl5n2nvjd847cw7ypa";
    features = mkFeatures (features."bit_vec"."0.5.1" or {});
  };
  features_.bit_vec."0.5.1" = deps: f: updateFeatures f (rec {
    bit_vec = fold recursiveUpdate {} [
      { "0.5.1"."std" =
        (f.bit_vec."0.5.1"."std" or false) ||
        (f.bit_vec."0.5.1".default or false) ||
        (bit_vec."0.5.1"."default" or false); }
      { "0.5.1".default = (f.bit_vec."0.5.1".default or true); }
    ];
  }) [];


# end
# bitflags-1.2.0

  crates.bitflags."1.2.0" = deps: { features?(features_.bitflags."1.2.0" deps {}) }: buildRustCrate {
    crateName = "bitflags";
    version = "1.2.0";
    description = "A macro to generate structures which behave like bitflags.\n";
    authors = [ "The Rust Project Developers" ];
    sha256 = "0cybfqfkplbznkvm0cjn6wv7vpp718i47ld4g84qrb0lwa0jpmcg";
    build = "build.rs";
    features = mkFeatures (features."bitflags"."1.2.0" or {});
  };
  features_.bitflags."1.2.0" = deps: f: updateFeatures f (rec {
    bitflags."1.2.0".default = (f.bitflags."1.2.0".default or true);
  }) [];


# end
# byteorder-1.3.2

  crates.byteorder."1.3.2" = deps: { features?(features_.byteorder."1.3.2" deps {}) }: buildRustCrate {
    crateName = "byteorder";
    version = "1.3.2";
    description = "Library for reading/writing numbers in big-endian and little-endian.";
    authors = [ "Andrew Gallant <jamslam@gmail.com>" ];
    sha256 = "099fxwc79ncpcl8dgg9hql8gznz11a3sjs7pai0mg6w8r05khvdx";
    build = "build.rs";
    features = mkFeatures (features."byteorder"."1.3.2" or {});
  };
  features_.byteorder."1.3.2" = deps: f: updateFeatures f (rec {
    byteorder = fold recursiveUpdate {} [
      { "1.3.2"."std" =
        (f.byteorder."1.3.2"."std" or false) ||
        (f.byteorder."1.3.2".default or false) ||
        (byteorder."1.3.2"."default" or false); }
      { "1.3.2".default = (f.byteorder."1.3.2".default or true); }
    ];
  }) [];


# end
# bytes-0.4.12

  crates.bytes."0.4.12" = deps: { features?(features_.bytes."0.4.12" deps {}) }: buildRustCrate {
    crateName = "bytes";
    version = "0.4.12";
    description = "Types and traits for working with bytes";
    authors = [ "Carl Lerche <me@carllerche.com>" ];
    sha256 = "0cw577vll9qp0h3l1sy24anr5mcnd5j26q9q7nw4f0mddssvfphf";
    dependencies = mapFeatures features ([
      (crates."byteorder"."${deps."bytes"."0.4.12"."byteorder"}" deps)
      (crates."iovec"."${deps."bytes"."0.4.12"."iovec"}" deps)
    ]
      ++ (if features.bytes."0.4.12".either or false then [ (crates.either."${deps."bytes"."0.4.12".either}" deps) ] else []));
    features = mkFeatures (features."bytes"."0.4.12" or {});
  };
  features_.bytes."0.4.12" = deps: f: updateFeatures f (rec {
    byteorder = fold recursiveUpdate {} [
      { "${deps.bytes."0.4.12".byteorder}"."i128" =
        (f.byteorder."${deps.bytes."0.4.12".byteorder}"."i128" or false) ||
        (bytes."0.4.12"."i128" or false) ||
        (f."bytes"."0.4.12"."i128" or false); }
      { "${deps.bytes."0.4.12".byteorder}".default = true; }
    ];
    bytes."0.4.12".default = (f.bytes."0.4.12".default or true);
    either."${deps.bytes."0.4.12".either}".default = (f.either."${deps.bytes."0.4.12".either}".default or false);
    iovec."${deps.bytes."0.4.12".iovec}".default = true;
  }) [
    (features_.byteorder."${deps."bytes"."0.4.12"."byteorder"}" deps)
    (features_.either."${deps."bytes"."0.4.12"."either"}" deps)
    (features_.iovec."${deps."bytes"."0.4.12"."iovec"}" deps)
  ];


# end
# c2-chacha-0.2.2

  crates.c2_chacha."0.2.2" = deps: { features?(features_.c2_chacha."0.2.2" deps {}) }: buildRustCrate {
    crateName = "c2-chacha";
    version = "0.2.2";
    description = "The ChaCha family of stream ciphers";
    authors = [ "The CryptoCorrosion Contributors" ];
    edition = "2018";
    sha256 = "1lcfazshbiw8kdpcgphlmls0mz5j4wnvsq1diaz4b2bcvgm3r2cn";
    dependencies = mapFeatures features ([
      (crates."ppv_lite86"."${deps."c2_chacha"."0.2.2"."ppv_lite86"}" deps)
    ]
      ++ (if features.c2_chacha."0.2.2".lazy_static or false then [ (crates.lazy_static."${deps."c2_chacha"."0.2.2".lazy_static}" deps) ] else []));
    features = mkFeatures (features."c2_chacha"."0.2.2" or {});
  };
  features_.c2_chacha."0.2.2" = deps: f: updateFeatures f (rec {
    c2_chacha = fold recursiveUpdate {} [
      { "0.2.2"."byteorder" =
        (f.c2_chacha."0.2.2"."byteorder" or false) ||
        (f.c2_chacha."0.2.2".rustcrypto_api or false) ||
        (c2_chacha."0.2.2"."rustcrypto_api" or false); }
      { "0.2.2"."lazy_static" =
        (f.c2_chacha."0.2.2"."lazy_static" or false) ||
        (f.c2_chacha."0.2.2".std or false) ||
        (c2_chacha."0.2.2"."std" or false); }
      { "0.2.2"."rustcrypto_api" =
        (f.c2_chacha."0.2.2"."rustcrypto_api" or false) ||
        (f.c2_chacha."0.2.2".default or false) ||
        (c2_chacha."0.2.2"."default" or false); }
      { "0.2.2"."simd" =
        (f.c2_chacha."0.2.2"."simd" or false) ||
        (f.c2_chacha."0.2.2".default or false) ||
        (c2_chacha."0.2.2"."default" or false); }
      { "0.2.2"."std" =
        (f.c2_chacha."0.2.2"."std" or false) ||
        (f.c2_chacha."0.2.2".default or false) ||
        (c2_chacha."0.2.2"."default" or false); }
      { "0.2.2"."stream-cipher" =
        (f.c2_chacha."0.2.2"."stream-cipher" or false) ||
        (f.c2_chacha."0.2.2".rustcrypto_api or false) ||
        (c2_chacha."0.2.2"."rustcrypto_api" or false); }
      { "0.2.2".default = (f.c2_chacha."0.2.2".default or true); }
    ];
    lazy_static."${deps.c2_chacha."0.2.2".lazy_static}".default = true;
    ppv_lite86 = fold recursiveUpdate {} [
      { "${deps.c2_chacha."0.2.2".ppv_lite86}"."simd" =
        (f.ppv_lite86."${deps.c2_chacha."0.2.2".ppv_lite86}"."simd" or false) ||
        (c2_chacha."0.2.2"."simd" or false) ||
        (f."c2_chacha"."0.2.2"."simd" or false); }
      { "${deps.c2_chacha."0.2.2".ppv_lite86}".default = true; }
    ];
  }) [
    (features_.lazy_static."${deps."c2_chacha"."0.2.2"."lazy_static"}" deps)
    (features_.ppv_lite86."${deps."c2_chacha"."0.2.2"."ppv_lite86"}" deps)
  ];


# end
# cc-1.0.45

  crates.cc."1.0.45" = deps: { features?(features_.cc."1.0.45" deps {}) }: buildRustCrate {
    crateName = "cc";
    version = "1.0.45";
    description = "A build-time dependency for Cargo build scripts to assist in invoking the native\nC compiler to compile native C code into a static archive to be linked into Rust\ncode.\n";
    authors = [ "Alex Crichton <alex@alexcrichton.com>" ];
    edition = "2018";
    sha256 = "0qhw9k5av9x6yvv4jfrji576wy90vgdnr76cifs8xqm70scdl2sm";
    dependencies = mapFeatures features ([
]);
    features = mkFeatures (features."cc"."1.0.45" or {});
  };
  features_.cc."1.0.45" = deps: f: updateFeatures f (rec {
    cc = fold recursiveUpdate {} [
      { "1.0.45"."jobserver" =
        (f.cc."1.0.45"."jobserver" or false) ||
        (f.cc."1.0.45".parallel or false) ||
        (cc."1.0.45"."parallel" or false); }
      { "1.0.45"."num_cpus" =
        (f.cc."1.0.45"."num_cpus" or false) ||
        (f.cc."1.0.45".parallel or false) ||
        (cc."1.0.45"."parallel" or false); }
      { "1.0.45".default = (f.cc."1.0.45".default or true); }
    ];
  }) [];


# end
# cfg-if-0.1.10

  crates.cfg_if."0.1.10" = deps: { features?(features_.cfg_if."0.1.10" deps {}) }: buildRustCrate {
    crateName = "cfg-if";
    version = "0.1.10";
    description = "A macro to ergonomically define an item depending on a large number of #[cfg]\nparameters. Structured like an if-else chain, the first matching branch is the\nitem that gets emitted.\n";
    authors = [ "Alex Crichton <alex@alexcrichton.com>" ];
    edition = "2018";
    sha256 = "0x52qzpbyl2f2jqs7kkqzgfki2cpq99gpfjjigdp8pwwfqk01007";
    dependencies = mapFeatures features ([
]);
    features = mkFeatures (features."cfg_if"."0.1.10" or {});
  };
  features_.cfg_if."0.1.10" = deps: f: updateFeatures f (rec {
    cfg_if = fold recursiveUpdate {} [
      { "0.1.10"."compiler_builtins" =
        (f.cfg_if."0.1.10"."compiler_builtins" or false) ||
        (f.cfg_if."0.1.10".rustc-dep-of-std or false) ||
        (cfg_if."0.1.10"."rustc-dep-of-std" or false); }
      { "0.1.10"."core" =
        (f.cfg_if."0.1.10"."core" or false) ||
        (f.cfg_if."0.1.10".rustc-dep-of-std or false) ||
        (cfg_if."0.1.10"."rustc-dep-of-std" or false); }
      { "0.1.10".default = (f.cfg_if."0.1.10".default or true); }
    ];
  }) [];


# end
# clap-2.33.0

  crates.clap."2.33.0" = deps: { features?(features_.clap."2.33.0" deps {}) }: buildRustCrate {
    crateName = "clap";
    version = "2.33.0";
    description = "A simple to use, efficient, and full-featured Command Line Argument Parser\n";
    authors = [ "Kevin K. <kbknapp@gmail.com>" ];
    sha256 = "054n9ngh6pkknpmd4acgdsp40iw6f5jzq8a4h2b76gnbvk6p5xjh";
    dependencies = mapFeatures features ([
      (crates."bitflags"."${deps."clap"."2.33.0"."bitflags"}" deps)
      (crates."textwrap"."${deps."clap"."2.33.0"."textwrap"}" deps)
      (crates."unicode_width"."${deps."clap"."2.33.0"."unicode_width"}" deps)
    ]
      ++ (if features.clap."2.33.0".atty or false then [ (crates.atty."${deps."clap"."2.33.0".atty}" deps) ] else [])
      ++ (if features.clap."2.33.0".strsim or false then [ (crates.strsim."${deps."clap"."2.33.0".strsim}" deps) ] else [])
      ++ (if features.clap."2.33.0".vec_map or false then [ (crates.vec_map."${deps."clap"."2.33.0".vec_map}" deps) ] else []))
      ++ (if !(kernel == "windows") then mapFeatures features ([
    ]
      ++ (if features.clap."2.33.0".ansi_term or false then [ (crates.ansi_term."${deps."clap"."2.33.0".ansi_term}" deps) ] else [])) else []);
    features = mkFeatures (features."clap"."2.33.0" or {});
  };
  features_.clap."2.33.0" = deps: f: updateFeatures f (rec {
    ansi_term."${deps.clap."2.33.0".ansi_term}".default = true;
    atty."${deps.clap."2.33.0".atty}".default = true;
    bitflags."${deps.clap."2.33.0".bitflags}".default = true;
    clap = fold recursiveUpdate {} [
      { "2.33.0"."ansi_term" =
        (f.clap."2.33.0"."ansi_term" or false) ||
        (f.clap."2.33.0".color or false) ||
        (clap."2.33.0"."color" or false); }
      { "2.33.0"."atty" =
        (f.clap."2.33.0"."atty" or false) ||
        (f.clap."2.33.0".color or false) ||
        (clap."2.33.0"."color" or false); }
      { "2.33.0"."clippy" =
        (f.clap."2.33.0"."clippy" or false) ||
        (f.clap."2.33.0".lints or false) ||
        (clap."2.33.0"."lints" or false); }
      { "2.33.0"."color" =
        (f.clap."2.33.0"."color" or false) ||
        (f.clap."2.33.0".default or false) ||
        (clap."2.33.0"."default" or false); }
      { "2.33.0"."strsim" =
        (f.clap."2.33.0"."strsim" or false) ||
        (f.clap."2.33.0".suggestions or false) ||
        (clap."2.33.0"."suggestions" or false); }
      { "2.33.0"."suggestions" =
        (f.clap."2.33.0"."suggestions" or false) ||
        (f.clap."2.33.0".default or false) ||
        (clap."2.33.0"."default" or false); }
      { "2.33.0"."term_size" =
        (f.clap."2.33.0"."term_size" or false) ||
        (f.clap."2.33.0".wrap_help or false) ||
        (clap."2.33.0"."wrap_help" or false); }
      { "2.33.0"."vec_map" =
        (f.clap."2.33.0"."vec_map" or false) ||
        (f.clap."2.33.0".default or false) ||
        (clap."2.33.0"."default" or false); }
      { "2.33.0"."yaml" =
        (f.clap."2.33.0"."yaml" or false) ||
        (f.clap."2.33.0".doc or false) ||
        (clap."2.33.0"."doc" or false); }
      { "2.33.0"."yaml-rust" =
        (f.clap."2.33.0"."yaml-rust" or false) ||
        (f.clap."2.33.0".yaml or false) ||
        (clap."2.33.0"."yaml" or false); }
      { "2.33.0".default = (f.clap."2.33.0".default or true); }
    ];
    strsim."${deps.clap."2.33.0".strsim}".default = true;
    textwrap = fold recursiveUpdate {} [
      { "${deps.clap."2.33.0".textwrap}"."term_size" =
        (f.textwrap."${deps.clap."2.33.0".textwrap}"."term_size" or false) ||
        (clap."2.33.0"."wrap_help" or false) ||
        (f."clap"."2.33.0"."wrap_help" or false); }
      { "${deps.clap."2.33.0".textwrap}".default = true; }
    ];
    unicode_width."${deps.clap."2.33.0".unicode_width}".default = true;
    vec_map."${deps.clap."2.33.0".vec_map}".default = true;
  }) [
    (features_.atty."${deps."clap"."2.33.0"."atty"}" deps)
    (features_.bitflags."${deps."clap"."2.33.0"."bitflags"}" deps)
    (features_.strsim."${deps."clap"."2.33.0"."strsim"}" deps)
    (features_.textwrap."${deps."clap"."2.33.0"."textwrap"}" deps)
    (features_.unicode_width."${deps."clap"."2.33.0"."unicode_width"}" deps)
    (features_.vec_map."${deps."clap"."2.33.0"."vec_map"}" deps)
    (features_.ansi_term."${deps."clap"."2.33.0"."ansi_term"}" deps)
  ];


# end
# cloudabi-0.0.3

  crates.cloudabi."0.0.3" = deps: { features?(features_.cloudabi."0.0.3" deps {}) }: buildRustCrate {
    crateName = "cloudabi";
    version = "0.0.3";
    description = "Low level interface to CloudABI. Contains all syscalls and related types.";
    authors = [ "Nuxi (https://nuxi.nl/) and contributors" ];
    sha256 = "1z9lby5sr6vslfd14d6igk03s7awf91mxpsfmsp3prxbxlk0x7h5";
    libPath = "cloudabi.rs";
    dependencies = mapFeatures features ([
    ]
      ++ (if features.cloudabi."0.0.3".bitflags or false then [ (crates.bitflags."${deps."cloudabi"."0.0.3".bitflags}" deps) ] else []));
    features = mkFeatures (features."cloudabi"."0.0.3" or {});
  };
  features_.cloudabi."0.0.3" = deps: f: updateFeatures f (rec {
    bitflags."${deps.cloudabi."0.0.3".bitflags}".default = true;
    cloudabi = fold recursiveUpdate {} [
      { "0.0.3"."bitflags" =
        (f.cloudabi."0.0.3"."bitflags" or false) ||
        (f.cloudabi."0.0.3".default or false) ||
        (cloudabi."0.0.3"."default" or false); }
      { "0.0.3".default = (f.cloudabi."0.0.3".default or true); }
    ];
  }) [
    (features_.bitflags."${deps."cloudabi"."0.0.3"."bitflags"}" deps)
  ];


# end
# cookie-0.12.0

  crates.cookie."0.12.0" = deps: { features?(features_.cookie."0.12.0" deps {}) }: buildRustCrate {
    crateName = "cookie";
    version = "0.12.0";
    description = "Crate for parsing HTTP cookie headers and managing a cookie jar. Supports signed\nand private (encrypted + signed) jars.\n";
    authors = [ "Alex Crichton <alex@alexcrichton.com>" "Sergio Benitez <sb@sergio.bz>" ];
    sha256 = "0gqz78qlza819xakvakjzlk95bizj48x0aba6819z92777vb5y7g";
    dependencies = mapFeatures features ([
      (crates."time"."${deps."cookie"."0.12.0"."time"}" deps)
    ]
      ++ (if features.cookie."0.12.0".url or false then [ (crates.url."${deps."cookie"."0.12.0".url}" deps) ] else []));
    features = mkFeatures (features."cookie"."0.12.0" or {});
  };
  features_.cookie."0.12.0" = deps: f: updateFeatures f (rec {
    cookie = fold recursiveUpdate {} [
      { "0.12.0"."base64" =
        (f.cookie."0.12.0"."base64" or false) ||
        (f.cookie."0.12.0".secure or false) ||
        (cookie."0.12.0"."secure" or false); }
      { "0.12.0"."ring" =
        (f.cookie."0.12.0"."ring" or false) ||
        (f.cookie."0.12.0".secure or false) ||
        (cookie."0.12.0"."secure" or false); }
      { "0.12.0"."url" =
        (f.cookie."0.12.0"."url" or false) ||
        (f.cookie."0.12.0".percent-encode or false) ||
        (cookie."0.12.0"."percent-encode" or false); }
      { "0.12.0".default = (f.cookie."0.12.0".default or true); }
    ];
    time."${deps.cookie."0.12.0".time}".default = true;
    url."${deps.cookie."0.12.0".url}".default = true;
  }) [
    (features_.time."${deps."cookie"."0.12.0"."time"}" deps)
    (features_.url."${deps."cookie"."0.12.0"."url"}" deps)
  ];


# end
# cookie_store-0.7.0

  crates.cookie_store."0.7.0" = deps: { features?(features_.cookie_store."0.7.0" deps {}) }: buildRustCrate {
    crateName = "cookie_store";
    version = "0.7.0";
    description = "Implementation of Cookie storage and retrieval per [RFC6265](http://tools.ietf.org/html/rfc6265)";
    authors = [ "patrick.fernie@gmail.com" ];
    edition = "2018";
    sha256 = "07wycaaplf613hcz4p54xn1s4l2fwhm0yy5xfr6fsfm17p3pkxln";
    dependencies = mapFeatures features ([
      (crates."cookie"."${deps."cookie_store"."0.7.0"."cookie"}" deps)
      (crates."failure"."${deps."cookie_store"."0.7.0"."failure"}" deps)
      (crates."idna"."${deps."cookie_store"."0.7.0"."idna"}" deps)
      (crates."log"."${deps."cookie_store"."0.7.0"."log"}" deps)
      (crates."publicsuffix"."${deps."cookie_store"."0.7.0"."publicsuffix"}" deps)
      (crates."serde"."${deps."cookie_store"."0.7.0"."serde"}" deps)
      (crates."serde_json"."${deps."cookie_store"."0.7.0"."serde_json"}" deps)
      (crates."time"."${deps."cookie_store"."0.7.0"."time"}" deps)
      (crates."try_from"."${deps."cookie_store"."0.7.0"."try_from"}" deps)
      (crates."url"."${deps."cookie_store"."0.7.0"."url"}" deps)
    ]);
  };
  features_.cookie_store."0.7.0" = deps: f: updateFeatures f (rec {
    cookie = fold recursiveUpdate {} [
      { "${deps.cookie_store."0.7.0".cookie}"."percent-encode" = true; }
      { "${deps.cookie_store."0.7.0".cookie}".default = true; }
    ];
    cookie_store."0.7.0".default = (f.cookie_store."0.7.0".default or true);
    failure."${deps.cookie_store."0.7.0".failure}".default = true;
    idna."${deps.cookie_store."0.7.0".idna}".default = true;
    log."${deps.cookie_store."0.7.0".log}".default = true;
    publicsuffix."${deps.cookie_store."0.7.0".publicsuffix}".default = (f.publicsuffix."${deps.cookie_store."0.7.0".publicsuffix}".default or false);
    serde = fold recursiveUpdate {} [
      { "${deps.cookie_store."0.7.0".serde}"."derive" = true; }
      { "${deps.cookie_store."0.7.0".serde}".default = true; }
    ];
    serde_json."${deps.cookie_store."0.7.0".serde_json}".default = true;
    time."${deps.cookie_store."0.7.0".time}".default = true;
    try_from."${deps.cookie_store."0.7.0".try_from}".default = true;
    url."${deps.cookie_store."0.7.0".url}".default = true;
  }) [
    (features_.cookie."${deps."cookie_store"."0.7.0"."cookie"}" deps)
    (features_.failure."${deps."cookie_store"."0.7.0"."failure"}" deps)
    (features_.idna."${deps."cookie_store"."0.7.0"."idna"}" deps)
    (features_.log."${deps."cookie_store"."0.7.0"."log"}" deps)
    (features_.publicsuffix."${deps."cookie_store"."0.7.0"."publicsuffix"}" deps)
    (features_.serde."${deps."cookie_store"."0.7.0"."serde"}" deps)
    (features_.serde_json."${deps."cookie_store"."0.7.0"."serde_json"}" deps)
    (features_.time."${deps."cookie_store"."0.7.0"."time"}" deps)
    (features_.try_from."${deps."cookie_store"."0.7.0"."try_from"}" deps)
    (features_.url."${deps."cookie_store"."0.7.0"."url"}" deps)
  ];


# end
# core-foundation-0.6.4

  crates.core_foundation."0.6.4" = deps: { features?(features_.core_foundation."0.6.4" deps {}) }: buildRustCrate {
    crateName = "core-foundation";
    version = "0.6.4";
    description = "Bindings to Core Foundation for macOS";
    authors = [ "The Servo Project Developers" ];
    sha256 = "1kabsqxh01m6l2b1gz8wgn0d1k6fyczww9kaks0sbmsz5g78ngzx";
    dependencies = mapFeatures features ([
      (crates."core_foundation_sys"."${deps."core_foundation"."0.6.4"."core_foundation_sys"}" deps)
      (crates."libc"."${deps."core_foundation"."0.6.4"."libc"}" deps)
    ]);
    features = mkFeatures (features."core_foundation"."0.6.4" or {});
  };
  features_.core_foundation."0.6.4" = deps: f: updateFeatures f (rec {
    core_foundation = fold recursiveUpdate {} [
      { "0.6.4"."chrono" =
        (f.core_foundation."0.6.4"."chrono" or false) ||
        (f.core_foundation."0.6.4".with-chrono or false) ||
        (core_foundation."0.6.4"."with-chrono" or false); }
      { "0.6.4"."uuid" =
        (f.core_foundation."0.6.4"."uuid" or false) ||
        (f.core_foundation."0.6.4".with-uuid or false) ||
        (core_foundation."0.6.4"."with-uuid" or false); }
      { "0.6.4".default = (f.core_foundation."0.6.4".default or true); }
    ];
    core_foundation_sys = fold recursiveUpdate {} [
      { "${deps.core_foundation."0.6.4".core_foundation_sys}"."mac_os_10_7_support" =
        (f.core_foundation_sys."${deps.core_foundation."0.6.4".core_foundation_sys}"."mac_os_10_7_support" or false) ||
        (core_foundation."0.6.4"."mac_os_10_7_support" or false) ||
        (f."core_foundation"."0.6.4"."mac_os_10_7_support" or false); }
      { "${deps.core_foundation."0.6.4".core_foundation_sys}"."mac_os_10_8_features" =
        (f.core_foundation_sys."${deps.core_foundation."0.6.4".core_foundation_sys}"."mac_os_10_8_features" or false) ||
        (core_foundation."0.6.4"."mac_os_10_8_features" or false) ||
        (f."core_foundation"."0.6.4"."mac_os_10_8_features" or false); }
      { "${deps.core_foundation."0.6.4".core_foundation_sys}".default = true; }
    ];
    libc."${deps.core_foundation."0.6.4".libc}".default = true;
  }) [
    (features_.core_foundation_sys."${deps."core_foundation"."0.6.4"."core_foundation_sys"}" deps)
    (features_.libc."${deps."core_foundation"."0.6.4"."libc"}" deps)
  ];


# end
# core-foundation-sys-0.6.2

  crates.core_foundation_sys."0.6.2" = deps: { features?(features_.core_foundation_sys."0.6.2" deps {}) }: buildRustCrate {
    crateName = "core-foundation-sys";
    version = "0.6.2";
    description = "Bindings to Core Foundation for OS X";
    authors = [ "The Servo Project Developers" ];
    sha256 = "1n2v6wlqkmqwhl7k6y50irx51p37xb0fcm3njbman82gnyq8di2c";
    build = "build.rs";
    features = mkFeatures (features."core_foundation_sys"."0.6.2" or {});
  };
  features_.core_foundation_sys."0.6.2" = deps: f: updateFeatures f (rec {
    core_foundation_sys."0.6.2".default = (f.core_foundation_sys."0.6.2".default or true);
  }) [];


# end
# crc32fast-1.2.0

  crates.crc32fast."1.2.0" = deps: { features?(features_.crc32fast."1.2.0" deps {}) }: buildRustCrate {
    crateName = "crc32fast";
    version = "1.2.0";
    description = "Fast, SIMD-accelerated CRC32 (IEEE) checksum computation";
    authors = [ "Sam Rijs <srijs@airpost.net>" "Alex Crichton <alex@alexcrichton.com>" ];
    sha256 = "1mx88ndqln6vzg7hjhjp8b7g0qggpqggsjrlsdqrfsrbpdzffcn8";
    dependencies = mapFeatures features ([
      (crates."cfg_if"."${deps."crc32fast"."1.2.0"."cfg_if"}" deps)
    ]);
    features = mkFeatures (features."crc32fast"."1.2.0" or {});
  };
  features_.crc32fast."1.2.0" = deps: f: updateFeatures f (rec {
    cfg_if."${deps.crc32fast."1.2.0".cfg_if}".default = true;
    crc32fast = fold recursiveUpdate {} [
      { "1.2.0"."std" =
        (f.crc32fast."1.2.0"."std" or false) ||
        (f.crc32fast."1.2.0".default or false) ||
        (crc32fast."1.2.0"."default" or false); }
      { "1.2.0".default = (f.crc32fast."1.2.0".default or true); }
    ];
  }) [
    (features_.cfg_if."${deps."crc32fast"."1.2.0"."cfg_if"}" deps)
  ];


# end
# crossbeam-deque-0.7.1

  crates.crossbeam_deque."0.7.1" = deps: { features?(features_.crossbeam_deque."0.7.1" deps {}) }: buildRustCrate {
    crateName = "crossbeam-deque";
    version = "0.7.1";
    description = "Concurrent work-stealing deque";
    authors = [ "The Crossbeam Project Developers" ];
    sha256 = "11l7idrx3diksrxbaa13f9h9i6f3456qq3647f3kglxfjmz9bm8s";
    dependencies = mapFeatures features ([
      (crates."crossbeam_epoch"."${deps."crossbeam_deque"."0.7.1"."crossbeam_epoch"}" deps)
      (crates."crossbeam_utils"."${deps."crossbeam_deque"."0.7.1"."crossbeam_utils"}" deps)
    ]);
  };
  features_.crossbeam_deque."0.7.1" = deps: f: updateFeatures f (rec {
    crossbeam_deque."0.7.1".default = (f.crossbeam_deque."0.7.1".default or true);
    crossbeam_epoch."${deps.crossbeam_deque."0.7.1".crossbeam_epoch}".default = true;
    crossbeam_utils."${deps.crossbeam_deque."0.7.1".crossbeam_utils}".default = true;
  }) [
    (features_.crossbeam_epoch."${deps."crossbeam_deque"."0.7.1"."crossbeam_epoch"}" deps)
    (features_.crossbeam_utils."${deps."crossbeam_deque"."0.7.1"."crossbeam_utils"}" deps)
  ];


# end
# crossbeam-epoch-0.7.2

  crates.crossbeam_epoch."0.7.2" = deps: { features?(features_.crossbeam_epoch."0.7.2" deps {}) }: buildRustCrate {
    crateName = "crossbeam-epoch";
    version = "0.7.2";
    description = "Epoch-based garbage collection";
    authors = [ "The Crossbeam Project Developers" ];
    sha256 = "015axh69r6ggj481ncqj09d7ssbqf8psgyqq9hhpkrh3j7xn4vmn";
    dependencies = mapFeatures features ([
      (crates."arrayvec"."${deps."crossbeam_epoch"."0.7.2"."arrayvec"}" deps)
      (crates."cfg_if"."${deps."crossbeam_epoch"."0.7.2"."cfg_if"}" deps)
      (crates."crossbeam_utils"."${deps."crossbeam_epoch"."0.7.2"."crossbeam_utils"}" deps)
      (crates."memoffset"."${deps."crossbeam_epoch"."0.7.2"."memoffset"}" deps)
      (crates."scopeguard"."${deps."crossbeam_epoch"."0.7.2"."scopeguard"}" deps)
    ]
      ++ (if features.crossbeam_epoch."0.7.2".lazy_static or false then [ (crates.lazy_static."${deps."crossbeam_epoch"."0.7.2".lazy_static}" deps) ] else []));
    features = mkFeatures (features."crossbeam_epoch"."0.7.2" or {});
  };
  features_.crossbeam_epoch."0.7.2" = deps: f: updateFeatures f (rec {
    arrayvec = fold recursiveUpdate {} [
      { "${deps.crossbeam_epoch."0.7.2".arrayvec}"."use_union" =
        (f.arrayvec."${deps.crossbeam_epoch."0.7.2".arrayvec}"."use_union" or false) ||
        (crossbeam_epoch."0.7.2"."nightly" or false) ||
        (f."crossbeam_epoch"."0.7.2"."nightly" or false); }
      { "${deps.crossbeam_epoch."0.7.2".arrayvec}".default = (f.arrayvec."${deps.crossbeam_epoch."0.7.2".arrayvec}".default or false); }
    ];
    cfg_if."${deps.crossbeam_epoch."0.7.2".cfg_if}".default = true;
    crossbeam_epoch = fold recursiveUpdate {} [
      { "0.7.2"."lazy_static" =
        (f.crossbeam_epoch."0.7.2"."lazy_static" or false) ||
        (f.crossbeam_epoch."0.7.2".std or false) ||
        (crossbeam_epoch."0.7.2"."std" or false); }
      { "0.7.2"."std" =
        (f.crossbeam_epoch."0.7.2"."std" or false) ||
        (f.crossbeam_epoch."0.7.2".default or false) ||
        (crossbeam_epoch."0.7.2"."default" or false); }
      { "0.7.2".default = (f.crossbeam_epoch."0.7.2".default or true); }
    ];
    crossbeam_utils = fold recursiveUpdate {} [
      { "${deps.crossbeam_epoch."0.7.2".crossbeam_utils}"."alloc" =
        (f.crossbeam_utils."${deps.crossbeam_epoch."0.7.2".crossbeam_utils}"."alloc" or false) ||
        (crossbeam_epoch."0.7.2"."alloc" or false) ||
        (f."crossbeam_epoch"."0.7.2"."alloc" or false); }
      { "${deps.crossbeam_epoch."0.7.2".crossbeam_utils}"."nightly" =
        (f.crossbeam_utils."${deps.crossbeam_epoch."0.7.2".crossbeam_utils}"."nightly" or false) ||
        (crossbeam_epoch."0.7.2"."nightly" or false) ||
        (f."crossbeam_epoch"."0.7.2"."nightly" or false); }
      { "${deps.crossbeam_epoch."0.7.2".crossbeam_utils}"."std" =
        (f.crossbeam_utils."${deps.crossbeam_epoch."0.7.2".crossbeam_utils}"."std" or false) ||
        (crossbeam_epoch."0.7.2"."std" or false) ||
        (f."crossbeam_epoch"."0.7.2"."std" or false); }
      { "${deps.crossbeam_epoch."0.7.2".crossbeam_utils}".default = (f.crossbeam_utils."${deps.crossbeam_epoch."0.7.2".crossbeam_utils}".default or false); }
    ];
    lazy_static."${deps.crossbeam_epoch."0.7.2".lazy_static}".default = true;
    memoffset."${deps.crossbeam_epoch."0.7.2".memoffset}".default = true;
    scopeguard."${deps.crossbeam_epoch."0.7.2".scopeguard}".default = (f.scopeguard."${deps.crossbeam_epoch."0.7.2".scopeguard}".default or false);
  }) [
    (features_.arrayvec."${deps."crossbeam_epoch"."0.7.2"."arrayvec"}" deps)
    (features_.cfg_if."${deps."crossbeam_epoch"."0.7.2"."cfg_if"}" deps)
    (features_.crossbeam_utils."${deps."crossbeam_epoch"."0.7.2"."crossbeam_utils"}" deps)
    (features_.lazy_static."${deps."crossbeam_epoch"."0.7.2"."lazy_static"}" deps)
    (features_.memoffset."${deps."crossbeam_epoch"."0.7.2"."memoffset"}" deps)
    (features_.scopeguard."${deps."crossbeam_epoch"."0.7.2"."scopeguard"}" deps)
  ];


# end
# crossbeam-queue-0.1.2

  crates.crossbeam_queue."0.1.2" = deps: { features?(features_.crossbeam_queue."0.1.2" deps {}) }: buildRustCrate {
    crateName = "crossbeam-queue";
    version = "0.1.2";
    description = "Concurrent queues";
    authors = [ "The Crossbeam Project Developers" ];
    sha256 = "1hannzr5w6j5061kg5iba4fzi6f2xpqv7bkcspfq17y1i8g0mzjj";
    dependencies = mapFeatures features ([
      (crates."crossbeam_utils"."${deps."crossbeam_queue"."0.1.2"."crossbeam_utils"}" deps)
    ]);
  };
  features_.crossbeam_queue."0.1.2" = deps: f: updateFeatures f (rec {
    crossbeam_queue."0.1.2".default = (f.crossbeam_queue."0.1.2".default or true);
    crossbeam_utils."${deps.crossbeam_queue."0.1.2".crossbeam_utils}".default = true;
  }) [
    (features_.crossbeam_utils."${deps."crossbeam_queue"."0.1.2"."crossbeam_utils"}" deps)
  ];


# end
# crossbeam-utils-0.6.6

  crates.crossbeam_utils."0.6.6" = deps: { features?(features_.crossbeam_utils."0.6.6" deps {}) }: buildRustCrate {
    crateName = "crossbeam-utils";
    version = "0.6.6";
    description = "Utilities for concurrent programming";
    authors = [ "The Crossbeam Project Developers" ];
    sha256 = "01gxccmrjkkcavdh8fc01kj3b5fmk10f0lkx66jmnv69kcssry72";
    dependencies = mapFeatures features ([
      (crates."cfg_if"."${deps."crossbeam_utils"."0.6.6"."cfg_if"}" deps)
    ]
      ++ (if features.crossbeam_utils."0.6.6".lazy_static or false then [ (crates.lazy_static."${deps."crossbeam_utils"."0.6.6".lazy_static}" deps) ] else []));
    features = mkFeatures (features."crossbeam_utils"."0.6.6" or {});
  };
  features_.crossbeam_utils."0.6.6" = deps: f: updateFeatures f (rec {
    cfg_if."${deps.crossbeam_utils."0.6.6".cfg_if}".default = true;
    crossbeam_utils = fold recursiveUpdate {} [
      { "0.6.6"."lazy_static" =
        (f.crossbeam_utils."0.6.6"."lazy_static" or false) ||
        (f.crossbeam_utils."0.6.6".std or false) ||
        (crossbeam_utils."0.6.6"."std" or false); }
      { "0.6.6"."std" =
        (f.crossbeam_utils."0.6.6"."std" or false) ||
        (f.crossbeam_utils."0.6.6".default or false) ||
        (crossbeam_utils."0.6.6"."default" or false); }
      { "0.6.6".default = (f.crossbeam_utils."0.6.6".default or true); }
    ];
    lazy_static."${deps.crossbeam_utils."0.6.6".lazy_static}".default = true;
  }) [
    (features_.cfg_if."${deps."crossbeam_utils"."0.6.6"."cfg_if"}" deps)
    (features_.lazy_static."${deps."crossbeam_utils"."0.6.6"."lazy_static"}" deps)
  ];


# end
# cssparser-0.25.9

  crates.cssparser."0.25.9" = deps: { features?(features_.cssparser."0.25.9" deps {}) }: buildRustCrate {
    crateName = "cssparser";
    version = "0.25.9";
    description = "Rust implementation of CSS Syntax Level 3";
    authors = [ "Simon Sapin <simon.sapin@exyr.org>" ];
    sha256 = "1p9gsyxwc17s7gqlmw2h17w6b5igizjsd5pz14xlirrgbn6i39xf";
    build = "build.rs";
    dependencies = mapFeatures features ([
      (crates."cssparser_macros"."${deps."cssparser"."0.25.9"."cssparser_macros"}" deps)
      (crates."dtoa_short"."${deps."cssparser"."0.25.9"."dtoa_short"}" deps)
      (crates."itoa"."${deps."cssparser"."0.25.9"."itoa"}" deps)
      (crates."matches"."${deps."cssparser"."0.25.9"."matches"}" deps)
      (crates."phf"."${deps."cssparser"."0.25.9"."phf"}" deps)
      (crates."procedural_masquerade"."${deps."cssparser"."0.25.9"."procedural_masquerade"}" deps)
      (crates."smallvec"."${deps."cssparser"."0.25.9"."smallvec"}" deps)
    ]);

    buildDependencies = mapFeatures features ([
      (crates."autocfg"."${deps."cssparser"."0.25.9"."autocfg"}" deps)
      (crates."proc_macro2"."${deps."cssparser"."0.25.9"."proc_macro2"}" deps)
      (crates."quote"."${deps."cssparser"."0.25.9"."quote"}" deps)
      (crates."syn"."${deps."cssparser"."0.25.9"."syn"}" deps)
    ]);
    features = mkFeatures (features."cssparser"."0.25.9" or {});
  };
  features_.cssparser."0.25.9" = deps: f: updateFeatures f (rec {
    autocfg."${deps.cssparser."0.25.9".autocfg}".default = true;
    cssparser."0.25.9".default = (f.cssparser."0.25.9".default or true);
    cssparser_macros."${deps.cssparser."0.25.9".cssparser_macros}".default = true;
    dtoa_short."${deps.cssparser."0.25.9".dtoa_short}".default = true;
    itoa."${deps.cssparser."0.25.9".itoa}".default = true;
    matches."${deps.cssparser."0.25.9".matches}".default = true;
    phf."${deps.cssparser."0.25.9".phf}".default = true;
    proc_macro2."${deps.cssparser."0.25.9".proc_macro2}".default = true;
    procedural_masquerade."${deps.cssparser."0.25.9".procedural_masquerade}".default = true;
    quote."${deps.cssparser."0.25.9".quote}".default = true;
    smallvec."${deps.cssparser."0.25.9".smallvec}".default = true;
    syn = fold recursiveUpdate {} [
      { "${deps.cssparser."0.25.9".syn}"."extra-traits" = true; }
      { "${deps.cssparser."0.25.9".syn}"."fold" = true; }
      { "${deps.cssparser."0.25.9".syn}"."full" = true; }
      { "${deps.cssparser."0.25.9".syn}".default = true; }
    ];
  }) [
    (features_.cssparser_macros."${deps."cssparser"."0.25.9"."cssparser_macros"}" deps)
    (features_.dtoa_short."${deps."cssparser"."0.25.9"."dtoa_short"}" deps)
    (features_.itoa."${deps."cssparser"."0.25.9"."itoa"}" deps)
    (features_.matches."${deps."cssparser"."0.25.9"."matches"}" deps)
    (features_.phf."${deps."cssparser"."0.25.9"."phf"}" deps)
    (features_.procedural_masquerade."${deps."cssparser"."0.25.9"."procedural_masquerade"}" deps)
    (features_.smallvec."${deps."cssparser"."0.25.9"."smallvec"}" deps)
    (features_.autocfg."${deps."cssparser"."0.25.9"."autocfg"}" deps)
    (features_.proc_macro2."${deps."cssparser"."0.25.9"."proc_macro2"}" deps)
    (features_.quote."${deps."cssparser"."0.25.9"."quote"}" deps)
    (features_.syn."${deps."cssparser"."0.25.9"."syn"}" deps)
  ];


# end
# cssparser-macros-0.3.6

  crates.cssparser_macros."0.3.6" = deps: { features?(features_.cssparser_macros."0.3.6" deps {}) }: buildRustCrate {
    crateName = "cssparser-macros";
    version = "0.3.6";
    description = "Procedural macros for cssparser";
    authors = [ "Simon Sapin <simon.sapin@exyr.org>" ];
    sha256 = "1h4mwab9rz01baq54pj54a8r3iwi21lm78vhd054bczxb7yjw7a4";
    libPath = "lib.rs";
    procMacro = true;
    dependencies = mapFeatures features ([
      (crates."phf_codegen"."${deps."cssparser_macros"."0.3.6"."phf_codegen"}" deps)
      (crates."proc_macro2"."${deps."cssparser_macros"."0.3.6"."proc_macro2"}" deps)
      (crates."procedural_masquerade"."${deps."cssparser_macros"."0.3.6"."procedural_masquerade"}" deps)
      (crates."quote"."${deps."cssparser_macros"."0.3.6"."quote"}" deps)
      (crates."syn"."${deps."cssparser_macros"."0.3.6"."syn"}" deps)
    ]);
  };
  features_.cssparser_macros."0.3.6" = deps: f: updateFeatures f (rec {
    cssparser_macros."0.3.6".default = (f.cssparser_macros."0.3.6".default or true);
    phf_codegen."${deps.cssparser_macros."0.3.6".phf_codegen}".default = true;
    proc_macro2."${deps.cssparser_macros."0.3.6".proc_macro2}".default = true;
    procedural_masquerade."${deps.cssparser_macros."0.3.6".procedural_masquerade}".default = true;
    quote."${deps.cssparser_macros."0.3.6".quote}".default = true;
    syn = fold recursiveUpdate {} [
      { "${deps.cssparser_macros."0.3.6".syn}"."extra-traits" = true; }
      { "${deps.cssparser_macros."0.3.6".syn}"."full" = true; }
      { "${deps.cssparser_macros."0.3.6".syn}".default = true; }
    ];
  }) [
    (features_.phf_codegen."${deps."cssparser_macros"."0.3.6"."phf_codegen"}" deps)
    (features_.proc_macro2."${deps."cssparser_macros"."0.3.6"."proc_macro2"}" deps)
    (features_.procedural_masquerade."${deps."cssparser_macros"."0.3.6"."procedural_masquerade"}" deps)
    (features_.quote."${deps."cssparser_macros"."0.3.6"."quote"}" deps)
    (features_.syn."${deps."cssparser_macros"."0.3.6"."syn"}" deps)
  ];


# end
# dtoa-0.4.4

  crates.dtoa."0.4.4" = deps: { features?(features_.dtoa."0.4.4" deps {}) }: buildRustCrate {
    crateName = "dtoa";
    version = "0.4.4";
    description = "Fast functions for printing floating-point primitives to an io::Write";
    authors = [ "David Tolnay <dtolnay@gmail.com>" ];
    sha256 = "1nbq72nc2kp8lbx6i1ml5ird5c0cy4i6dvm7wfydybmanw4m07xz";
  };
  features_.dtoa."0.4.4" = deps: f: updateFeatures f (rec {
    dtoa."0.4.4".default = (f.dtoa."0.4.4".default or true);
  }) [];


# end
# dtoa-short-0.3.2

  crates.dtoa_short."0.3.2" = deps: { features?(features_.dtoa_short."0.3.2" deps {}) }: buildRustCrate {
    crateName = "dtoa-short";
    version = "0.3.2";
    description = "Serialize float number and truncate to certain precision";
    authors = [ "Xidorn Quan <me@upsuper.org>" ];
    sha256 = "10ahw0qfrss941f8fmyhjz4w5h5j2lan2a200av1i31243gfqh4k";
    dependencies = mapFeatures features ([
      (crates."dtoa"."${deps."dtoa_short"."0.3.2"."dtoa"}" deps)
    ]);
  };
  features_.dtoa_short."0.3.2" = deps: f: updateFeatures f (rec {
    dtoa."${deps.dtoa_short."0.3.2".dtoa}".default = true;
    dtoa_short."0.3.2".default = (f.dtoa_short."0.3.2".default or true);
  }) [
    (features_.dtoa."${deps."dtoa_short"."0.3.2"."dtoa"}" deps)
  ];


# end
# ego-tree-0.6.0

  crates.ego_tree."0.6.0" = deps: { features?(features_.ego_tree."0.6.0" deps {}) }: buildRustCrate {
    crateName = "ego-tree";
    version = "0.6.0";
    description = "Vec-backed ID-tree";
    authors = [ "Curtis McEnroe <programble@gmail.com>" ];
    sha256 = "19ryxf87njlpjrdg1dngwd9i37symfx3ahrlxzid7gnmlzj51q9g";
  };
  features_.ego_tree."0.6.0" = deps: f: updateFeatures f (rec {
    ego_tree."0.6.0".default = (f.ego_tree."0.6.0".default or true);
  }) [];


# end
# either-1.5.3

  crates.either."1.5.3" = deps: { features?(features_.either."1.5.3" deps {}) }: buildRustCrate {
    crateName = "either";
    version = "1.5.3";
    description = "The enum `Either` with variants `Left` and `Right` is a general purpose sum type with two cases.\n";
    authors = [ "bluss" ];
    sha256 = "040fgh0jahqra9ascwb986zgll1ss88ky9bfvn0zfay42zsyz83n";
    dependencies = mapFeatures features ([
]);
    features = mkFeatures (features."either"."1.5.3" or {});
  };
  features_.either."1.5.3" = deps: f: updateFeatures f (rec {
    either = fold recursiveUpdate {} [
      { "1.5.3"."use_std" =
        (f.either."1.5.3"."use_std" or false) ||
        (f.either."1.5.3".default or false) ||
        (either."1.5.3"."default" or false); }
      { "1.5.3".default = (f.either."1.5.3".default or true); }
    ];
  }) [];


# end
# encoding_rs-0.8.20

  crates.encoding_rs."0.8.20" = deps: { features?(features_.encoding_rs."0.8.20" deps {}) }: buildRustCrate {
    crateName = "encoding_rs";
    version = "0.8.20";
    description = "A Gecko-oriented implementation of the Encoding Standard";
    authors = [ "Henri Sivonen <hsivonen@hsivonen.fi>" ];
    sha256 = "0iawvazbl788kb853fikidi94fk37680mgd62vygfwh04lx72rnb";
    dependencies = mapFeatures features ([
      (crates."cfg_if"."${deps."encoding_rs"."0.8.20"."cfg_if"}" deps)
    ]);
    features = mkFeatures (features."encoding_rs"."0.8.20" or {});
  };
  features_.encoding_rs."0.8.20" = deps: f: updateFeatures f (rec {
    cfg_if."${deps.encoding_rs."0.8.20".cfg_if}".default = true;
    encoding_rs = fold recursiveUpdate {} [
      { "0.8.20"."fast-big5-hanzi-encode" =
        (f.encoding_rs."0.8.20"."fast-big5-hanzi-encode" or false) ||
        (f.encoding_rs."0.8.20".fast-legacy-encode or false) ||
        (encoding_rs."0.8.20"."fast-legacy-encode" or false); }
      { "0.8.20"."fast-gb-hanzi-encode" =
        (f.encoding_rs."0.8.20"."fast-gb-hanzi-encode" or false) ||
        (f.encoding_rs."0.8.20".fast-legacy-encode or false) ||
        (encoding_rs."0.8.20"."fast-legacy-encode" or false); }
      { "0.8.20"."fast-hangul-encode" =
        (f.encoding_rs."0.8.20"."fast-hangul-encode" or false) ||
        (f.encoding_rs."0.8.20".fast-legacy-encode or false) ||
        (encoding_rs."0.8.20"."fast-legacy-encode" or false); }
      { "0.8.20"."fast-hanja-encode" =
        (f.encoding_rs."0.8.20"."fast-hanja-encode" or false) ||
        (f.encoding_rs."0.8.20".fast-legacy-encode or false) ||
        (encoding_rs."0.8.20"."fast-legacy-encode" or false); }
      { "0.8.20"."fast-kanji-encode" =
        (f.encoding_rs."0.8.20"."fast-kanji-encode" or false) ||
        (f.encoding_rs."0.8.20".fast-legacy-encode or false) ||
        (encoding_rs."0.8.20"."fast-legacy-encode" or false); }
      { "0.8.20"."packed_simd" =
        (f.encoding_rs."0.8.20"."packed_simd" or false) ||
        (f.encoding_rs."0.8.20".simd-accel or false) ||
        (encoding_rs."0.8.20"."simd-accel" or false); }
      { "0.8.20".default = (f.encoding_rs."0.8.20".default or true); }
    ];
  }) [
    (features_.cfg_if."${deps."encoding_rs"."0.8.20"."cfg_if"}" deps)
  ];


# end
# error-chain-0.12.1

  crates.error_chain."0.12.1" = deps: { features?(features_.error_chain."0.12.1" deps {}) }: buildRustCrate {
    crateName = "error-chain";
    version = "0.12.1";
    description = "Yet another error boilerplate library.";
    authors = [ "Brian Anderson <banderson@mozilla.com>" "Paul Colomiets <paul@colomiets.name>" "Colin Kiegel <kiegel@gmx.de>" "Yamakaky <yamakaky@yamaworld.fr>" ];
    sha256 = "1lgs40xn50p0n4yqyryv9gzpvjw7sg355vjqcqmn5ai84rmh14m7";
    dependencies = mapFeatures features ([
    ]
      ++ (if features.error_chain."0.12.1".backtrace or false then [ (crates.backtrace."${deps."error_chain"."0.12.1".backtrace}" deps) ] else []));

    buildDependencies = mapFeatures features ([
      (crates."version_check"."${deps."error_chain"."0.12.1"."version_check"}" deps)
    ]);
    features = mkFeatures (features."error_chain"."0.12.1" or {});
  };
  features_.error_chain."0.12.1" = deps: f: updateFeatures f (rec {
    backtrace."${deps.error_chain."0.12.1".backtrace}".default = true;
    error_chain = fold recursiveUpdate {} [
      { "0.12.1"."backtrace" =
        (f.error_chain."0.12.1"."backtrace" or false) ||
        (f.error_chain."0.12.1".default or false) ||
        (error_chain."0.12.1"."default" or false); }
      { "0.12.1"."example_generated" =
        (f.error_chain."0.12.1"."example_generated" or false) ||
        (f.error_chain."0.12.1".default or false) ||
        (error_chain."0.12.1"."default" or false); }
      { "0.12.1".default = (f.error_chain."0.12.1".default or true); }
    ];
    version_check."${deps.error_chain."0.12.1".version_check}".default = true;
  }) [
    (features_.backtrace."${deps."error_chain"."0.12.1"."backtrace"}" deps)
    (features_.version_check."${deps."error_chain"."0.12.1"."version_check"}" deps)
  ];


# end
# failure-0.1.5

  crates.failure."0.1.5" = deps: { features?(features_.failure."0.1.5" deps {}) }: buildRustCrate {
    crateName = "failure";
    version = "0.1.5";
    description = "Experimental error handling abstraction.";
    authors = [ "Without Boats <boats@mozilla.com>" ];
    sha256 = "1msaj1c0fg12dzyf4fhxqlx1gfx41lj2smdjmkc9hkrgajk2g3kx";
    dependencies = mapFeatures features ([
    ]
      ++ (if features.failure."0.1.5".backtrace or false then [ (crates.backtrace."${deps."failure"."0.1.5".backtrace}" deps) ] else [])
      ++ (if features.failure."0.1.5".failure_derive or false then [ (crates.failure_derive."${deps."failure"."0.1.5".failure_derive}" deps) ] else []));
    features = mkFeatures (features."failure"."0.1.5" or {});
  };
  features_.failure."0.1.5" = deps: f: updateFeatures f (rec {
    backtrace."${deps.failure."0.1.5".backtrace}".default = true;
    failure = fold recursiveUpdate {} [
      { "0.1.5"."backtrace" =
        (f.failure."0.1.5"."backtrace" or false) ||
        (f.failure."0.1.5".std or false) ||
        (failure."0.1.5"."std" or false); }
      { "0.1.5"."derive" =
        (f.failure."0.1.5"."derive" or false) ||
        (f.failure."0.1.5".default or false) ||
        (failure."0.1.5"."default" or false); }
      { "0.1.5"."failure_derive" =
        (f.failure."0.1.5"."failure_derive" or false) ||
        (f.failure."0.1.5".derive or false) ||
        (failure."0.1.5"."derive" or false); }
      { "0.1.5"."std" =
        (f.failure."0.1.5"."std" or false) ||
        (f.failure."0.1.5".default or false) ||
        (failure."0.1.5"."default" or false); }
      { "0.1.5".default = (f.failure."0.1.5".default or true); }
    ];
    failure_derive."${deps.failure."0.1.5".failure_derive}".default = true;
  }) [
    (features_.backtrace."${deps."failure"."0.1.5"."backtrace"}" deps)
    (features_.failure_derive."${deps."failure"."0.1.5"."failure_derive"}" deps)
  ];


# end
# failure_derive-0.1.5

  crates.failure_derive."0.1.5" = deps: { features?(features_.failure_derive."0.1.5" deps {}) }: buildRustCrate {
    crateName = "failure_derive";
    version = "0.1.5";
    description = "derives for the failure crate";
    authors = [ "Without Boats <woboats@gmail.com>" ];
    sha256 = "1wzk484b87r4qszcvdl2bkniv5ls4r2f2dshz7hmgiv6z4ln12g0";
    procMacro = true;
    build = "build.rs";
    dependencies = mapFeatures features ([
      (crates."proc_macro2"."${deps."failure_derive"."0.1.5"."proc_macro2"}" deps)
      (crates."quote"."${deps."failure_derive"."0.1.5"."quote"}" deps)
      (crates."syn"."${deps."failure_derive"."0.1.5"."syn"}" deps)
      (crates."synstructure"."${deps."failure_derive"."0.1.5"."synstructure"}" deps)
    ]);
    features = mkFeatures (features."failure_derive"."0.1.5" or {});
  };
  features_.failure_derive."0.1.5" = deps: f: updateFeatures f (rec {
    failure_derive."0.1.5".default = (f.failure_derive."0.1.5".default or true);
    proc_macro2."${deps.failure_derive."0.1.5".proc_macro2}".default = true;
    quote."${deps.failure_derive."0.1.5".quote}".default = true;
    syn."${deps.failure_derive."0.1.5".syn}".default = true;
    synstructure."${deps.failure_derive."0.1.5".synstructure}".default = true;
  }) [
    (features_.proc_macro2."${deps."failure_derive"."0.1.5"."proc_macro2"}" deps)
    (features_.quote."${deps."failure_derive"."0.1.5"."quote"}" deps)
    (features_.syn."${deps."failure_derive"."0.1.5"."syn"}" deps)
    (features_.synstructure."${deps."failure_derive"."0.1.5"."synstructure"}" deps)
  ];


# end
# flate2-1.0.11

  crates.flate2."1.0.11" = deps: { features?(features_.flate2."1.0.11" deps {}) }: buildRustCrate {
    crateName = "flate2";
    version = "1.0.11";
    description = "Bindings to miniz.c for DEFLATE compression and decompression exposed as\nReader/Writer streams. Contains bindings for zlib, deflate, and gzip-based\nstreams.\n";
    authors = [ "Alex Crichton <alex@alexcrichton.com>" ];
    sha256 = "0cx98sl8nycw6ldb55lmy0gx3w20b3955ybjdlprdp2az16wngp6";
    dependencies = mapFeatures features ([
      (crates."crc32fast"."${deps."flate2"."1.0.11"."crc32fast"}" deps)
      (crates."libc"."${deps."flate2"."1.0.11"."libc"}" deps)
    ]
      ++ (if features.flate2."1.0.11".miniz_oxide or false then [ (crates.miniz_oxide."${deps."flate2"."1.0.11".miniz_oxide}" deps) ] else []))
      ++ (if cpu == "wasm32" && !(kernel == "emscripten") then mapFeatures features ([
      (crates."miniz_oxide"."${deps."flate2"."1.0.11"."miniz_oxide"}" deps)
    ]) else []);
    features = mkFeatures (features."flate2"."1.0.11" or {});
  };
  features_.flate2."1.0.11" = deps: f: updateFeatures f (rec {
    crc32fast."${deps.flate2."1.0.11".crc32fast}".default = true;
    flate2 = fold recursiveUpdate {} [
      { "1.0.11"."futures" =
        (f.flate2."1.0.11"."futures" or false) ||
        (f.flate2."1.0.11".tokio or false) ||
        (flate2."1.0.11"."tokio" or false); }
      { "1.0.11"."libz-sys" =
        (f.flate2."1.0.11"."libz-sys" or false) ||
        (f.flate2."1.0.11".zlib or false) ||
        (flate2."1.0.11"."zlib" or false); }
      { "1.0.11"."miniz-sys" =
        (f.flate2."1.0.11"."miniz-sys" or false) ||
        (f.flate2."1.0.11".default or false) ||
        (flate2."1.0.11"."default" or false); }
      { "1.0.11"."miniz_oxide" =
        (f.flate2."1.0.11"."miniz_oxide" or false) ||
        (f.flate2."1.0.11".rust_backend or false) ||
        (flate2."1.0.11"."rust_backend" or false); }
      { "1.0.11"."tokio-io" =
        (f.flate2."1.0.11"."tokio-io" or false) ||
        (f.flate2."1.0.11".tokio or false) ||
        (flate2."1.0.11"."tokio" or false); }
      { "1.0.11".default = (f.flate2."1.0.11".default or true); }
    ];
    libc."${deps.flate2."1.0.11".libc}".default = true;
    miniz_oxide."${deps.flate2."1.0.11".miniz_oxide}".default = true;
  }) [
    (features_.crc32fast."${deps."flate2"."1.0.11"."crc32fast"}" deps)
    (features_.libc."${deps."flate2"."1.0.11"."libc"}" deps)
    (features_.miniz_oxide."${deps."flate2"."1.0.11"."miniz_oxide"}" deps)
    (features_.miniz_oxide."${deps."flate2"."1.0.11"."miniz_oxide"}" deps)
  ];


# end
# fnv-1.0.6

  crates.fnv."1.0.6" = deps: { features?(features_.fnv."1.0.6" deps {}) }: buildRustCrate {
    crateName = "fnv";
    version = "1.0.6";
    description = "Fowler–Noll–Vo hash function";
    authors = [ "Alex Crichton <alex@alexcrichton.com>" ];
    sha256 = "128mlh23y3gg6ag5h8iiqlcbl59smisdzraqy88ldrf75kbw27ip";
    libPath = "lib.rs";
  };
  features_.fnv."1.0.6" = deps: f: updateFeatures f (rec {
    fnv."1.0.6".default = (f.fnv."1.0.6".default or true);
  }) [];


# end
# foreign-types-0.3.2

  crates.foreign_types."0.3.2" = deps: { features?(features_.foreign_types."0.3.2" deps {}) }: buildRustCrate {
    crateName = "foreign-types";
    version = "0.3.2";
    description = "A framework for Rust wrappers over C APIs";
    authors = [ "Steven Fackler <sfackler@gmail.com>" ];
    sha256 = "105n8sp2djb1s5lzrw04p7ss3dchr5qa3canmynx396nh3vwm2p8";
    dependencies = mapFeatures features ([
      (crates."foreign_types_shared"."${deps."foreign_types"."0.3.2"."foreign_types_shared"}" deps)
    ]);
  };
  features_.foreign_types."0.3.2" = deps: f: updateFeatures f (rec {
    foreign_types."0.3.2".default = (f.foreign_types."0.3.2".default or true);
    foreign_types_shared."${deps.foreign_types."0.3.2".foreign_types_shared}".default = true;
  }) [
    (features_.foreign_types_shared."${deps."foreign_types"."0.3.2"."foreign_types_shared"}" deps)
  ];


# end
# foreign-types-shared-0.1.1

  crates.foreign_types_shared."0.1.1" = deps: { features?(features_.foreign_types_shared."0.1.1" deps {}) }: buildRustCrate {
    crateName = "foreign-types-shared";
    version = "0.1.1";
    description = "An internal crate used by foreign-types";
    authors = [ "Steven Fackler <sfackler@gmail.com>" ];
    sha256 = "0b6cnvqbflws8dxywk4589vgbz80049lz4x1g9dfy4s1ppd3g4z5";
  };
  features_.foreign_types_shared."0.1.1" = deps: f: updateFeatures f (rec {
    foreign_types_shared."0.1.1".default = (f.foreign_types_shared."0.1.1".default or true);
  }) [];


# end
# fuchsia-cprng-0.1.1

  crates.fuchsia_cprng."0.1.1" = deps: { features?(features_.fuchsia_cprng."0.1.1" deps {}) }: buildRustCrate {
    crateName = "fuchsia-cprng";
    version = "0.1.1";
    description = "Rust crate for the Fuchsia cryptographically secure pseudorandom number generator";
    authors = [ "Erick Tryzelaar <etryzelaar@google.com>" ];
    edition = "2018";
    sha256 = "07apwv9dj716yjlcj29p94vkqn5zmfh7hlrqvrjx3wzshphc95h9";
  };
  features_.fuchsia_cprng."0.1.1" = deps: f: updateFeatures f (rec {
    fuchsia_cprng."0.1.1".default = (f.fuchsia_cprng."0.1.1".default or true);
  }) [];


# end
# fuchsia-zircon-0.3.3

  crates.fuchsia_zircon."0.3.3" = deps: { features?(features_.fuchsia_zircon."0.3.3" deps {}) }: buildRustCrate {
    crateName = "fuchsia-zircon";
    version = "0.3.3";
    description = "Rust bindings for the Zircon kernel";
    authors = [ "Raph Levien <raph@google.com>" ];
    sha256 = "0jrf4shb1699r4la8z358vri8318w4mdi6qzfqy30p2ymjlca4gk";
    dependencies = mapFeatures features ([
      (crates."bitflags"."${deps."fuchsia_zircon"."0.3.3"."bitflags"}" deps)
      (crates."fuchsia_zircon_sys"."${deps."fuchsia_zircon"."0.3.3"."fuchsia_zircon_sys"}" deps)
    ]);
  };
  features_.fuchsia_zircon."0.3.3" = deps: f: updateFeatures f (rec {
    bitflags."${deps.fuchsia_zircon."0.3.3".bitflags}".default = true;
    fuchsia_zircon."0.3.3".default = (f.fuchsia_zircon."0.3.3".default or true);
    fuchsia_zircon_sys."${deps.fuchsia_zircon."0.3.3".fuchsia_zircon_sys}".default = true;
  }) [
    (features_.bitflags."${deps."fuchsia_zircon"."0.3.3"."bitflags"}" deps)
    (features_.fuchsia_zircon_sys."${deps."fuchsia_zircon"."0.3.3"."fuchsia_zircon_sys"}" deps)
  ];


# end
# fuchsia-zircon-sys-0.3.3

  crates.fuchsia_zircon_sys."0.3.3" = deps: { features?(features_.fuchsia_zircon_sys."0.3.3" deps {}) }: buildRustCrate {
    crateName = "fuchsia-zircon-sys";
    version = "0.3.3";
    description = "Low-level Rust bindings for the Zircon kernel";
    authors = [ "Raph Levien <raph@google.com>" ];
    sha256 = "08jp1zxrm9jbrr6l26bjal4dbm8bxfy57ickdgibsqxr1n9j3hf5";
  };
  features_.fuchsia_zircon_sys."0.3.3" = deps: f: updateFeatures f (rec {
    fuchsia_zircon_sys."0.3.3".default = (f.fuchsia_zircon_sys."0.3.3".default or true);
  }) [];


# end
# futf-0.1.4

  crates.futf."0.1.4" = deps: { features?(features_.futf."0.1.4" deps {}) }: buildRustCrate {
    crateName = "futf";
    version = "0.1.4";
    description = "Handling fragments of UTF-8";
    authors = [ "Keegan McAllister <kmcallister@mozilla.com>" ];
    sha256 = "0sf664dbha0iwgqbpa1nhvssm3xi9z07mz90m9bfipgdybbs1pbn";
    dependencies = mapFeatures features ([
      (crates."mac"."${deps."futf"."0.1.4"."mac"}" deps)
      (crates."new_debug_unreachable"."${deps."futf"."0.1.4"."new_debug_unreachable"}" deps)
    ]);
  };
  features_.futf."0.1.4" = deps: f: updateFeatures f (rec {
    futf."0.1.4".default = (f.futf."0.1.4".default or true);
    mac."${deps.futf."0.1.4".mac}".default = true;
    new_debug_unreachable."${deps.futf."0.1.4".new_debug_unreachable}".default = true;
  }) [
    (features_.mac."${deps."futf"."0.1.4"."mac"}" deps)
    (features_.new_debug_unreachable."${deps."futf"."0.1.4"."new_debug_unreachable"}" deps)
  ];


# end
# futures-0.1.29

  crates.futures."0.1.29" = deps: { features?(features_.futures."0.1.29" deps {}) }: buildRustCrate {
    crateName = "futures";
    version = "0.1.29";
    description = "An implementation of futures and streams featuring zero allocations,\ncomposability, and iterator-like interfaces.\n";
    authors = [ "Alex Crichton <alex@alexcrichton.com>" ];
    sha256 = "0zq7ysf5qvdchh3hjrvvv3sx4bflq6mb7b1wzaqsn2c8bbcvjgmp";
    features = mkFeatures (features."futures"."0.1.29" or {});
  };
  features_.futures."0.1.29" = deps: f: updateFeatures f (rec {
    futures = fold recursiveUpdate {} [
      { "0.1.29"."use_std" =
        (f.futures."0.1.29"."use_std" or false) ||
        (f.futures."0.1.29".default or false) ||
        (futures."0.1.29"."default" or false); }
      { "0.1.29"."with-deprecated" =
        (f.futures."0.1.29"."with-deprecated" or false) ||
        (f.futures."0.1.29".default or false) ||
        (futures."0.1.29"."default" or false); }
      { "0.1.29".default = (f.futures."0.1.29".default or true); }
    ];
  }) [];


# end
# futures-cpupool-0.1.8

  crates.futures_cpupool."0.1.8" = deps: { features?(features_.futures_cpupool."0.1.8" deps {}) }: buildRustCrate {
    crateName = "futures-cpupool";
    version = "0.1.8";
    description = "An implementation of thread pools which hand out futures to the results of the\ncomputation on the threads themselves.\n";
    authors = [ "Alex Crichton <alex@alexcrichton.com>" ];
    sha256 = "0ficd31n5ljiixy6x0vjglhq4fp0v1p4qzxm3v6ymsrb3z080l5c";
    dependencies = mapFeatures features ([
      (crates."futures"."${deps."futures_cpupool"."0.1.8"."futures"}" deps)
      (crates."num_cpus"."${deps."futures_cpupool"."0.1.8"."num_cpus"}" deps)
    ]);
    features = mkFeatures (features."futures_cpupool"."0.1.8" or {});
  };
  features_.futures_cpupool."0.1.8" = deps: f: updateFeatures f (rec {
    futures = fold recursiveUpdate {} [
      { "${deps.futures_cpupool."0.1.8".futures}"."use_std" = true; }
      { "${deps.futures_cpupool."0.1.8".futures}"."with-deprecated" =
        (f.futures."${deps.futures_cpupool."0.1.8".futures}"."with-deprecated" or false) ||
        (futures_cpupool."0.1.8"."with-deprecated" or false) ||
        (f."futures_cpupool"."0.1.8"."with-deprecated" or false); }
      { "${deps.futures_cpupool."0.1.8".futures}".default = (f.futures."${deps.futures_cpupool."0.1.8".futures}".default or false); }
    ];
    futures_cpupool = fold recursiveUpdate {} [
      { "0.1.8"."with-deprecated" =
        (f.futures_cpupool."0.1.8"."with-deprecated" or false) ||
        (f.futures_cpupool."0.1.8".default or false) ||
        (futures_cpupool."0.1.8"."default" or false); }
      { "0.1.8".default = (f.futures_cpupool."0.1.8".default or true); }
    ];
    num_cpus."${deps.futures_cpupool."0.1.8".num_cpus}".default = true;
  }) [
    (features_.futures."${deps."futures_cpupool"."0.1.8"."futures"}" deps)
    (features_.num_cpus."${deps."futures_cpupool"."0.1.8"."num_cpus"}" deps)
  ];


# end
# fxhash-0.2.1

  crates.fxhash."0.2.1" = deps: { features?(features_.fxhash."0.2.1" deps {}) }: buildRustCrate {
    crateName = "fxhash";
    version = "0.2.1";
    description = "A fast, non-secure, hashing algorithm derived from an internal hasher used in FireFox and Rustc.";
    authors = [ "cbreeden <github@u.breeden.cc>" ];
    sha256 = "0p4mfqswwxhkkskdpjld581ksg3cipfs85jbw7znljhkz40l9fjj";
    libPath = "lib.rs";
    dependencies = mapFeatures features ([
      (crates."byteorder"."${deps."fxhash"."0.2.1"."byteorder"}" deps)
    ]);
  };
  features_.fxhash."0.2.1" = deps: f: updateFeatures f (rec {
    byteorder."${deps.fxhash."0.2.1".byteorder}".default = true;
    fxhash."0.2.1".default = (f.fxhash."0.2.1".default or true);
  }) [
    (features_.byteorder."${deps."fxhash"."0.2.1"."byteorder"}" deps)
  ];


# end
# getopts-0.2.21

  crates.getopts."0.2.21" = deps: { features?(features_.getopts."0.2.21" deps {}) }: buildRustCrate {
    crateName = "getopts";
    version = "0.2.21";
    description = "getopts-like option parsing.\n";
    authors = [ "The Rust Project Developers" ];
    sha256 = "1sqp35br180qhc1kzqg7pcv1nkbs05fgjfg53n4swcx2q2ql4763";
    dependencies = mapFeatures features ([
      (crates."unicode_width"."${deps."getopts"."0.2.21"."unicode_width"}" deps)
    ]);
    features = mkFeatures (features."getopts"."0.2.21" or {});
  };
  features_.getopts."0.2.21" = deps: f: updateFeatures f (rec {
    getopts = fold recursiveUpdate {} [
      { "0.2.21"."core" =
        (f.getopts."0.2.21"."core" or false) ||
        (f.getopts."0.2.21".rustc-dep-of-std or false) ||
        (getopts."0.2.21"."rustc-dep-of-std" or false); }
      { "0.2.21"."std" =
        (f.getopts."0.2.21"."std" or false) ||
        (f.getopts."0.2.21".rustc-dep-of-std or false) ||
        (getopts."0.2.21"."rustc-dep-of-std" or false); }
      { "0.2.21".default = (f.getopts."0.2.21".default or true); }
    ];
    unicode_width = fold recursiveUpdate {} [
      { "${deps.getopts."0.2.21".unicode_width}"."rustc-dep-of-std" =
        (f.unicode_width."${deps.getopts."0.2.21".unicode_width}"."rustc-dep-of-std" or false) ||
        (getopts."0.2.21"."rustc-dep-of-std" or false) ||
        (f."getopts"."0.2.21"."rustc-dep-of-std" or false); }
      { "${deps.getopts."0.2.21".unicode_width}".default = true; }
    ];
  }) [
    (features_.unicode_width."${deps."getopts"."0.2.21"."unicode_width"}" deps)
  ];


# end
# getrandom-0.1.12

  crates.getrandom."0.1.12" = deps: { features?(features_.getrandom."0.1.12" deps {}) }: buildRustCrate {
    crateName = "getrandom";
    version = "0.1.12";
    description = "A small cross-platform library for retrieving random data from system source";
    authors = [ "The Rand Project Developers" ];
    edition = "2018";
    sha256 = "0n3cyf8vm82hbbj6xzgaszjn852i0jl9qxibl7im7mvn7s9yrvb6";
    dependencies = mapFeatures features ([
      (crates."cfg_if"."${deps."getrandom"."0.1.12"."cfg_if"}" deps)
    ])
      ++ (if (kernel == "linux" || kernel == "darwin") || kernel == "redox" then mapFeatures features ([
      (crates."libc"."${deps."getrandom"."0.1.12"."libc"}" deps)
    ]) else [])
      ++ (if kernel == "wasi" then mapFeatures features ([
      (crates."wasi"."${deps."getrandom"."0.1.12"."wasi"}" deps)
    ]) else [])
      ++ (if kernel == "wasm32-unknown-unknown" then mapFeatures features ([
]) else []);
    features = mkFeatures (features."getrandom"."0.1.12" or {});
  };
  features_.getrandom."0.1.12" = deps: f: updateFeatures f (rec {
    cfg_if."${deps.getrandom."0.1.12".cfg_if}".default = true;
    getrandom = fold recursiveUpdate {} [
      { "0.1.12"."compiler_builtins" =
        (f.getrandom."0.1.12"."compiler_builtins" or false) ||
        (f.getrandom."0.1.12".rustc-dep-of-std or false) ||
        (getrandom."0.1.12"."rustc-dep-of-std" or false); }
      { "0.1.12"."core" =
        (f.getrandom."0.1.12"."core" or false) ||
        (f.getrandom."0.1.12".rustc-dep-of-std or false) ||
        (getrandom."0.1.12"."rustc-dep-of-std" or false); }
      { "0.1.12".default = (f.getrandom."0.1.12".default or true); }
    ];
    libc."${deps.getrandom."0.1.12".libc}".default = (f.libc."${deps.getrandom."0.1.12".libc}".default or false);
    wasi."${deps.getrandom."0.1.12".wasi}".default = true;
  }) [
    (features_.cfg_if."${deps."getrandom"."0.1.12"."cfg_if"}" deps)
    (features_.libc."${deps."getrandom"."0.1.12"."libc"}" deps)
    (features_.wasi."${deps."getrandom"."0.1.12"."wasi"}" deps)
  ];


# end
# h2-0.1.26

  crates.h2."0.1.26" = deps: { features?(features_.h2."0.1.26" deps {}) }: buildRustCrate {
    crateName = "h2";
    version = "0.1.26";
    description = "An HTTP/2.0 client and server";
    authors = [ "Carl Lerche <me@carllerche.com>" ];
    sha256 = "0wb3nsksi568qb44pzfkz7gbagghzb3fbbky8qhm37aan3dgwb8c";
    dependencies = mapFeatures features ([
      (crates."byteorder"."${deps."h2"."0.1.26"."byteorder"}" deps)
      (crates."bytes"."${deps."h2"."0.1.26"."bytes"}" deps)
      (crates."fnv"."${deps."h2"."0.1.26"."fnv"}" deps)
      (crates."futures"."${deps."h2"."0.1.26"."futures"}" deps)
      (crates."http"."${deps."h2"."0.1.26"."http"}" deps)
      (crates."indexmap"."${deps."h2"."0.1.26"."indexmap"}" deps)
      (crates."log"."${deps."h2"."0.1.26"."log"}" deps)
      (crates."slab"."${deps."h2"."0.1.26"."slab"}" deps)
      (crates."string"."${deps."h2"."0.1.26"."string"}" deps)
      (crates."tokio_io"."${deps."h2"."0.1.26"."tokio_io"}" deps)
    ]);
    features = mkFeatures (features."h2"."0.1.26" or {});
  };
  features_.h2."0.1.26" = deps: f: updateFeatures f (rec {
    byteorder."${deps.h2."0.1.26".byteorder}".default = true;
    bytes."${deps.h2."0.1.26".bytes}".default = true;
    fnv."${deps.h2."0.1.26".fnv}".default = true;
    futures."${deps.h2."0.1.26".futures}".default = true;
    h2."0.1.26".default = (f.h2."0.1.26".default or true);
    http."${deps.h2."0.1.26".http}".default = true;
    indexmap."${deps.h2."0.1.26".indexmap}".default = true;
    log."${deps.h2."0.1.26".log}".default = true;
    slab."${deps.h2."0.1.26".slab}".default = true;
    string."${deps.h2."0.1.26".string}".default = true;
    tokio_io."${deps.h2."0.1.26".tokio_io}".default = true;
  }) [
    (features_.byteorder."${deps."h2"."0.1.26"."byteorder"}" deps)
    (features_.bytes."${deps."h2"."0.1.26"."bytes"}" deps)
    (features_.fnv."${deps."h2"."0.1.26"."fnv"}" deps)
    (features_.futures."${deps."h2"."0.1.26"."futures"}" deps)
    (features_.http."${deps."h2"."0.1.26"."http"}" deps)
    (features_.indexmap."${deps."h2"."0.1.26"."indexmap"}" deps)
    (features_.log."${deps."h2"."0.1.26"."log"}" deps)
    (features_.slab."${deps."h2"."0.1.26"."slab"}" deps)
    (features_.string."${deps."h2"."0.1.26"."string"}" deps)
    (features_.tokio_io."${deps."h2"."0.1.26"."tokio_io"}" deps)
  ];


# end
# html5ever-0.22.5

  crates.html5ever."0.22.5" = deps: { features?(features_.html5ever."0.22.5" deps {}) }: buildRustCrate {
    crateName = "html5ever";
    version = "0.22.5";
    description = "High-performance browser-grade HTML5 parser";
    authors = [ "The html5ever Project Developers" ];
    sha256 = "1hbkxvy4za50y78h1dv6h75cpj83iwg6df94nyj003j7nvq5zchf";
    build = "build.rs";
    dependencies = mapFeatures features ([
      (crates."log"."${deps."html5ever"."0.22.5"."log"}" deps)
      (crates."mac"."${deps."html5ever"."0.22.5"."mac"}" deps)
      (crates."markup5ever"."${deps."html5ever"."0.22.5"."markup5ever"}" deps)
    ]);

    buildDependencies = mapFeatures features ([
      (crates."proc_macro2"."${deps."html5ever"."0.22.5"."proc_macro2"}" deps)
      (crates."quote"."${deps."html5ever"."0.22.5"."quote"}" deps)
      (crates."syn"."${deps."html5ever"."0.22.5"."syn"}" deps)
    ]);
  };
  features_.html5ever."0.22.5" = deps: f: updateFeatures f (rec {
    html5ever."0.22.5".default = (f.html5ever."0.22.5".default or true);
    log."${deps.html5ever."0.22.5".log}".default = true;
    mac."${deps.html5ever."0.22.5".mac}".default = true;
    markup5ever."${deps.html5ever."0.22.5".markup5ever}".default = true;
    proc_macro2."${deps.html5ever."0.22.5".proc_macro2}".default = true;
    quote."${deps.html5ever."0.22.5".quote}".default = true;
    syn = fold recursiveUpdate {} [
      { "${deps.html5ever."0.22.5".syn}"."extra-traits" = true; }
      { "${deps.html5ever."0.22.5".syn}"."fold" = true; }
      { "${deps.html5ever."0.22.5".syn}"."full" = true; }
      { "${deps.html5ever."0.22.5".syn}".default = true; }
    ];
  }) [
    (features_.log."${deps."html5ever"."0.22.5"."log"}" deps)
    (features_.mac."${deps."html5ever"."0.22.5"."mac"}" deps)
    (features_.markup5ever."${deps."html5ever"."0.22.5"."markup5ever"}" deps)
    (features_.proc_macro2."${deps."html5ever"."0.22.5"."proc_macro2"}" deps)
    (features_.quote."${deps."html5ever"."0.22.5"."quote"}" deps)
    (features_.syn."${deps."html5ever"."0.22.5"."syn"}" deps)
  ];


# end
# html5ever-0.23.0

  crates.html5ever."0.23.0" = deps: { features?(features_.html5ever."0.23.0" deps {}) }: buildRustCrate {
    crateName = "html5ever";
    version = "0.23.0";
    description = "High-performance browser-grade HTML5 parser";
    authors = [ "The html5ever Project Developers" ];
    sha256 = "0g7cbcpncf0n11n0xdqqzz6f0m68ww1xb7blk2znzq4p19x6wvgc";
    build = "build.rs";
    dependencies = mapFeatures features ([
      (crates."log"."${deps."html5ever"."0.23.0"."log"}" deps)
      (crates."mac"."${deps."html5ever"."0.23.0"."mac"}" deps)
      (crates."markup5ever"."${deps."html5ever"."0.23.0"."markup5ever"}" deps)
    ]);

    buildDependencies = mapFeatures features ([
      (crates."proc_macro2"."${deps."html5ever"."0.23.0"."proc_macro2"}" deps)
      (crates."quote"."${deps."html5ever"."0.23.0"."quote"}" deps)
      (crates."syn"."${deps."html5ever"."0.23.0"."syn"}" deps)
    ]);
  };
  features_.html5ever."0.23.0" = deps: f: updateFeatures f (rec {
    html5ever."0.23.0".default = (f.html5ever."0.23.0".default or true);
    log."${deps.html5ever."0.23.0".log}".default = true;
    mac."${deps.html5ever."0.23.0".mac}".default = true;
    markup5ever."${deps.html5ever."0.23.0".markup5ever}".default = true;
    proc_macro2."${deps.html5ever."0.23.0".proc_macro2}".default = true;
    quote."${deps.html5ever."0.23.0".quote}".default = true;
    syn = fold recursiveUpdate {} [
      { "${deps.html5ever."0.23.0".syn}"."extra-traits" = true; }
      { "${deps.html5ever."0.23.0".syn}"."fold" = true; }
      { "${deps.html5ever."0.23.0".syn}"."full" = true; }
      { "${deps.html5ever."0.23.0".syn}".default = true; }
    ];
  }) [
    (features_.log."${deps."html5ever"."0.23.0"."log"}" deps)
    (features_.mac."${deps."html5ever"."0.23.0"."mac"}" deps)
    (features_.markup5ever."${deps."html5ever"."0.23.0"."markup5ever"}" deps)
    (features_.proc_macro2."${deps."html5ever"."0.23.0"."proc_macro2"}" deps)
    (features_.quote."${deps."html5ever"."0.23.0"."quote"}" deps)
    (features_.syn."${deps."html5ever"."0.23.0"."syn"}" deps)
  ];


# end
# html5ever-0.24.1

  crates.html5ever."0.24.1" = deps: { features?(features_.html5ever."0.24.1" deps {}) }: buildRustCrate {
    crateName = "html5ever";
    version = "0.24.1";
    description = "High-performance browser-grade HTML5 parser";
    authors = [ "The html5ever Project Developers" ];
    sha256 = "14m4nv29mwfay7gpv71rpxgqw65qa01mffa0vslvd3ankwi01ip6";
    build = "build.rs";
    dependencies = mapFeatures features ([
      (crates."log"."${deps."html5ever"."0.24.1"."log"}" deps)
      (crates."mac"."${deps."html5ever"."0.24.1"."mac"}" deps)
      (crates."markup5ever"."${deps."html5ever"."0.24.1"."markup5ever"}" deps)
    ]);

    buildDependencies = mapFeatures features ([
      (crates."proc_macro2"."${deps."html5ever"."0.24.1"."proc_macro2"}" deps)
      (crates."quote"."${deps."html5ever"."0.24.1"."quote"}" deps)
      (crates."syn"."${deps."html5ever"."0.24.1"."syn"}" deps)
    ]);
  };
  features_.html5ever."0.24.1" = deps: f: updateFeatures f (rec {
    html5ever."0.24.1".default = (f.html5ever."0.24.1".default or true);
    log."${deps.html5ever."0.24.1".log}".default = true;
    mac."${deps.html5ever."0.24.1".mac}".default = true;
    markup5ever."${deps.html5ever."0.24.1".markup5ever}".default = true;
    proc_macro2."${deps.html5ever."0.24.1".proc_macro2}".default = true;
    quote."${deps.html5ever."0.24.1".quote}".default = true;
    syn = fold recursiveUpdate {} [
      { "${deps.html5ever."0.24.1".syn}"."extra-traits" = true; }
      { "${deps.html5ever."0.24.1".syn}"."fold" = true; }
      { "${deps.html5ever."0.24.1".syn}"."full" = true; }
      { "${deps.html5ever."0.24.1".syn}".default = true; }
    ];
  }) [
    (features_.log."${deps."html5ever"."0.24.1"."log"}" deps)
    (features_.mac."${deps."html5ever"."0.24.1"."mac"}" deps)
    (features_.markup5ever."${deps."html5ever"."0.24.1"."markup5ever"}" deps)
    (features_.proc_macro2."${deps."html5ever"."0.24.1"."proc_macro2"}" deps)
    (features_.quote."${deps."html5ever"."0.24.1"."quote"}" deps)
    (features_.syn."${deps."html5ever"."0.24.1"."syn"}" deps)
  ];


# end
# http-0.1.18

  crates.http."0.1.18" = deps: { features?(features_.http."0.1.18" deps {}) }: buildRustCrate {
    crateName = "http";
    version = "0.1.18";
    description = "A set of types for representing HTTP requests and responses.\n";
    authors = [ "Alex Crichton <alex@alexcrichton.com>" "Carl Lerche <me@carllerche.com>" "Sean McArthur <sean@seanmonstar.com>" ];
    sha256 = "0np5rnnbimmximdl2l7b0x1izzc4iwyw0qhzxlsx7hny423608rq";
    dependencies = mapFeatures features ([
      (crates."bytes"."${deps."http"."0.1.18"."bytes"}" deps)
      (crates."fnv"."${deps."http"."0.1.18"."fnv"}" deps)
      (crates."itoa"."${deps."http"."0.1.18"."itoa"}" deps)
    ]);
  };
  features_.http."0.1.18" = deps: f: updateFeatures f (rec {
    bytes."${deps.http."0.1.18".bytes}".default = true;
    fnv."${deps.http."0.1.18".fnv}".default = true;
    http."0.1.18".default = (f.http."0.1.18".default or true);
    itoa."${deps.http."0.1.18".itoa}".default = true;
  }) [
    (features_.bytes."${deps."http"."0.1.18"."bytes"}" deps)
    (features_.fnv."${deps."http"."0.1.18"."fnv"}" deps)
    (features_.itoa."${deps."http"."0.1.18"."itoa"}" deps)
  ];


# end
# http-body-0.1.0

  crates.http_body."0.1.0" = deps: { features?(features_.http_body."0.1.0" deps {}) }: buildRustCrate {
    crateName = "http-body";
    version = "0.1.0";
    description = "Trait representing an asynchronous, streaming, HTTP request or response body.\n";
    authors = [ "Carl Lerche <me@carllerche.com>" ];
    sha256 = "0rbk76455i6l9wrhcgq5p7hbvf9h9fc8ylbfphy4m5qswghly70m";
    dependencies = mapFeatures features ([
      (crates."bytes"."${deps."http_body"."0.1.0"."bytes"}" deps)
      (crates."futures"."${deps."http_body"."0.1.0"."futures"}" deps)
      (crates."http"."${deps."http_body"."0.1.0"."http"}" deps)
      (crates."tokio_buf"."${deps."http_body"."0.1.0"."tokio_buf"}" deps)
    ]);
  };
  features_.http_body."0.1.0" = deps: f: updateFeatures f (rec {
    bytes."${deps.http_body."0.1.0".bytes}".default = true;
    futures."${deps.http_body."0.1.0".futures}".default = true;
    http."${deps.http_body."0.1.0".http}".default = true;
    http_body."0.1.0".default = (f.http_body."0.1.0".default or true);
    tokio_buf."${deps.http_body."0.1.0".tokio_buf}".default = (f.tokio_buf."${deps.http_body."0.1.0".tokio_buf}".default or false);
  }) [
    (features_.bytes."${deps."http_body"."0.1.0"."bytes"}" deps)
    (features_.futures."${deps."http_body"."0.1.0"."futures"}" deps)
    (features_.http."${deps."http_body"."0.1.0"."http"}" deps)
    (features_.tokio_buf."${deps."http_body"."0.1.0"."tokio_buf"}" deps)
  ];


# end
# httparse-1.3.4

  crates.httparse."1.3.4" = deps: { features?(features_.httparse."1.3.4" deps {}) }: buildRustCrate {
    crateName = "httparse";
    version = "1.3.4";
    description = "A tiny, safe, speedy, zero-copy HTTP/1.x parser.";
    authors = [ "Sean McArthur <sean@seanmonstar.com>" ];
    sha256 = "0dggj4s0cq69bn63q9nqzzay5acmwl33nrbhjjsh5xys8sk2x4jw";
    build = "build.rs";
    features = mkFeatures (features."httparse"."1.3.4" or {});
  };
  features_.httparse."1.3.4" = deps: f: updateFeatures f (rec {
    httparse = fold recursiveUpdate {} [
      { "1.3.4"."std" =
        (f.httparse."1.3.4"."std" or false) ||
        (f.httparse."1.3.4".default or false) ||
        (httparse."1.3.4"."default" or false); }
      { "1.3.4".default = (f.httparse."1.3.4".default or true); }
    ];
  }) [];


# end
# hyper-0.12.35

  crates.hyper."0.12.35" = deps: { features?(features_.hyper."0.12.35" deps {}) }: buildRustCrate {
    crateName = "hyper";
    version = "0.12.35";
    description = "A fast and correct HTTP library.";
    authors = [ "Sean McArthur <sean@seanmonstar.com>" ];
    sha256 = "08sk7hasx0srs5pbffc851p4i748xx9dd8nc87r9a7kbjd9ph8d9";
    dependencies = mapFeatures features ([
      (crates."bytes"."${deps."hyper"."0.12.35"."bytes"}" deps)
      (crates."futures"."${deps."hyper"."0.12.35"."futures"}" deps)
      (crates."h2"."${deps."hyper"."0.12.35"."h2"}" deps)
      (crates."http"."${deps."hyper"."0.12.35"."http"}" deps)
      (crates."http_body"."${deps."hyper"."0.12.35"."http_body"}" deps)
      (crates."httparse"."${deps."hyper"."0.12.35"."httparse"}" deps)
      (crates."iovec"."${deps."hyper"."0.12.35"."iovec"}" deps)
      (crates."itoa"."${deps."hyper"."0.12.35"."itoa"}" deps)
      (crates."log"."${deps."hyper"."0.12.35"."log"}" deps)
      (crates."time"."${deps."hyper"."0.12.35"."time"}" deps)
      (crates."tokio_buf"."${deps."hyper"."0.12.35"."tokio_buf"}" deps)
      (crates."tokio_io"."${deps."hyper"."0.12.35"."tokio_io"}" deps)
      (crates."want"."${deps."hyper"."0.12.35"."want"}" deps)
    ]
      ++ (if features.hyper."0.12.35".futures-cpupool or false then [ (crates.futures_cpupool."${deps."hyper"."0.12.35".futures_cpupool}" deps) ] else [])
      ++ (if features.hyper."0.12.35".net2 or false then [ (crates.net2."${deps."hyper"."0.12.35".net2}" deps) ] else [])
      ++ (if features.hyper."0.12.35".tokio or false then [ (crates.tokio."${deps."hyper"."0.12.35".tokio}" deps) ] else [])
      ++ (if features.hyper."0.12.35".tokio-executor or false then [ (crates.tokio_executor."${deps."hyper"."0.12.35".tokio_executor}" deps) ] else [])
      ++ (if features.hyper."0.12.35".tokio-reactor or false then [ (crates.tokio_reactor."${deps."hyper"."0.12.35".tokio_reactor}" deps) ] else [])
      ++ (if features.hyper."0.12.35".tokio-tcp or false then [ (crates.tokio_tcp."${deps."hyper"."0.12.35".tokio_tcp}" deps) ] else [])
      ++ (if features.hyper."0.12.35".tokio-threadpool or false then [ (crates.tokio_threadpool."${deps."hyper"."0.12.35".tokio_threadpool}" deps) ] else [])
      ++ (if features.hyper."0.12.35".tokio-timer or false then [ (crates.tokio_timer."${deps."hyper"."0.12.35".tokio_timer}" deps) ] else []));

    buildDependencies = mapFeatures features ([
      (crates."rustc_version"."${deps."hyper"."0.12.35"."rustc_version"}" deps)
    ]);
    features = mkFeatures (features."hyper"."0.12.35" or {});
  };
  features_.hyper."0.12.35" = deps: f: updateFeatures f (rec {
    bytes."${deps.hyper."0.12.35".bytes}".default = true;
    futures."${deps.hyper."0.12.35".futures}".default = true;
    futures_cpupool."${deps.hyper."0.12.35".futures_cpupool}".default = true;
    h2."${deps.hyper."0.12.35".h2}".default = true;
    http."${deps.hyper."0.12.35".http}".default = true;
    http_body."${deps.hyper."0.12.35".http_body}".default = true;
    httparse."${deps.hyper."0.12.35".httparse}".default = true;
    hyper = fold recursiveUpdate {} [
      { "0.12.35"."__internal_flaky_tests" =
        (f.hyper."0.12.35"."__internal_flaky_tests" or false) ||
        (f.hyper."0.12.35".default or false) ||
        (hyper."0.12.35"."default" or false); }
      { "0.12.35"."futures-cpupool" =
        (f.hyper."0.12.35"."futures-cpupool" or false) ||
        (f.hyper."0.12.35".runtime or false) ||
        (hyper."0.12.35"."runtime" or false); }
      { "0.12.35"."net2" =
        (f.hyper."0.12.35"."net2" or false) ||
        (f.hyper."0.12.35".runtime or false) ||
        (hyper."0.12.35"."runtime" or false); }
      { "0.12.35"."runtime" =
        (f.hyper."0.12.35"."runtime" or false) ||
        (f.hyper."0.12.35".default or false) ||
        (hyper."0.12.35"."default" or false); }
      { "0.12.35"."tokio" =
        (f.hyper."0.12.35"."tokio" or false) ||
        (f.hyper."0.12.35".runtime or false) ||
        (hyper."0.12.35"."runtime" or false); }
      { "0.12.35"."tokio-executor" =
        (f.hyper."0.12.35"."tokio-executor" or false) ||
        (f.hyper."0.12.35".runtime or false) ||
        (hyper."0.12.35"."runtime" or false); }
      { "0.12.35"."tokio-reactor" =
        (f.hyper."0.12.35"."tokio-reactor" or false) ||
        (f.hyper."0.12.35".runtime or false) ||
        (hyper."0.12.35"."runtime" or false); }
      { "0.12.35"."tokio-tcp" =
        (f.hyper."0.12.35"."tokio-tcp" or false) ||
        (f.hyper."0.12.35".runtime or false) ||
        (hyper."0.12.35"."runtime" or false); }
      { "0.12.35"."tokio-threadpool" =
        (f.hyper."0.12.35"."tokio-threadpool" or false) ||
        (f.hyper."0.12.35".runtime or false) ||
        (hyper."0.12.35"."runtime" or false); }
      { "0.12.35"."tokio-timer" =
        (f.hyper."0.12.35"."tokio-timer" or false) ||
        (f.hyper."0.12.35".runtime or false) ||
        (hyper."0.12.35"."runtime" or false); }
      { "0.12.35".default = (f.hyper."0.12.35".default or true); }
    ];
    iovec."${deps.hyper."0.12.35".iovec}".default = true;
    itoa."${deps.hyper."0.12.35".itoa}".default = true;
    log."${deps.hyper."0.12.35".log}".default = true;
    net2."${deps.hyper."0.12.35".net2}".default = true;
    rustc_version."${deps.hyper."0.12.35".rustc_version}".default = true;
    time."${deps.hyper."0.12.35".time}".default = true;
    tokio = fold recursiveUpdate {} [
      { "${deps.hyper."0.12.35".tokio}"."rt-full" = true; }
      { "${deps.hyper."0.12.35".tokio}".default = (f.tokio."${deps.hyper."0.12.35".tokio}".default or false); }
    ];
    tokio_buf."${deps.hyper."0.12.35".tokio_buf}".default = true;
    tokio_executor."${deps.hyper."0.12.35".tokio_executor}".default = true;
    tokio_io."${deps.hyper."0.12.35".tokio_io}".default = true;
    tokio_reactor."${deps.hyper."0.12.35".tokio_reactor}".default = true;
    tokio_tcp."${deps.hyper."0.12.35".tokio_tcp}".default = true;
    tokio_threadpool."${deps.hyper."0.12.35".tokio_threadpool}".default = true;
    tokio_timer."${deps.hyper."0.12.35".tokio_timer}".default = true;
    want."${deps.hyper."0.12.35".want}".default = true;
  }) [
    (features_.bytes."${deps."hyper"."0.12.35"."bytes"}" deps)
    (features_.futures."${deps."hyper"."0.12.35"."futures"}" deps)
    (features_.futures_cpupool."${deps."hyper"."0.12.35"."futures_cpupool"}" deps)
    (features_.h2."${deps."hyper"."0.12.35"."h2"}" deps)
    (features_.http."${deps."hyper"."0.12.35"."http"}" deps)
    (features_.http_body."${deps."hyper"."0.12.35"."http_body"}" deps)
    (features_.httparse."${deps."hyper"."0.12.35"."httparse"}" deps)
    (features_.iovec."${deps."hyper"."0.12.35"."iovec"}" deps)
    (features_.itoa."${deps."hyper"."0.12.35"."itoa"}" deps)
    (features_.log."${deps."hyper"."0.12.35"."log"}" deps)
    (features_.net2."${deps."hyper"."0.12.35"."net2"}" deps)
    (features_.time."${deps."hyper"."0.12.35"."time"}" deps)
    (features_.tokio."${deps."hyper"."0.12.35"."tokio"}" deps)
    (features_.tokio_buf."${deps."hyper"."0.12.35"."tokio_buf"}" deps)
    (features_.tokio_executor."${deps."hyper"."0.12.35"."tokio_executor"}" deps)
    (features_.tokio_io."${deps."hyper"."0.12.35"."tokio_io"}" deps)
    (features_.tokio_reactor."${deps."hyper"."0.12.35"."tokio_reactor"}" deps)
    (features_.tokio_tcp."${deps."hyper"."0.12.35"."tokio_tcp"}" deps)
    (features_.tokio_threadpool."${deps."hyper"."0.12.35"."tokio_threadpool"}" deps)
    (features_.tokio_timer."${deps."hyper"."0.12.35"."tokio_timer"}" deps)
    (features_.want."${deps."hyper"."0.12.35"."want"}" deps)
    (features_.rustc_version."${deps."hyper"."0.12.35"."rustc_version"}" deps)
  ];


# end
# hyper-tls-0.3.2

  crates.hyper_tls."0.3.2" = deps: { features?(features_.hyper_tls."0.3.2" deps {}) }: buildRustCrate {
    crateName = "hyper-tls";
    version = "0.3.2";
    description = "Default TLS implementation for use with hyper";
    authors = [ "Sean McArthur <sean@seanmonstar.com>" ];
    sha256 = "01naqv4zxfj3vzwa5m56vh6l8kg8y8wp8qgc1pm883vsrawa7anx";
    dependencies = mapFeatures features ([
      (crates."bytes"."${deps."hyper_tls"."0.3.2"."bytes"}" deps)
      (crates."futures"."${deps."hyper_tls"."0.3.2"."futures"}" deps)
      (crates."hyper"."${deps."hyper_tls"."0.3.2"."hyper"}" deps)
      (crates."native_tls"."${deps."hyper_tls"."0.3.2"."native_tls"}" deps)
      (crates."tokio_io"."${deps."hyper_tls"."0.3.2"."tokio_io"}" deps)
    ]);
    features = mkFeatures (features."hyper_tls"."0.3.2" or {});
  };
  features_.hyper_tls."0.3.2" = deps: f: updateFeatures f (rec {
    bytes."${deps.hyper_tls."0.3.2".bytes}".default = true;
    futures."${deps.hyper_tls."0.3.2".futures}".default = true;
    hyper."${deps.hyper_tls."0.3.2".hyper}".default = true;
    hyper_tls."0.3.2".default = (f.hyper_tls."0.3.2".default or true);
    native_tls = fold recursiveUpdate {} [
      { "${deps.hyper_tls."0.3.2".native_tls}"."vendored" =
        (f.native_tls."${deps.hyper_tls."0.3.2".native_tls}"."vendored" or false) ||
        (hyper_tls."0.3.2"."vendored" or false) ||
        (f."hyper_tls"."0.3.2"."vendored" or false); }
      { "${deps.hyper_tls."0.3.2".native_tls}".default = true; }
    ];
    tokio_io."${deps.hyper_tls."0.3.2".tokio_io}".default = true;
  }) [
    (features_.bytes."${deps."hyper_tls"."0.3.2"."bytes"}" deps)
    (features_.futures."${deps."hyper_tls"."0.3.2"."futures"}" deps)
    (features_.hyper."${deps."hyper_tls"."0.3.2"."hyper"}" deps)
    (features_.native_tls."${deps."hyper_tls"."0.3.2"."native_tls"}" deps)
    (features_.tokio_io."${deps."hyper_tls"."0.3.2"."tokio_io"}" deps)
  ];


# end
# idna-0.1.5

  crates.idna."0.1.5" = deps: { features?(features_.idna."0.1.5" deps {}) }: buildRustCrate {
    crateName = "idna";
    version = "0.1.5";
    description = "IDNA (Internationalizing Domain Names in Applications) and Punycode.";
    authors = [ "The rust-url developers" ];
    sha256 = "1gwgl19rz5vzi67rrhamczhxy050f5ynx4ybabfapyalv7z1qmjy";
    dependencies = mapFeatures features ([
      (crates."matches"."${deps."idna"."0.1.5"."matches"}" deps)
      (crates."unicode_bidi"."${deps."idna"."0.1.5"."unicode_bidi"}" deps)
      (crates."unicode_normalization"."${deps."idna"."0.1.5"."unicode_normalization"}" deps)
    ]);
  };
  features_.idna."0.1.5" = deps: f: updateFeatures f (rec {
    idna."0.1.5".default = (f.idna."0.1.5".default or true);
    matches."${deps.idna."0.1.5".matches}".default = true;
    unicode_bidi."${deps.idna."0.1.5".unicode_bidi}".default = true;
    unicode_normalization."${deps.idna."0.1.5".unicode_normalization}".default = true;
  }) [
    (features_.matches."${deps."idna"."0.1.5"."matches"}" deps)
    (features_.unicode_bidi."${deps."idna"."0.1.5"."unicode_bidi"}" deps)
    (features_.unicode_normalization."${deps."idna"."0.1.5"."unicode_normalization"}" deps)
  ];


# end
# idna-0.2.0

  crates.idna."0.2.0" = deps: { features?(features_.idna."0.2.0" deps {}) }: buildRustCrate {
    crateName = "idna";
    version = "0.2.0";
    description = "IDNA (Internationalizing Domain Names in Applications) and Punycode.";
    authors = [ "The rust-url developers" ];
    sha256 = "1mm05aq43qc5n492njnac5xn4rhiraii25xc0hwppr471jzijh8d";
    dependencies = mapFeatures features ([
      (crates."matches"."${deps."idna"."0.2.0"."matches"}" deps)
      (crates."unicode_bidi"."${deps."idna"."0.2.0"."unicode_bidi"}" deps)
      (crates."unicode_normalization"."${deps."idna"."0.2.0"."unicode_normalization"}" deps)
    ]);
  };
  features_.idna."0.2.0" = deps: f: updateFeatures f (rec {
    idna."0.2.0".default = (f.idna."0.2.0".default or true);
    matches."${deps.idna."0.2.0".matches}".default = true;
    unicode_bidi."${deps.idna."0.2.0".unicode_bidi}".default = true;
    unicode_normalization."${deps.idna."0.2.0".unicode_normalization}".default = true;
  }) [
    (features_.matches."${deps."idna"."0.2.0"."matches"}" deps)
    (features_.unicode_bidi."${deps."idna"."0.2.0"."unicode_bidi"}" deps)
    (features_.unicode_normalization."${deps."idna"."0.2.0"."unicode_normalization"}" deps)
  ];


# end
# indexmap-1.2.0

  crates.indexmap."1.2.0" = deps: { features?(features_.indexmap."1.2.0" deps {}) }: buildRustCrate {
    crateName = "indexmap";
    version = "1.2.0";
    description = "A hash table with consistent order and fast iteration.\n\nThe indexmap is a hash table where the iteration order of the key-value\npairs is independent of the hash values of the keys. It has the usual\nhash table functionality, it preserves insertion order except after\nremovals, and it allows lookup of its elements by either hash table key\nor numerical index. A corresponding hash set type is also provided.\n\nThis crate was initially published under the name ordermap, but it was renamed to\nindexmap.\n";
    authors = [ "bluss" "Josh Stone <cuviper@gmail.com>" ];
    sha256 = "0c2vi7p3zhfh536lgqq579f644k9ilq9v8xnk1w4av481hxlal97";
    dependencies = mapFeatures features ([
]);
    features = mkFeatures (features."indexmap"."1.2.0" or {});
  };
  features_.indexmap."1.2.0" = deps: f: updateFeatures f (rec {
    indexmap = fold recursiveUpdate {} [
      { "1.2.0"."serde" =
        (f.indexmap."1.2.0"."serde" or false) ||
        (f.indexmap."1.2.0".serde-1 or false) ||
        (indexmap."1.2.0"."serde-1" or false); }
      { "1.2.0".default = (f.indexmap."1.2.0".default or true); }
    ];
  }) [];


# end
# iovec-0.1.2

  crates.iovec."0.1.2" = deps: { features?(features_.iovec."0.1.2" deps {}) }: buildRustCrate {
    crateName = "iovec";
    version = "0.1.2";
    description = "Portable buffer type for scatter/gather I/O operations\n";
    authors = [ "Carl Lerche <me@carllerche.com>" ];
    sha256 = "0vjymmb7wj4v4kza5jjn48fcdb85j3k37y7msjl3ifz0p9yiyp2r";
    dependencies = (if (kernel == "linux" || kernel == "darwin") then mapFeatures features ([
      (crates."libc"."${deps."iovec"."0.1.2"."libc"}" deps)
    ]) else [])
      ++ (if kernel == "windows" then mapFeatures features ([
      (crates."winapi"."${deps."iovec"."0.1.2"."winapi"}" deps)
    ]) else []);
  };
  features_.iovec."0.1.2" = deps: f: updateFeatures f (rec {
    iovec."0.1.2".default = (f.iovec."0.1.2".default or true);
    libc."${deps.iovec."0.1.2".libc}".default = true;
    winapi."${deps.iovec."0.1.2".winapi}".default = true;
  }) [
    (features_.libc."${deps."iovec"."0.1.2"."libc"}" deps)
    (features_.winapi."${deps."iovec"."0.1.2"."winapi"}" deps)
  ];


# end
# itoa-0.4.4

  crates.itoa."0.4.4" = deps: { features?(features_.itoa."0.4.4" deps {}) }: buildRustCrate {
    crateName = "itoa";
    version = "0.4.4";
    description = "Fast functions for printing integer primitives to an io::Write";
    authors = [ "David Tolnay <dtolnay@gmail.com>" ];
    sha256 = "1fqc34xzzl2spfdawxd9awhzl0fwf1y6y4i94l8bq8rfrzd90awl";
    features = mkFeatures (features."itoa"."0.4.4" or {});
  };
  features_.itoa."0.4.4" = deps: f: updateFeatures f (rec {
    itoa = fold recursiveUpdate {} [
      { "0.4.4"."std" =
        (f.itoa."0.4.4"."std" or false) ||
        (f.itoa."0.4.4".default or false) ||
        (itoa."0.4.4"."default" or false); }
      { "0.4.4".default = (f.itoa."0.4.4".default or true); }
    ];
  }) [];


# end
# kernel32-sys-0.2.2

  crates.kernel32_sys."0.2.2" = deps: { features?(features_.kernel32_sys."0.2.2" deps {}) }: buildRustCrate {
    crateName = "kernel32-sys";
    version = "0.2.2";
    description = "Contains function definitions for the Windows API library kernel32. See winapi for types and constants.";
    authors = [ "Peter Atashian <retep998@gmail.com>" ];
    sha256 = "1lrw1hbinyvr6cp28g60z97w32w8vsk6pahk64pmrv2fmby8srfj";
    libName = "kernel32";
    build = "build.rs";
    dependencies = mapFeatures features ([
      (crates."winapi"."${deps."kernel32_sys"."0.2.2"."winapi"}" deps)
    ]);

    buildDependencies = mapFeatures features ([
      (crates."winapi_build"."${deps."kernel32_sys"."0.2.2"."winapi_build"}" deps)
    ]);
  };
  features_.kernel32_sys."0.2.2" = deps: f: updateFeatures f (rec {
    kernel32_sys."0.2.2".default = (f.kernel32_sys."0.2.2".default or true);
    winapi."${deps.kernel32_sys."0.2.2".winapi}".default = true;
    winapi_build."${deps.kernel32_sys."0.2.2".winapi_build}".default = true;
  }) [
    (features_.winapi."${deps."kernel32_sys"."0.2.2"."winapi"}" deps)
    (features_.winapi_build."${deps."kernel32_sys"."0.2.2"."winapi_build"}" deps)
  ];


# end
# lazy_static-1.4.0

  crates.lazy_static."1.4.0" = deps: { features?(features_.lazy_static."1.4.0" deps {}) }: buildRustCrate {
    crateName = "lazy_static";
    version = "1.4.0";
    description = "A macro for declaring lazily evaluated statics in Rust.";
    authors = [ "Marvin Löbel <loebel.marvin@gmail.com>" ];
    sha256 = "13h6sdghdcy7vcqsm2gasfw3qg7ssa0fl3sw7lq6pdkbk52wbyfr";
    dependencies = mapFeatures features ([
]);
    features = mkFeatures (features."lazy_static"."1.4.0" or {});
  };
  features_.lazy_static."1.4.0" = deps: f: updateFeatures f (rec {
    lazy_static = fold recursiveUpdate {} [
      { "1.4.0"."spin" =
        (f.lazy_static."1.4.0"."spin" or false) ||
        (f.lazy_static."1.4.0".spin_no_std or false) ||
        (lazy_static."1.4.0"."spin_no_std" or false); }
      { "1.4.0".default = (f.lazy_static."1.4.0".default or true); }
    ];
  }) [];


# end
# libc-0.2.62

  crates.libc."0.2.62" = deps: { features?(features_.libc."0.2.62" deps {}) }: buildRustCrate {
    crateName = "libc";
    version = "0.2.62";
    description = "Raw FFI bindings to platform libraries like libc.\n";
    authors = [ "The Rust Project Developers" ];
    sha256 = "1vsb4pyn6gl6sri6cv5hin5wjfgk7lk2bshzmxb1xnkckjhz4gbx";
    build = "build.rs";
    dependencies = mapFeatures features ([
]);
    features = mkFeatures (features."libc"."0.2.62" or {});
  };
  features_.libc."0.2.62" = deps: f: updateFeatures f (rec {
    libc = fold recursiveUpdate {} [
      { "0.2.62"."align" =
        (f.libc."0.2.62"."align" or false) ||
        (f.libc."0.2.62".rustc-dep-of-std or false) ||
        (libc."0.2.62"."rustc-dep-of-std" or false); }
      { "0.2.62"."rustc-std-workspace-core" =
        (f.libc."0.2.62"."rustc-std-workspace-core" or false) ||
        (f.libc."0.2.62".rustc-dep-of-std or false) ||
        (libc."0.2.62"."rustc-dep-of-std" or false); }
      { "0.2.62"."std" =
        (f.libc."0.2.62"."std" or false) ||
        (f.libc."0.2.62".default or false) ||
        (libc."0.2.62"."default" or false) ||
        (f.libc."0.2.62".use_std or false) ||
        (libc."0.2.62"."use_std" or false); }
      { "0.2.62".default = (f.libc."0.2.62".default or true); }
    ];
  }) [];


# end
# lock_api-0.1.5

  crates.lock_api."0.1.5" = deps: { features?(features_.lock_api."0.1.5" deps {}) }: buildRustCrate {
    crateName = "lock_api";
    version = "0.1.5";
    description = "Wrappers to create fully-featured Mutex and RwLock types. Compatible with no_std.";
    authors = [ "Amanieu d'Antras <amanieu@gmail.com>" ];
    sha256 = "132sidr5hvjfkaqm3l95zpcpi8yk5ddd0g79zf1ad4v65sxirqqm";
    dependencies = mapFeatures features ([
      (crates."scopeguard"."${deps."lock_api"."0.1.5"."scopeguard"}" deps)
    ]
      ++ (if features.lock_api."0.1.5".owning_ref or false then [ (crates.owning_ref."${deps."lock_api"."0.1.5".owning_ref}" deps) ] else []));
    features = mkFeatures (features."lock_api"."0.1.5" or {});
  };
  features_.lock_api."0.1.5" = deps: f: updateFeatures f (rec {
    lock_api."0.1.5".default = (f.lock_api."0.1.5".default or true);
    owning_ref."${deps.lock_api."0.1.5".owning_ref}".default = true;
    scopeguard."${deps.lock_api."0.1.5".scopeguard}".default = (f.scopeguard."${deps.lock_api."0.1.5".scopeguard}".default or false);
  }) [
    (features_.owning_ref."${deps."lock_api"."0.1.5"."owning_ref"}" deps)
    (features_.scopeguard."${deps."lock_api"."0.1.5"."scopeguard"}" deps)
  ];


# end
# log-0.4.8

  crates.log."0.4.8" = deps: { features?(features_.log."0.4.8" deps {}) }: buildRustCrate {
    crateName = "log";
    version = "0.4.8";
    description = "A lightweight logging facade for Rust\n";
    authors = [ "The Rust Project Developers" ];
    sha256 = "0wvzzzcn89dai172rrqcyz06pzldyyy0lf0w71csmn206rdpnb15";
    build = "build.rs";
    dependencies = mapFeatures features ([
      (crates."cfg_if"."${deps."log"."0.4.8"."cfg_if"}" deps)
    ]);
    features = mkFeatures (features."log"."0.4.8" or {});
  };
  features_.log."0.4.8" = deps: f: updateFeatures f (rec {
    cfg_if."${deps.log."0.4.8".cfg_if}".default = true;
    log = fold recursiveUpdate {} [
      { "0.4.8"."kv_unstable" =
        (f.log."0.4.8"."kv_unstable" or false) ||
        (f.log."0.4.8".kv_unstable_sval or false) ||
        (log."0.4.8"."kv_unstable_sval" or false); }
      { "0.4.8".default = (f.log."0.4.8".default or true); }
    ];
  }) [
    (features_.cfg_if."${deps."log"."0.4.8"."cfg_if"}" deps)
  ];


# end
# mac-0.1.1

  crates.mac."0.1.1" = deps: { features?(features_.mac."0.1.1" deps {}) }: buildRustCrate {
    crateName = "mac";
    version = "0.1.1";
    description = "A collection of great and ubiqutitous macros.";
    authors = [ "Jonathan Reem <jonathan.reem@gmail.com>" ];
    sha256 = "17fq2w1q33swr37dvpdc50xiaslym2jak4jrix83a075kk18c8fm";
  };
  features_.mac."0.1.1" = deps: f: updateFeatures f (rec {
    mac."0.1.1".default = (f.mac."0.1.1".default or true);
  }) [];


# end
# markup5ever-0.7.5

  crates.markup5ever."0.7.5" = deps: { features?(features_.markup5ever."0.7.5" deps {}) }: buildRustCrate {
    crateName = "markup5ever";
    version = "0.7.5";
    description = "Common code for xml5ever and html5ever";
    authors = [ "The html5ever Project Developers" ];
    sha256 = "039m4lsyhnma1jkrjlk8rwqhmvc1jgbs8dskqn16gc2yr5f6ji2k";
    libPath = "lib.rs";
    build = "build.rs";
    dependencies = mapFeatures features ([
      (crates."phf"."${deps."markup5ever"."0.7.5"."phf"}" deps)
      (crates."string_cache"."${deps."markup5ever"."0.7.5"."string_cache"}" deps)
      (crates."tendril"."${deps."markup5ever"."0.7.5"."tendril"}" deps)
    ]);

    buildDependencies = mapFeatures features ([
      (crates."phf_codegen"."${deps."markup5ever"."0.7.5"."phf_codegen"}" deps)
      (crates."serde"."${deps."markup5ever"."0.7.5"."serde"}" deps)
      (crates."serde_derive"."${deps."markup5ever"."0.7.5"."serde_derive"}" deps)
      (crates."serde_json"."${deps."markup5ever"."0.7.5"."serde_json"}" deps)
      (crates."string_cache_codegen"."${deps."markup5ever"."0.7.5"."string_cache_codegen"}" deps)
    ]);
  };
  features_.markup5ever."0.7.5" = deps: f: updateFeatures f (rec {
    markup5ever."0.7.5".default = (f.markup5ever."0.7.5".default or true);
    phf."${deps.markup5ever."0.7.5".phf}".default = true;
    phf_codegen."${deps.markup5ever."0.7.5".phf_codegen}".default = true;
    serde."${deps.markup5ever."0.7.5".serde}".default = true;
    serde_derive."${deps.markup5ever."0.7.5".serde_derive}".default = true;
    serde_json."${deps.markup5ever."0.7.5".serde_json}".default = true;
    string_cache."${deps.markup5ever."0.7.5".string_cache}".default = true;
    string_cache_codegen."${deps.markup5ever."0.7.5".string_cache_codegen}".default = true;
    tendril."${deps.markup5ever."0.7.5".tendril}".default = true;
  }) [
    (features_.phf."${deps."markup5ever"."0.7.5"."phf"}" deps)
    (features_.string_cache."${deps."markup5ever"."0.7.5"."string_cache"}" deps)
    (features_.tendril."${deps."markup5ever"."0.7.5"."tendril"}" deps)
    (features_.phf_codegen."${deps."markup5ever"."0.7.5"."phf_codegen"}" deps)
    (features_.serde."${deps."markup5ever"."0.7.5"."serde"}" deps)
    (features_.serde_derive."${deps."markup5ever"."0.7.5"."serde_derive"}" deps)
    (features_.serde_json."${deps."markup5ever"."0.7.5"."serde_json"}" deps)
    (features_.string_cache_codegen."${deps."markup5ever"."0.7.5"."string_cache_codegen"}" deps)
  ];


# end
# markup5ever-0.8.1

  crates.markup5ever."0.8.1" = deps: { features?(features_.markup5ever."0.8.1" deps {}) }: buildRustCrate {
    crateName = "markup5ever";
    version = "0.8.1";
    description = "Common code for xml5ever and html5ever";
    authors = [ "The html5ever Project Developers" ];
    sha256 = "1ng754w1nxnnzjznr74jxhqss44garqgkgjjcbg2b305vnc2wzhi";
    libPath = "lib.rs";
    build = "build.rs";
    dependencies = mapFeatures features ([
      (crates."log"."${deps."markup5ever"."0.8.1"."log"}" deps)
      (crates."phf"."${deps."markup5ever"."0.8.1"."phf"}" deps)
      (crates."string_cache"."${deps."markup5ever"."0.8.1"."string_cache"}" deps)
      (crates."tendril"."${deps."markup5ever"."0.8.1"."tendril"}" deps)
    ]);

    buildDependencies = mapFeatures features ([
      (crates."phf_codegen"."${deps."markup5ever"."0.8.1"."phf_codegen"}" deps)
      (crates."serde"."${deps."markup5ever"."0.8.1"."serde"}" deps)
      (crates."serde_derive"."${deps."markup5ever"."0.8.1"."serde_derive"}" deps)
      (crates."serde_json"."${deps."markup5ever"."0.8.1"."serde_json"}" deps)
      (crates."string_cache_codegen"."${deps."markup5ever"."0.8.1"."string_cache_codegen"}" deps)
    ]);
  };
  features_.markup5ever."0.8.1" = deps: f: updateFeatures f (rec {
    log."${deps.markup5ever."0.8.1".log}".default = true;
    markup5ever."0.8.1".default = (f.markup5ever."0.8.1".default or true);
    phf."${deps.markup5ever."0.8.1".phf}".default = true;
    phf_codegen."${deps.markup5ever."0.8.1".phf_codegen}".default = true;
    serde."${deps.markup5ever."0.8.1".serde}".default = true;
    serde_derive."${deps.markup5ever."0.8.1".serde_derive}".default = true;
    serde_json."${deps.markup5ever."0.8.1".serde_json}".default = true;
    string_cache."${deps.markup5ever."0.8.1".string_cache}".default = true;
    string_cache_codegen."${deps.markup5ever."0.8.1".string_cache_codegen}".default = true;
    tendril."${deps.markup5ever."0.8.1".tendril}".default = true;
  }) [
    (features_.log."${deps."markup5ever"."0.8.1"."log"}" deps)
    (features_.phf."${deps."markup5ever"."0.8.1"."phf"}" deps)
    (features_.string_cache."${deps."markup5ever"."0.8.1"."string_cache"}" deps)
    (features_.tendril."${deps."markup5ever"."0.8.1"."tendril"}" deps)
    (features_.phf_codegen."${deps."markup5ever"."0.8.1"."phf_codegen"}" deps)
    (features_.serde."${deps."markup5ever"."0.8.1"."serde"}" deps)
    (features_.serde_derive."${deps."markup5ever"."0.8.1"."serde_derive"}" deps)
    (features_.serde_json."${deps."markup5ever"."0.8.1"."serde_json"}" deps)
    (features_.string_cache_codegen."${deps."markup5ever"."0.8.1"."string_cache_codegen"}" deps)
  ];


# end
# markup5ever-0.9.0

  crates.markup5ever."0.9.0" = deps: { features?(features_.markup5ever."0.9.0" deps {}) }: buildRustCrate {
    crateName = "markup5ever";
    version = "0.9.0";
    description = "Common code for xml5ever and html5ever";
    authors = [ "The html5ever Project Developers" ];
    sha256 = "016czs9gj217m1azzsnqbz9sgp0a9jgm8wvnnphc9yg6lwb21qmp";
    libPath = "lib.rs";
    build = "build.rs";
    dependencies = mapFeatures features ([
      (crates."log"."${deps."markup5ever"."0.9.0"."log"}" deps)
      (crates."phf"."${deps."markup5ever"."0.9.0"."phf"}" deps)
      (crates."string_cache"."${deps."markup5ever"."0.9.0"."string_cache"}" deps)
      (crates."tendril"."${deps."markup5ever"."0.9.0"."tendril"}" deps)
    ]);

    buildDependencies = mapFeatures features ([
      (crates."phf_codegen"."${deps."markup5ever"."0.9.0"."phf_codegen"}" deps)
      (crates."serde"."${deps."markup5ever"."0.9.0"."serde"}" deps)
      (crates."serde_derive"."${deps."markup5ever"."0.9.0"."serde_derive"}" deps)
      (crates."serde_json"."${deps."markup5ever"."0.9.0"."serde_json"}" deps)
      (crates."string_cache_codegen"."${deps."markup5ever"."0.9.0"."string_cache_codegen"}" deps)
    ]);
  };
  features_.markup5ever."0.9.0" = deps: f: updateFeatures f (rec {
    log."${deps.markup5ever."0.9.0".log}".default = true;
    markup5ever."0.9.0".default = (f.markup5ever."0.9.0".default or true);
    phf."${deps.markup5ever."0.9.0".phf}".default = true;
    phf_codegen."${deps.markup5ever."0.9.0".phf_codegen}".default = true;
    serde."${deps.markup5ever."0.9.0".serde}".default = true;
    serde_derive."${deps.markup5ever."0.9.0".serde_derive}".default = true;
    serde_json."${deps.markup5ever."0.9.0".serde_json}".default = true;
    string_cache."${deps.markup5ever."0.9.0".string_cache}".default = true;
    string_cache_codegen."${deps.markup5ever."0.9.0".string_cache_codegen}".default = true;
    tendril."${deps.markup5ever."0.9.0".tendril}".default = true;
  }) [
    (features_.log."${deps."markup5ever"."0.9.0"."log"}" deps)
    (features_.phf."${deps."markup5ever"."0.9.0"."phf"}" deps)
    (features_.string_cache."${deps."markup5ever"."0.9.0"."string_cache"}" deps)
    (features_.tendril."${deps."markup5ever"."0.9.0"."tendril"}" deps)
    (features_.phf_codegen."${deps."markup5ever"."0.9.0"."phf_codegen"}" deps)
    (features_.serde."${deps."markup5ever"."0.9.0"."serde"}" deps)
    (features_.serde_derive."${deps."markup5ever"."0.9.0"."serde_derive"}" deps)
    (features_.serde_json."${deps."markup5ever"."0.9.0"."serde_json"}" deps)
    (features_.string_cache_codegen."${deps."markup5ever"."0.9.0"."string_cache_codegen"}" deps)
  ];


# end
# matches-0.1.8

  crates.matches."0.1.8" = deps: { features?(features_.matches."0.1.8" deps {}) }: buildRustCrate {
    crateName = "matches";
    version = "0.1.8";
    description = "A macro to evaluate, as a boolean, whether an expression matches a pattern.";
    authors = [ "Simon Sapin <simon.sapin@exyr.org>" ];
    sha256 = "03hl636fg6xggy0a26200xs74amk3k9n0908rga2szn68agyz3cv";
    libPath = "lib.rs";
  };
  features_.matches."0.1.8" = deps: f: updateFeatures f (rec {
    matches."0.1.8".default = (f.matches."0.1.8".default or true);
  }) [];


# end
# memchr-2.2.1

  crates.memchr."2.2.1" = deps: { features?(features_.memchr."2.2.1" deps {}) }: buildRustCrate {
    crateName = "memchr";
    version = "2.2.1";
    description = "Safe interface to memchr.";
    authors = [ "Andrew Gallant <jamslam@gmail.com>" "bluss" ];
    sha256 = "1mj5z8lhz6jbapslpq8a39pwcsl1p0jmgp7wgcj7nv4pcqhya7a0";
    dependencies = mapFeatures features ([
]);
    features = mkFeatures (features."memchr"."2.2.1" or {});
  };
  features_.memchr."2.2.1" = deps: f: updateFeatures f (rec {
    memchr = fold recursiveUpdate {} [
      { "2.2.1"."use_std" =
        (f.memchr."2.2.1"."use_std" or false) ||
        (f.memchr."2.2.1".default or false) ||
        (memchr."2.2.1"."default" or false); }
      { "2.2.1".default = (f.memchr."2.2.1".default or true); }
    ];
  }) [];


# end
# memoffset-0.5.1

  crates.memoffset."0.5.1" = deps: { features?(features_.memoffset."0.5.1" deps {}) }: buildRustCrate {
    crateName = "memoffset";
    version = "0.5.1";
    description = "offset_of functionality for Rust structs.";
    authors = [ "Gilad Naaman <gilad.naaman@gmail.com>" ];
    sha256 = "0fsk7kfk193f1aamafl45vvcp7j6p7c14ss7d583fijw3w5kj69k";

    buildDependencies = mapFeatures features ([
      (crates."rustc_version"."${deps."memoffset"."0.5.1"."rustc_version"}" deps)
    ]);
  };
  features_.memoffset."0.5.1" = deps: f: updateFeatures f (rec {
    memoffset."0.5.1".default = (f.memoffset."0.5.1".default or true);
    rustc_version."${deps.memoffset."0.5.1".rustc_version}".default = true;
  }) [
    (features_.rustc_version."${deps."memoffset"."0.5.1"."rustc_version"}" deps)
  ];


# end
# mime-0.3.14

  crates.mime."0.3.14" = deps: { features?(features_.mime."0.3.14" deps {}) }: buildRustCrate {
    crateName = "mime";
    version = "0.3.14";
    description = "Strongly Typed Mimes";
    authors = [ "Sean McArthur <sean@seanmonstar.com>" ];
    sha256 = "1hn2fiwzkla2062jyhq1lsjzk6544978fy4hg9c778m0qkva2par";
  };
  features_.mime."0.3.14" = deps: f: updateFeatures f (rec {
    mime."0.3.14".default = (f.mime."0.3.14".default or true);
  }) [];


# end
# mime_guess-2.0.1

  crates.mime_guess."2.0.1" = deps: { features?(features_.mime_guess."2.0.1" deps {}) }: buildRustCrate {
    crateName = "mime_guess";
    version = "2.0.1";
    description = "A simple crate for detection of a file's MIME type by its extension.";
    authors = [ "Austin Bonander <austin.bonander@gmail.com>" ];
    sha256 = "18wrpddfxipwhhw5q7wdykdcp0sm0zq7jizjrcvdnrg80kyg8nsk";
    dependencies = mapFeatures features ([
      (crates."mime"."${deps."mime_guess"."2.0.1"."mime"}" deps)
      (crates."unicase"."${deps."mime_guess"."2.0.1"."unicase"}" deps)
    ]);

    buildDependencies = mapFeatures features ([
      (crates."unicase"."${deps."mime_guess"."2.0.1"."unicase"}" deps)
    ]);
    features = mkFeatures (features."mime_guess"."2.0.1" or {});
  };
  features_.mime_guess."2.0.1" = deps: f: updateFeatures f (rec {
    mime."${deps.mime_guess."2.0.1".mime}".default = true;
    mime_guess = fold recursiveUpdate {} [
      { "2.0.1"."rev-mappings" =
        (f.mime_guess."2.0.1"."rev-mappings" or false) ||
        (f.mime_guess."2.0.1".default or false) ||
        (mime_guess."2.0.1"."default" or false); }
      { "2.0.1".default = (f.mime_guess."2.0.1".default or true); }
    ];
    unicase."${deps.mime_guess."2.0.1".unicase}".default = true;
  }) [
    (features_.mime."${deps."mime_guess"."2.0.1"."mime"}" deps)
    (features_.unicase."${deps."mime_guess"."2.0.1"."unicase"}" deps)
    (features_.unicase."${deps."mime_guess"."2.0.1"."unicase"}" deps)
  ];


# end
# miniz_oxide-0.3.2

  crates.miniz_oxide."0.3.2" = deps: { features?(features_.miniz_oxide."0.3.2" deps {}) }: buildRustCrate {
    crateName = "miniz_oxide";
    version = "0.3.2";
    description = "DEFLATE compression and decompression library rewritten in Rust based on miniz";
    authors = [ "Frommi <daniil.liferenko@gmail.com>" "oyvindln <oyvindln@users.noreply.github.com>" ];
    edition = "2018";
    sha256 = "013d6pswvpnxq6i43i96m9ba2c5ljda1x96hxsc5c180zqvb3b08";
    dependencies = mapFeatures features ([
      (crates."adler32"."${deps."miniz_oxide"."0.3.2"."adler32"}" deps)
    ]);
  };
  features_.miniz_oxide."0.3.2" = deps: f: updateFeatures f (rec {
    adler32."${deps.miniz_oxide."0.3.2".adler32}".default = true;
    miniz_oxide."0.3.2".default = (f.miniz_oxide."0.3.2".default or true);
  }) [
    (features_.adler32."${deps."miniz_oxide"."0.3.2"."adler32"}" deps)
  ];


# end
# mio-0.6.19

  crates.mio."0.6.19" = deps: { features?(features_.mio."0.6.19" deps {}) }: buildRustCrate {
    crateName = "mio";
    version = "0.6.19";
    description = "Lightweight non-blocking IO";
    authors = [ "Carl Lerche <me@carllerche.com>" ];
    sha256 = "0pjazzvqwkb4fgmm4b3m8i05c2gq60lvqqia0faawswgqy7rvgac";
    dependencies = mapFeatures features ([
      (crates."iovec"."${deps."mio"."0.6.19"."iovec"}" deps)
      (crates."log"."${deps."mio"."0.6.19"."log"}" deps)
      (crates."net2"."${deps."mio"."0.6.19"."net2"}" deps)
      (crates."slab"."${deps."mio"."0.6.19"."slab"}" deps)
    ])
      ++ (if kernel == "fuchsia" then mapFeatures features ([
      (crates."fuchsia_zircon"."${deps."mio"."0.6.19"."fuchsia_zircon"}" deps)
      (crates."fuchsia_zircon_sys"."${deps."mio"."0.6.19"."fuchsia_zircon_sys"}" deps)
    ]) else [])
      ++ (if (kernel == "linux" || kernel == "darwin") then mapFeatures features ([
      (crates."libc"."${deps."mio"."0.6.19"."libc"}" deps)
    ]) else [])
      ++ (if kernel == "windows" then mapFeatures features ([
      (crates."kernel32_sys"."${deps."mio"."0.6.19"."kernel32_sys"}" deps)
      (crates."miow"."${deps."mio"."0.6.19"."miow"}" deps)
      (crates."winapi"."${deps."mio"."0.6.19"."winapi"}" deps)
    ]) else []);
    features = mkFeatures (features."mio"."0.6.19" or {});
  };
  features_.mio."0.6.19" = deps: f: updateFeatures f (rec {
    fuchsia_zircon."${deps.mio."0.6.19".fuchsia_zircon}".default = true;
    fuchsia_zircon_sys."${deps.mio."0.6.19".fuchsia_zircon_sys}".default = true;
    iovec."${deps.mio."0.6.19".iovec}".default = true;
    kernel32_sys."${deps.mio."0.6.19".kernel32_sys}".default = true;
    libc."${deps.mio."0.6.19".libc}".default = true;
    log."${deps.mio."0.6.19".log}".default = true;
    mio = fold recursiveUpdate {} [
      { "0.6.19"."with-deprecated" =
        (f.mio."0.6.19"."with-deprecated" or false) ||
        (f.mio."0.6.19".default or false) ||
        (mio."0.6.19"."default" or false); }
      { "0.6.19".default = (f.mio."0.6.19".default or true); }
    ];
    miow."${deps.mio."0.6.19".miow}".default = true;
    net2."${deps.mio."0.6.19".net2}".default = true;
    slab."${deps.mio."0.6.19".slab}".default = true;
    winapi."${deps.mio."0.6.19".winapi}".default = true;
  }) [
    (features_.iovec."${deps."mio"."0.6.19"."iovec"}" deps)
    (features_.log."${deps."mio"."0.6.19"."log"}" deps)
    (features_.net2."${deps."mio"."0.6.19"."net2"}" deps)
    (features_.slab."${deps."mio"."0.6.19"."slab"}" deps)
    (features_.fuchsia_zircon."${deps."mio"."0.6.19"."fuchsia_zircon"}" deps)
    (features_.fuchsia_zircon_sys."${deps."mio"."0.6.19"."fuchsia_zircon_sys"}" deps)
    (features_.libc."${deps."mio"."0.6.19"."libc"}" deps)
    (features_.kernel32_sys."${deps."mio"."0.6.19"."kernel32_sys"}" deps)
    (features_.miow."${deps."mio"."0.6.19"."miow"}" deps)
    (features_.winapi."${deps."mio"."0.6.19"."winapi"}" deps)
  ];


# end
# miow-0.2.1

  crates.miow."0.2.1" = deps: { features?(features_.miow."0.2.1" deps {}) }: buildRustCrate {
    crateName = "miow";
    version = "0.2.1";
    description = "A zero overhead I/O library for Windows, focusing on IOCP and Async I/O\nabstractions.\n";
    authors = [ "Alex Crichton <alex@alexcrichton.com>" ];
    sha256 = "14f8zkc6ix7mkyis1vsqnim8m29b6l55abkba3p2yz7j1ibcvrl0";
    dependencies = mapFeatures features ([
      (crates."kernel32_sys"."${deps."miow"."0.2.1"."kernel32_sys"}" deps)
      (crates."net2"."${deps."miow"."0.2.1"."net2"}" deps)
      (crates."winapi"."${deps."miow"."0.2.1"."winapi"}" deps)
      (crates."ws2_32_sys"."${deps."miow"."0.2.1"."ws2_32_sys"}" deps)
    ]);
  };
  features_.miow."0.2.1" = deps: f: updateFeatures f (rec {
    kernel32_sys."${deps.miow."0.2.1".kernel32_sys}".default = true;
    miow."0.2.1".default = (f.miow."0.2.1".default or true);
    net2."${deps.miow."0.2.1".net2}".default = (f.net2."${deps.miow."0.2.1".net2}".default or false);
    winapi."${deps.miow."0.2.1".winapi}".default = true;
    ws2_32_sys."${deps.miow."0.2.1".ws2_32_sys}".default = true;
  }) [
    (features_.kernel32_sys."${deps."miow"."0.2.1"."kernel32_sys"}" deps)
    (features_.net2."${deps."miow"."0.2.1"."net2"}" deps)
    (features_.winapi."${deps."miow"."0.2.1"."winapi"}" deps)
    (features_.ws2_32_sys."${deps."miow"."0.2.1"."ws2_32_sys"}" deps)
  ];


# end
# native-tls-0.2.3

  crates.native_tls."0.2.3" = deps: { features?(features_.native_tls."0.2.3" deps {}) }: buildRustCrate {
    crateName = "native-tls";
    version = "0.2.3";
    description = "A wrapper over a platform's native TLS implementation";
    authors = [ "Steven Fackler <sfackler@gmail.com>" ];
    sha256 = "19bmkzcj2qvyxchlqa1yg2g5awjmk6sigm20mfwajfcczbq3dc6j";
    dependencies = (if kernel == "darwin" || kernel == "ios" then mapFeatures features ([
      (crates."lazy_static"."${deps."native_tls"."0.2.3"."lazy_static"}" deps)
      (crates."libc"."${deps."native_tls"."0.2.3"."libc"}" deps)
      (crates."security_framework"."${deps."native_tls"."0.2.3"."security_framework"}" deps)
      (crates."security_framework_sys"."${deps."native_tls"."0.2.3"."security_framework_sys"}" deps)
      (crates."tempfile"."${deps."native_tls"."0.2.3"."tempfile"}" deps)
    ]) else [])
      ++ (if !(kernel == "windows" || kernel == "darwin" || kernel == "ios") then mapFeatures features ([
      (crates."log"."${deps."native_tls"."0.2.3"."log"}" deps)
      (crates."openssl"."${deps."native_tls"."0.2.3"."openssl"}" deps)
      (crates."openssl_probe"."${deps."native_tls"."0.2.3"."openssl_probe"}" deps)
      (crates."openssl_sys"."${deps."native_tls"."0.2.3"."openssl_sys"}" deps)
    ]) else [])
      ++ (if kernel == "windows" then mapFeatures features ([
      (crates."schannel"."${deps."native_tls"."0.2.3"."schannel"}" deps)
    ]) else []);
    features = mkFeatures (features."native_tls"."0.2.3" or {});
  };
  features_.native_tls."0.2.3" = deps: f: updateFeatures f (rec {
    lazy_static."${deps.native_tls."0.2.3".lazy_static}".default = true;
    libc."${deps.native_tls."0.2.3".libc}".default = true;
    log."${deps.native_tls."0.2.3".log}".default = true;
    native_tls."0.2.3".default = (f.native_tls."0.2.3".default or true);
    openssl."${deps.native_tls."0.2.3".openssl}".default = true;
    openssl_probe."${deps.native_tls."0.2.3".openssl_probe}".default = true;
    openssl_sys."${deps.native_tls."0.2.3".openssl_sys}".default = true;
    schannel."${deps.native_tls."0.2.3".schannel}".default = true;
    security_framework."${deps.native_tls."0.2.3".security_framework}".default = true;
    security_framework_sys."${deps.native_tls."0.2.3".security_framework_sys}".default = true;
    tempfile."${deps.native_tls."0.2.3".tempfile}".default = true;
  }) [
    (features_.lazy_static."${deps."native_tls"."0.2.3"."lazy_static"}" deps)
    (features_.libc."${deps."native_tls"."0.2.3"."libc"}" deps)
    (features_.security_framework."${deps."native_tls"."0.2.3"."security_framework"}" deps)
    (features_.security_framework_sys."${deps."native_tls"."0.2.3"."security_framework_sys"}" deps)
    (features_.tempfile."${deps."native_tls"."0.2.3"."tempfile"}" deps)
    (features_.log."${deps."native_tls"."0.2.3"."log"}" deps)
    (features_.openssl."${deps."native_tls"."0.2.3"."openssl"}" deps)
    (features_.openssl_probe."${deps."native_tls"."0.2.3"."openssl_probe"}" deps)
    (features_.openssl_sys."${deps."native_tls"."0.2.3"."openssl_sys"}" deps)
    (features_.schannel."${deps."native_tls"."0.2.3"."schannel"}" deps)
  ];


# end
# net2-0.2.33

  crates.net2."0.2.33" = deps: { features?(features_.net2."0.2.33" deps {}) }: buildRustCrate {
    crateName = "net2";
    version = "0.2.33";
    description = "Extensions to the standard library's networking types as proposed in RFC 1158.\n";
    authors = [ "Alex Crichton <alex@alexcrichton.com>" ];
    sha256 = "1qnmajafgybj5wyxz9iffa8x5wgbwd2znfklmhqj7vl6lw1m65mq";
    dependencies = mapFeatures features ([
      (crates."cfg_if"."${deps."net2"."0.2.33"."cfg_if"}" deps)
    ])
      ++ (if kernel == "redox" || (kernel == "linux" || kernel == "darwin") then mapFeatures features ([
      (crates."libc"."${deps."net2"."0.2.33"."libc"}" deps)
    ]) else [])
      ++ (if kernel == "windows" then mapFeatures features ([
      (crates."winapi"."${deps."net2"."0.2.33"."winapi"}" deps)
    ]) else []);
    features = mkFeatures (features."net2"."0.2.33" or {});
  };
  features_.net2."0.2.33" = deps: f: updateFeatures f (rec {
    cfg_if."${deps.net2."0.2.33".cfg_if}".default = true;
    libc."${deps.net2."0.2.33".libc}".default = true;
    net2 = fold recursiveUpdate {} [
      { "0.2.33"."duration" =
        (f.net2."0.2.33"."duration" or false) ||
        (f.net2."0.2.33".default or false) ||
        (net2."0.2.33"."default" or false); }
      { "0.2.33".default = (f.net2."0.2.33".default or true); }
    ];
    winapi = fold recursiveUpdate {} [
      { "${deps.net2."0.2.33".winapi}"."handleapi" = true; }
      { "${deps.net2."0.2.33".winapi}"."winsock2" = true; }
      { "${deps.net2."0.2.33".winapi}"."ws2def" = true; }
      { "${deps.net2."0.2.33".winapi}"."ws2ipdef" = true; }
      { "${deps.net2."0.2.33".winapi}"."ws2tcpip" = true; }
      { "${deps.net2."0.2.33".winapi}".default = true; }
    ];
  }) [
    (features_.cfg_if."${deps."net2"."0.2.33"."cfg_if"}" deps)
    (features_.libc."${deps."net2"."0.2.33"."libc"}" deps)
    (features_.winapi."${deps."net2"."0.2.33"."winapi"}" deps)
  ];


# end
# new_debug_unreachable-1.0.3

  crates.new_debug_unreachable."1.0.3" = deps: { features?(features_.new_debug_unreachable."1.0.3" deps {}) }: buildRustCrate {
    crateName = "new_debug_unreachable";
    version = "1.0.3";
    description = "panic in debug, intrinsics::unreachable() in release (fork of debug_unreachable)";
    authors = [ "Matt Brubeck <mbrubeck@limpet.net>" "Jonathan Reem <jonathan.reem@gmail.com>" ];
    sha256 = "1lxbd0n9gwvzg41bxiij0c28g1sp1jhp4h1rh10qisc8viyhsdj0";
    libPath = "src/lib.rs";
    libName = "debug_unreachable";
  };
  features_.new_debug_unreachable."1.0.3" = deps: f: updateFeatures f (rec {
    new_debug_unreachable."1.0.3".default = (f.new_debug_unreachable."1.0.3".default or true);
  }) [];


# end
# nodrop-0.1.13

  crates.nodrop."0.1.13" = deps: { features?(features_.nodrop."0.1.13" deps {}) }: buildRustCrate {
    crateName = "nodrop";
    version = "0.1.13";
    description = "A wrapper type to inhibit drop (destructor). Use std::mem::ManuallyDrop instead!";
    authors = [ "bluss" ];
    sha256 = "0gkfx6wihr9z0m8nbdhma5pyvbipznjpkzny2d4zkc05b0vnhinb";
    dependencies = mapFeatures features ([
]);
    features = mkFeatures (features."nodrop"."0.1.13" or {});
  };
  features_.nodrop."0.1.13" = deps: f: updateFeatures f (rec {
    nodrop = fold recursiveUpdate {} [
      { "0.1.13"."nodrop-union" =
        (f.nodrop."0.1.13"."nodrop-union" or false) ||
        (f.nodrop."0.1.13".use_union or false) ||
        (nodrop."0.1.13"."use_union" or false); }
      { "0.1.13"."std" =
        (f.nodrop."0.1.13"."std" or false) ||
        (f.nodrop."0.1.13".default or false) ||
        (nodrop."0.1.13"."default" or false); }
      { "0.1.13".default = (f.nodrop."0.1.13".default or true); }
    ];
  }) [];


# end
# num_cpus-1.10.1

  crates.num_cpus."1.10.1" = deps: { features?(features_.num_cpus."1.10.1" deps {}) }: buildRustCrate {
    crateName = "num_cpus";
    version = "1.10.1";
    description = "Get the number of CPUs on a machine.";
    authors = [ "Sean McArthur <sean@seanmonstar.com>" ];
    sha256 = "1zi5s2cbnqqb0k0kdd6gqn2x97f9bssv44430h6w28awwzppyh8i";
    dependencies = mapFeatures features ([
      (crates."libc"."${deps."num_cpus"."1.10.1"."libc"}" deps)
    ]);
  };
  features_.num_cpus."1.10.1" = deps: f: updateFeatures f (rec {
    libc."${deps.num_cpus."1.10.1".libc}".default = true;
    num_cpus."1.10.1".default = (f.num_cpus."1.10.1".default or true);
  }) [
    (features_.libc."${deps."num_cpus"."1.10.1"."libc"}" deps)
  ];


# end
# openssl-0.10.24

  crates.openssl."0.10.24" = deps: { features?(features_.openssl."0.10.24" deps {}) }: buildRustCrate {
    crateName = "openssl";
    version = "0.10.24";
    description = "OpenSSL bindings";
    authors = [ "Steven Fackler <sfackler@gmail.com>" ];
    sha256 = "0w0ibpy5waw192xqz889znqdvzdnigwwfknqm9038l6id4xmw1mr";
    dependencies = mapFeatures features ([
      (crates."bitflags"."${deps."openssl"."0.10.24"."bitflags"}" deps)
      (crates."cfg_if"."${deps."openssl"."0.10.24"."cfg_if"}" deps)
      (crates."foreign_types"."${deps."openssl"."0.10.24"."foreign_types"}" deps)
      (crates."lazy_static"."${deps."openssl"."0.10.24"."lazy_static"}" deps)
      (crates."libc"."${deps."openssl"."0.10.24"."libc"}" deps)
      (crates."openssl_sys"."${deps."openssl"."0.10.24"."openssl_sys"}" deps)
    ]);
    features = mkFeatures (features."openssl"."0.10.24" or {});
  };
  features_.openssl."0.10.24" = deps: f: updateFeatures f (rec {
    bitflags."${deps.openssl."0.10.24".bitflags}".default = true;
    cfg_if."${deps.openssl."0.10.24".cfg_if}".default = true;
    foreign_types."${deps.openssl."0.10.24".foreign_types}".default = true;
    lazy_static."${deps.openssl."0.10.24".lazy_static}".default = true;
    libc."${deps.openssl."0.10.24".libc}".default = true;
    openssl."0.10.24".default = (f.openssl."0.10.24".default or true);
    openssl_sys = fold recursiveUpdate {} [
      { "${deps.openssl."0.10.24".openssl_sys}"."vendored" =
        (f.openssl_sys."${deps.openssl."0.10.24".openssl_sys}"."vendored" or false) ||
        (openssl."0.10.24"."vendored" or false) ||
        (f."openssl"."0.10.24"."vendored" or false); }
      { "${deps.openssl."0.10.24".openssl_sys}".default = true; }
    ];
  }) [
    (features_.bitflags."${deps."openssl"."0.10.24"."bitflags"}" deps)
    (features_.cfg_if."${deps."openssl"."0.10.24"."cfg_if"}" deps)
    (features_.foreign_types."${deps."openssl"."0.10.24"."foreign_types"}" deps)
    (features_.lazy_static."${deps."openssl"."0.10.24"."lazy_static"}" deps)
    (features_.libc."${deps."openssl"."0.10.24"."libc"}" deps)
    (features_.openssl_sys."${deps."openssl"."0.10.24"."openssl_sys"}" deps)
  ];


# end
# openssl-probe-0.1.2

  crates.openssl_probe."0.1.2" = deps: { features?(features_.openssl_probe."0.1.2" deps {}) }: buildRustCrate {
    crateName = "openssl-probe";
    version = "0.1.2";
    description = "Tool for helping to find SSL certificate locations on the system for OpenSSL\n";
    authors = [ "Alex Crichton <alex@alexcrichton.com>" ];
    sha256 = "1a89fznx26vvaxyrxdvgf6iwai5xvs6xjvpjin68fgvrslv6n15a";
  };
  features_.openssl_probe."0.1.2" = deps: f: updateFeatures f (rec {
    openssl_probe."0.1.2".default = (f.openssl_probe."0.1.2".default or true);
  }) [];


# end
# openssl-sys-0.9.49

  crates.openssl_sys."0.9.49" = deps: { features?(features_.openssl_sys."0.9.49" deps {}) }: buildRustCrate {
    crateName = "openssl-sys";
    version = "0.9.49";
    description = "FFI bindings to OpenSSL";
    authors = [ "Alex Crichton <alex@alexcrichton.com>" "Steven Fackler <sfackler@gmail.com>" ];
    sha256 = "0bjgw81f5ry05yrhqyby68g9acfsg6yadbzwm2yh3axd77c7zq8a";
    build = "build/main.rs";
    dependencies = mapFeatures features ([
      (crates."libc"."${deps."openssl_sys"."0.9.49"."libc"}" deps)
    ])
      ++ (if abi == "msvc" then mapFeatures features ([
]) else []);

    buildDependencies = mapFeatures features ([
      (crates."autocfg"."${deps."openssl_sys"."0.9.49"."autocfg"}" deps)
      (crates."cc"."${deps."openssl_sys"."0.9.49"."cc"}" deps)
      (crates."pkg_config"."${deps."openssl_sys"."0.9.49"."pkg_config"}" deps)
    ]);
    features = mkFeatures (features."openssl_sys"."0.9.49" or {});
  };
  features_.openssl_sys."0.9.49" = deps: f: updateFeatures f (rec {
    autocfg."${deps.openssl_sys."0.9.49".autocfg}".default = true;
    cc."${deps.openssl_sys."0.9.49".cc}".default = true;
    libc."${deps.openssl_sys."0.9.49".libc}".default = true;
    openssl_sys = fold recursiveUpdate {} [
      { "0.9.49"."openssl-src" =
        (f.openssl_sys."0.9.49"."openssl-src" or false) ||
        (f.openssl_sys."0.9.49".vendored or false) ||
        (openssl_sys."0.9.49"."vendored" or false); }
      { "0.9.49".default = (f.openssl_sys."0.9.49".default or true); }
    ];
    pkg_config."${deps.openssl_sys."0.9.49".pkg_config}".default = true;
  }) [
    (features_.libc."${deps."openssl_sys"."0.9.49"."libc"}" deps)
    (features_.autocfg."${deps."openssl_sys"."0.9.49"."autocfg"}" deps)
    (features_.cc."${deps."openssl_sys"."0.9.49"."cc"}" deps)
    (features_.pkg_config."${deps."openssl_sys"."0.9.49"."pkg_config"}" deps)
  ];


# end
# owning_ref-0.4.0

  crates.owning_ref."0.4.0" = deps: { features?(features_.owning_ref."0.4.0" deps {}) }: buildRustCrate {
    crateName = "owning_ref";
    version = "0.4.0";
    description = "A library for creating references that carry their owner with them.";
    authors = [ "Marvin Löbel <loebel.marvin@gmail.com>" ];
    sha256 = "1m95qpc3hamkw9wlbfzqkzk7h6skyj40zr6sa3ps151slcfnnchm";
    dependencies = mapFeatures features ([
      (crates."stable_deref_trait"."${deps."owning_ref"."0.4.0"."stable_deref_trait"}" deps)
    ]);
  };
  features_.owning_ref."0.4.0" = deps: f: updateFeatures f (rec {
    owning_ref."0.4.0".default = (f.owning_ref."0.4.0".default or true);
    stable_deref_trait."${deps.owning_ref."0.4.0".stable_deref_trait}".default = true;
  }) [
    (features_.stable_deref_trait."${deps."owning_ref"."0.4.0"."stable_deref_trait"}" deps)
  ];


# end
# parking_lot-0.7.1

  crates.parking_lot."0.7.1" = deps: { features?(features_.parking_lot."0.7.1" deps {}) }: buildRustCrate {
    crateName = "parking_lot";
    version = "0.7.1";
    description = "More compact and efficient implementations of the standard synchronization primitives.";
    authors = [ "Amanieu d'Antras <amanieu@gmail.com>" ];
    sha256 = "1qpb49xd176hqqabxdb48f1hvylfbf68rpz8yfrhw0x68ys0lkq1";
    dependencies = mapFeatures features ([
      (crates."lock_api"."${deps."parking_lot"."0.7.1"."lock_api"}" deps)
      (crates."parking_lot_core"."${deps."parking_lot"."0.7.1"."parking_lot_core"}" deps)
    ]);
    features = mkFeatures (features."parking_lot"."0.7.1" or {});
  };
  features_.parking_lot."0.7.1" = deps: f: updateFeatures f (rec {
    lock_api = fold recursiveUpdate {} [
      { "${deps.parking_lot."0.7.1".lock_api}"."nightly" =
        (f.lock_api."${deps.parking_lot."0.7.1".lock_api}"."nightly" or false) ||
        (parking_lot."0.7.1"."nightly" or false) ||
        (f."parking_lot"."0.7.1"."nightly" or false); }
      { "${deps.parking_lot."0.7.1".lock_api}"."owning_ref" =
        (f.lock_api."${deps.parking_lot."0.7.1".lock_api}"."owning_ref" or false) ||
        (parking_lot."0.7.1"."owning_ref" or false) ||
        (f."parking_lot"."0.7.1"."owning_ref" or false); }
      { "${deps.parking_lot."0.7.1".lock_api}".default = true; }
    ];
    parking_lot = fold recursiveUpdate {} [
      { "0.7.1"."owning_ref" =
        (f.parking_lot."0.7.1"."owning_ref" or false) ||
        (f.parking_lot."0.7.1".default or false) ||
        (parking_lot."0.7.1"."default" or false); }
      { "0.7.1".default = (f.parking_lot."0.7.1".default or true); }
    ];
    parking_lot_core = fold recursiveUpdate {} [
      { "${deps.parking_lot."0.7.1".parking_lot_core}"."deadlock_detection" =
        (f.parking_lot_core."${deps.parking_lot."0.7.1".parking_lot_core}"."deadlock_detection" or false) ||
        (parking_lot."0.7.1"."deadlock_detection" or false) ||
        (f."parking_lot"."0.7.1"."deadlock_detection" or false); }
      { "${deps.parking_lot."0.7.1".parking_lot_core}"."nightly" =
        (f.parking_lot_core."${deps.parking_lot."0.7.1".parking_lot_core}"."nightly" or false) ||
        (parking_lot."0.7.1"."nightly" or false) ||
        (f."parking_lot"."0.7.1"."nightly" or false); }
      { "${deps.parking_lot."0.7.1".parking_lot_core}".default = true; }
    ];
  }) [
    (features_.lock_api."${deps."parking_lot"."0.7.1"."lock_api"}" deps)
    (features_.parking_lot_core."${deps."parking_lot"."0.7.1"."parking_lot_core"}" deps)
  ];


# end
# parking_lot_core-0.4.0

  crates.parking_lot_core."0.4.0" = deps: { features?(features_.parking_lot_core."0.4.0" deps {}) }: buildRustCrate {
    crateName = "parking_lot_core";
    version = "0.4.0";
    description = "An advanced API for creating custom synchronization primitives.";
    authors = [ "Amanieu d'Antras <amanieu@gmail.com>" ];
    sha256 = "1mzk5i240ddvhwnz65hhjk4cq61z235g1n8bd7al4mg6vx437c16";
    dependencies = mapFeatures features ([
      (crates."rand"."${deps."parking_lot_core"."0.4.0"."rand"}" deps)
      (crates."smallvec"."${deps."parking_lot_core"."0.4.0"."smallvec"}" deps)
    ])
      ++ (if (kernel == "linux" || kernel == "darwin") then mapFeatures features ([
      (crates."libc"."${deps."parking_lot_core"."0.4.0"."libc"}" deps)
    ]) else [])
      ++ (if kernel == "windows" then mapFeatures features ([
      (crates."winapi"."${deps."parking_lot_core"."0.4.0"."winapi"}" deps)
    ]) else []);

    buildDependencies = mapFeatures features ([
      (crates."rustc_version"."${deps."parking_lot_core"."0.4.0"."rustc_version"}" deps)
    ]);
    features = mkFeatures (features."parking_lot_core"."0.4.0" or {});
  };
  features_.parking_lot_core."0.4.0" = deps: f: updateFeatures f (rec {
    libc."${deps.parking_lot_core."0.4.0".libc}".default = true;
    parking_lot_core = fold recursiveUpdate {} [
      { "0.4.0"."backtrace" =
        (f.parking_lot_core."0.4.0"."backtrace" or false) ||
        (f.parking_lot_core."0.4.0".deadlock_detection or false) ||
        (parking_lot_core."0.4.0"."deadlock_detection" or false); }
      { "0.4.0"."petgraph" =
        (f.parking_lot_core."0.4.0"."petgraph" or false) ||
        (f.parking_lot_core."0.4.0".deadlock_detection or false) ||
        (parking_lot_core."0.4.0"."deadlock_detection" or false); }
      { "0.4.0"."thread-id" =
        (f.parking_lot_core."0.4.0"."thread-id" or false) ||
        (f.parking_lot_core."0.4.0".deadlock_detection or false) ||
        (parking_lot_core."0.4.0"."deadlock_detection" or false); }
      { "0.4.0".default = (f.parking_lot_core."0.4.0".default or true); }
    ];
    rand."${deps.parking_lot_core."0.4.0".rand}".default = true;
    rustc_version."${deps.parking_lot_core."0.4.0".rustc_version}".default = true;
    smallvec."${deps.parking_lot_core."0.4.0".smallvec}".default = true;
    winapi = fold recursiveUpdate {} [
      { "${deps.parking_lot_core."0.4.0".winapi}"."errhandlingapi" = true; }
      { "${deps.parking_lot_core."0.4.0".winapi}"."handleapi" = true; }
      { "${deps.parking_lot_core."0.4.0".winapi}"."minwindef" = true; }
      { "${deps.parking_lot_core."0.4.0".winapi}"."ntstatus" = true; }
      { "${deps.parking_lot_core."0.4.0".winapi}"."winbase" = true; }
      { "${deps.parking_lot_core."0.4.0".winapi}"."winerror" = true; }
      { "${deps.parking_lot_core."0.4.0".winapi}"."winnt" = true; }
      { "${deps.parking_lot_core."0.4.0".winapi}".default = true; }
    ];
  }) [
    (features_.rand."${deps."parking_lot_core"."0.4.0"."rand"}" deps)
    (features_.smallvec."${deps."parking_lot_core"."0.4.0"."smallvec"}" deps)
    (features_.rustc_version."${deps."parking_lot_core"."0.4.0"."rustc_version"}" deps)
    (features_.libc."${deps."parking_lot_core"."0.4.0"."libc"}" deps)
    (features_.winapi."${deps."parking_lot_core"."0.4.0"."winapi"}" deps)
  ];


# end
# percent-encoding-1.0.1

  crates.percent_encoding."1.0.1" = deps: { features?(features_.percent_encoding."1.0.1" deps {}) }: buildRustCrate {
    crateName = "percent-encoding";
    version = "1.0.1";
    description = "Percent encoding and decoding";
    authors = [ "The rust-url developers" ];
    sha256 = "04ahrp7aw4ip7fmadb0bknybmkfav0kk0gw4ps3ydq5w6hr0ib5i";
    libPath = "lib.rs";
  };
  features_.percent_encoding."1.0.1" = deps: f: updateFeatures f (rec {
    percent_encoding."1.0.1".default = (f.percent_encoding."1.0.1".default or true);
  }) [];


# end
# percent-encoding-2.1.0

  crates.percent_encoding."2.1.0" = deps: { features?(features_.percent_encoding."2.1.0" deps {}) }: buildRustCrate {
    crateName = "percent-encoding";
    version = "2.1.0";
    description = "Percent encoding and decoding";
    authors = [ "The rust-url developers" ];
    sha256 = "0i838f2nr81585ckmfymf8l1x1vdmx6n8xqvli0lgcy60yl2axy3";
    libPath = "lib.rs";
  };
  features_.percent_encoding."2.1.0" = deps: f: updateFeatures f (rec {
    percent_encoding."2.1.0".default = (f.percent_encoding."2.1.0".default or true);
  }) [];


# end
# phf-0.7.24

  crates.phf."0.7.24" = deps: { features?(features_.phf."0.7.24" deps {}) }: buildRustCrate {
    crateName = "phf";
    version = "0.7.24";
    description = "Runtime support for perfect hash function data structures";
    authors = [ "Steven Fackler <sfackler@gmail.com>" ];
    sha256 = "19mmhmafd1dhywc7pzkmd1nq0kjfvg57viny20jqa91hhprf2dv5";
    libPath = "src/lib.rs";
    dependencies = mapFeatures features ([
      (crates."phf_shared"."${deps."phf"."0.7.24"."phf_shared"}" deps)
    ]);
    features = mkFeatures (features."phf"."0.7.24" or {});
  };
  features_.phf."0.7.24" = deps: f: updateFeatures f (rec {
    phf = fold recursiveUpdate {} [
      { "0.7.24"."phf_macros" =
        (f.phf."0.7.24"."phf_macros" or false) ||
        (f.phf."0.7.24".macros or false) ||
        (phf."0.7.24"."macros" or false); }
      { "0.7.24".default = (f.phf."0.7.24".default or true); }
    ];
    phf_shared = fold recursiveUpdate {} [
      { "${deps.phf."0.7.24".phf_shared}"."core" =
        (f.phf_shared."${deps.phf."0.7.24".phf_shared}"."core" or false) ||
        (phf."0.7.24"."core" or false) ||
        (f."phf"."0.7.24"."core" or false); }
      { "${deps.phf."0.7.24".phf_shared}"."unicase" =
        (f.phf_shared."${deps.phf."0.7.24".phf_shared}"."unicase" or false) ||
        (phf."0.7.24"."unicase" or false) ||
        (f."phf"."0.7.24"."unicase" or false); }
      { "${deps.phf."0.7.24".phf_shared}".default = true; }
    ];
  }) [
    (features_.phf_shared."${deps."phf"."0.7.24"."phf_shared"}" deps)
  ];


# end
# phf_codegen-0.7.24

  crates.phf_codegen."0.7.24" = deps: { features?(features_.phf_codegen."0.7.24" deps {}) }: buildRustCrate {
    crateName = "phf_codegen";
    version = "0.7.24";
    description = "Codegen library for PHF types";
    authors = [ "Steven Fackler <sfackler@gmail.com>" ];
    sha256 = "0avkx97r4ph8rv70wwgniarlcfiq27yd74gmnxfdv3rx840cyf8g";
    dependencies = mapFeatures features ([
      (crates."phf_generator"."${deps."phf_codegen"."0.7.24"."phf_generator"}" deps)
      (crates."phf_shared"."${deps."phf_codegen"."0.7.24"."phf_shared"}" deps)
    ]);
  };
  features_.phf_codegen."0.7.24" = deps: f: updateFeatures f (rec {
    phf_codegen."0.7.24".default = (f.phf_codegen."0.7.24".default or true);
    phf_generator."${deps.phf_codegen."0.7.24".phf_generator}".default = true;
    phf_shared."${deps.phf_codegen."0.7.24".phf_shared}".default = true;
  }) [
    (features_.phf_generator."${deps."phf_codegen"."0.7.24"."phf_generator"}" deps)
    (features_.phf_shared."${deps."phf_codegen"."0.7.24"."phf_shared"}" deps)
  ];


# end
# phf_generator-0.7.24

  crates.phf_generator."0.7.24" = deps: { features?(features_.phf_generator."0.7.24" deps {}) }: buildRustCrate {
    crateName = "phf_generator";
    version = "0.7.24";
    description = "PHF generation logic";
    authors = [ "Steven Fackler <sfackler@gmail.com>" ];
    sha256 = "1frn2jfydinifxb1fki0xnnsxf0f1ciaa79jz415r5qhw1ash72j";
    dependencies = mapFeatures features ([
      (crates."phf_shared"."${deps."phf_generator"."0.7.24"."phf_shared"}" deps)
      (crates."rand"."${deps."phf_generator"."0.7.24"."rand"}" deps)
    ]);
  };
  features_.phf_generator."0.7.24" = deps: f: updateFeatures f (rec {
    phf_generator."0.7.24".default = (f.phf_generator."0.7.24".default or true);
    phf_shared."${deps.phf_generator."0.7.24".phf_shared}".default = true;
    rand."${deps.phf_generator."0.7.24".rand}".default = true;
  }) [
    (features_.phf_shared."${deps."phf_generator"."0.7.24"."phf_shared"}" deps)
    (features_.rand."${deps."phf_generator"."0.7.24"."rand"}" deps)
  ];


# end
# phf_shared-0.7.24

  crates.phf_shared."0.7.24" = deps: { features?(features_.phf_shared."0.7.24" deps {}) }: buildRustCrate {
    crateName = "phf_shared";
    version = "0.7.24";
    description = "Support code shared by PHF libraries";
    authors = [ "Steven Fackler <sfackler@gmail.com>" ];
    sha256 = "1hndqn461jvm2r269ym4qh7fnjc6n8yy53avc2pb43p70vxhm9rl";
    libPath = "src/lib.rs";
    dependencies = mapFeatures features ([
      (crates."siphasher"."${deps."phf_shared"."0.7.24"."siphasher"}" deps)
    ]);
    features = mkFeatures (features."phf_shared"."0.7.24" or {});
  };
  features_.phf_shared."0.7.24" = deps: f: updateFeatures f (rec {
    phf_shared."0.7.24".default = (f.phf_shared."0.7.24".default or true);
    siphasher."${deps.phf_shared."0.7.24".siphasher}".default = true;
  }) [
    (features_.siphasher."${deps."phf_shared"."0.7.24"."siphasher"}" deps)
  ];


# end
# pkg-config-0.3.16

  crates.pkg_config."0.3.16" = deps: { features?(features_.pkg_config."0.3.16" deps {}) }: buildRustCrate {
    crateName = "pkg-config";
    version = "0.3.16";
    description = "A library to run the pkg-config system tool at build time in order to be used in\nCargo build scripts.\n";
    authors = [ "Alex Crichton <alex@alexcrichton.com>" ];
    sha256 = "1a2gg5a9l74brz1vzkkzfl8aihd7b4rk3vhbmiahkmpzavywza5j";
  };
  features_.pkg_config."0.3.16" = deps: f: updateFeatures f (rec {
    pkg_config."0.3.16".default = (f.pkg_config."0.3.16".default or true);
  }) [];


# end
# ppv-lite86-0.2.5

  crates.ppv_lite86."0.2.5" = deps: { features?(features_.ppv_lite86."0.2.5" deps {}) }: buildRustCrate {
    crateName = "ppv-lite86";
    version = "0.2.5";
    description = "Implementation of the crypto-simd API for x86";
    authors = [ "The CryptoCorrosion Contributors" ];
    edition = "2018";
    sha256 = "1r3bhih75vhl8v7q0flmywl7hmfg902yf3jjzracsh0jlkldij6r";
    features = mkFeatures (features."ppv_lite86"."0.2.5" or {});
  };
  features_.ppv_lite86."0.2.5" = deps: f: updateFeatures f (rec {
    ppv_lite86 = fold recursiveUpdate {} [
      { "0.2.5"."simd" =
        (f.ppv_lite86."0.2.5"."simd" or false) ||
        (f.ppv_lite86."0.2.5".default or false) ||
        (ppv_lite86."0.2.5"."default" or false); }
      { "0.2.5"."std" =
        (f.ppv_lite86."0.2.5"."std" or false) ||
        (f.ppv_lite86."0.2.5".default or false) ||
        (ppv_lite86."0.2.5"."default" or false); }
      { "0.2.5".default = (f.ppv_lite86."0.2.5".default or true); }
    ];
  }) [];


# end
# precomputed-hash-0.1.1

  crates.precomputed_hash."0.1.1" = deps: { features?(features_.precomputed_hash."0.1.1" deps {}) }: buildRustCrate {
    crateName = "precomputed-hash";
    version = "0.1.1";
    description = "A library intending to be a base dependency to expose a precomputed hash";
    authors = [ "Emilio Cobos Álvarez <emilio@crisal.io>" ];
    sha256 = "1x37xiarlc39772glsrbb9ic5cpaky4q0fi0ax42bwwrn4jfqgyj";
  };
  features_.precomputed_hash."0.1.1" = deps: f: updateFeatures f (rec {
    precomputed_hash."0.1.1".default = (f.precomputed_hash."0.1.1".default or true);
  }) [];


# end
# proc-macro2-0.4.30

  crates.proc_macro2."0.4.30" = deps: { features?(features_.proc_macro2."0.4.30" deps {}) }: buildRustCrate {
    crateName = "proc-macro2";
    version = "0.4.30";
    description = "A stable implementation of the upcoming new `proc_macro` API. Comes with an\noption, off by default, to also reimplement itself in terms of the upstream\nunstable API.\n";
    authors = [ "Alex Crichton <alex@alexcrichton.com>" ];
    sha256 = "0iifv51wrm6r4r2gghw6rray3nv53zcap355bbz1nsmbhj5s09b9";
    build = "build.rs";
    dependencies = mapFeatures features ([
      (crates."unicode_xid"."${deps."proc_macro2"."0.4.30"."unicode_xid"}" deps)
    ]);
    features = mkFeatures (features."proc_macro2"."0.4.30" or {});
  };
  features_.proc_macro2."0.4.30" = deps: f: updateFeatures f (rec {
    proc_macro2 = fold recursiveUpdate {} [
      { "0.4.30"."proc-macro" =
        (f.proc_macro2."0.4.30"."proc-macro" or false) ||
        (f.proc_macro2."0.4.30".default or false) ||
        (proc_macro2."0.4.30"."default" or false); }
      { "0.4.30".default = (f.proc_macro2."0.4.30".default or true); }
    ];
    unicode_xid."${deps.proc_macro2."0.4.30".unicode_xid}".default = true;
  }) [
    (features_.unicode_xid."${deps."proc_macro2"."0.4.30"."unicode_xid"}" deps)
  ];


# end
# proc-macro2-1.0.4

  crates.proc_macro2."1.0.4" = deps: { features?(features_.proc_macro2."1.0.4" deps {}) }: buildRustCrate {
    crateName = "proc-macro2";
    version = "1.0.4";
    description = "A stable implementation of the upcoming new `proc_macro` API. Comes with an\noption, off by default, to also reimplement itself in terms of the upstream\nunstable API.\n";
    authors = [ "Alex Crichton <alex@alexcrichton.com>" ];
    edition = "2018";
    sha256 = "19g5nq8xnwqhp53rb7v7jq1xczx91v259pm9h0r3wypz0acflif9";
    libName = "proc_macro2";
    dependencies = mapFeatures features ([
      (crates."unicode_xid"."${deps."proc_macro2"."1.0.4"."unicode_xid"}" deps)
    ]);
    features = mkFeatures (features."proc_macro2"."1.0.4" or {});
  };
  features_.proc_macro2."1.0.4" = deps: f: updateFeatures f (rec {
    proc_macro2 = fold recursiveUpdate {} [
      { "1.0.4"."proc-macro" =
        (f.proc_macro2."1.0.4"."proc-macro" or false) ||
        (f.proc_macro2."1.0.4".default or false) ||
        (proc_macro2."1.0.4"."default" or false); }
      { "1.0.4".default = (f.proc_macro2."1.0.4".default or true); }
    ];
    unicode_xid."${deps.proc_macro2."1.0.4".unicode_xid}".default = true;
  }) [
    (features_.unicode_xid."${deps."proc_macro2"."1.0.4"."unicode_xid"}" deps)
  ];


# end
# procedural-masquerade-0.1.6

  crates.procedural_masquerade."0.1.6" = deps: { features?(features_.procedural_masquerade."0.1.6" deps {}) }: buildRustCrate {
    crateName = "procedural-masquerade";
    version = "0.1.6";
    description = "macro_rules for making proc_macro_derive pretending to be proc_macro";
    authors = [ "Simon Sapin <simon.sapin@exyr.org>" ];
    sha256 = "1nk661dxs6ixlrw1ilsr22v0zb91fg9kyxs2ikkl12y4qi2f72g2";
    libPath = "lib.rs";
  };
  features_.procedural_masquerade."0.1.6" = deps: f: updateFeatures f (rec {
    procedural_masquerade."0.1.6".default = (f.procedural_masquerade."0.1.6".default or true);
  }) [];


# end
# publicsuffix-1.5.3

  crates.publicsuffix."1.5.3" = deps: { features?(features_.publicsuffix."1.5.3" deps {}) }: buildRustCrate {
    crateName = "publicsuffix";
    version = "1.5.3";
    description = "Robust domain name parsing and RFC compliant email address validation";
    authors = [ "rushmorem <rushmore@webenchanter.com>" ];
    sha256 = "1cynqhsq870q3xqn1630d6m7p4x0a6w1vngsxlcjl89c37wmcbrc";
    dependencies = mapFeatures features ([
      (crates."error_chain"."${deps."publicsuffix"."1.5.3"."error_chain"}" deps)
      (crates."idna"."${deps."publicsuffix"."1.5.3"."idna"}" deps)
      (crates."lazy_static"."${deps."publicsuffix"."1.5.3"."lazy_static"}" deps)
      (crates."regex"."${deps."publicsuffix"."1.5.3"."regex"}" deps)
      (crates."url"."${deps."publicsuffix"."1.5.3"."url"}" deps)
    ]);
    features = mkFeatures (features."publicsuffix"."1.5.3" or {});
  };
  features_.publicsuffix."1.5.3" = deps: f: updateFeatures f (rec {
    error_chain."${deps.publicsuffix."1.5.3".error_chain}".default = true;
    idna."${deps.publicsuffix."1.5.3".idna}".default = true;
    lazy_static."${deps.publicsuffix."1.5.3".lazy_static}".default = true;
    publicsuffix = fold recursiveUpdate {} [
      { "1.5.3"."native-tls" =
        (f.publicsuffix."1.5.3"."native-tls" or false) ||
        (f.publicsuffix."1.5.3".remote_list or false) ||
        (publicsuffix."1.5.3"."remote_list" or false); }
      { "1.5.3"."remote_list" =
        (f.publicsuffix."1.5.3"."remote_list" or false) ||
        (f.publicsuffix."1.5.3".default or false) ||
        (publicsuffix."1.5.3"."default" or false); }
      { "1.5.3".default = (f.publicsuffix."1.5.3".default or true); }
    ];
    regex."${deps.publicsuffix."1.5.3".regex}".default = true;
    url."${deps.publicsuffix."1.5.3".url}".default = true;
  }) [
    (features_.error_chain."${deps."publicsuffix"."1.5.3"."error_chain"}" deps)
    (features_.idna."${deps."publicsuffix"."1.5.3"."idna"}" deps)
    (features_.lazy_static."${deps."publicsuffix"."1.5.3"."lazy_static"}" deps)
    (features_.regex."${deps."publicsuffix"."1.5.3"."regex"}" deps)
    (features_.url."${deps."publicsuffix"."1.5.3"."url"}" deps)
  ];


# end
# quote-0.6.13

  crates.quote."0.6.13" = deps: { features?(features_.quote."0.6.13" deps {}) }: buildRustCrate {
    crateName = "quote";
    version = "0.6.13";
    description = "Quasi-quoting macro quote!(...)";
    authors = [ "David Tolnay <dtolnay@gmail.com>" ];
    sha256 = "1hrvsin40i4q8swrhlj9057g7nsp0lg02h8zbzmgz14av9mzv8g8";
    dependencies = mapFeatures features ([
      (crates."proc_macro2"."${deps."quote"."0.6.13"."proc_macro2"}" deps)
    ]);
    features = mkFeatures (features."quote"."0.6.13" or {});
  };
  features_.quote."0.6.13" = deps: f: updateFeatures f (rec {
    proc_macro2 = fold recursiveUpdate {} [
      { "${deps.quote."0.6.13".proc_macro2}"."proc-macro" =
        (f.proc_macro2."${deps.quote."0.6.13".proc_macro2}"."proc-macro" or false) ||
        (quote."0.6.13"."proc-macro" or false) ||
        (f."quote"."0.6.13"."proc-macro" or false); }
      { "${deps.quote."0.6.13".proc_macro2}".default = (f.proc_macro2."${deps.quote."0.6.13".proc_macro2}".default or false); }
    ];
    quote = fold recursiveUpdate {} [
      { "0.6.13"."proc-macro" =
        (f.quote."0.6.13"."proc-macro" or false) ||
        (f.quote."0.6.13".default or false) ||
        (quote."0.6.13"."default" or false); }
      { "0.6.13".default = (f.quote."0.6.13".default or true); }
    ];
  }) [
    (features_.proc_macro2."${deps."quote"."0.6.13"."proc_macro2"}" deps)
  ];


# end
# quote-1.0.2

  crates.quote."1.0.2" = deps: { features?(features_.quote."1.0.2" deps {}) }: buildRustCrate {
    crateName = "quote";
    version = "1.0.2";
    description = "Quasi-quoting macro quote!(...)";
    authors = [ "David Tolnay <dtolnay@gmail.com>" ];
    edition = "2018";
    sha256 = "0r7030w7dymarn92gjgm02hsm04fwsfs6f1l20wdqiyrm9z8rs5q";
    dependencies = mapFeatures features ([
      (crates."proc_macro2"."${deps."quote"."1.0.2"."proc_macro2"}" deps)
    ]);
    features = mkFeatures (features."quote"."1.0.2" or {});
  };
  features_.quote."1.0.2" = deps: f: updateFeatures f (rec {
    proc_macro2 = fold recursiveUpdate {} [
      { "${deps.quote."1.0.2".proc_macro2}"."proc-macro" =
        (f.proc_macro2."${deps.quote."1.0.2".proc_macro2}"."proc-macro" or false) ||
        (quote."1.0.2"."proc-macro" or false) ||
        (f."quote"."1.0.2"."proc-macro" or false); }
      { "${deps.quote."1.0.2".proc_macro2}".default = (f.proc_macro2."${deps.quote."1.0.2".proc_macro2}".default or false); }
    ];
    quote = fold recursiveUpdate {} [
      { "1.0.2"."proc-macro" =
        (f.quote."1.0.2"."proc-macro" or false) ||
        (f.quote."1.0.2".default or false) ||
        (quote."1.0.2"."default" or false); }
      { "1.0.2".default = (f.quote."1.0.2".default or true); }
    ];
  }) [
    (features_.proc_macro2."${deps."quote"."1.0.2"."proc_macro2"}" deps)
  ];


# end
# rand-0.6.5

  crates.rand."0.6.5" = deps: { features?(features_.rand."0.6.5" deps {}) }: buildRustCrate {
    crateName = "rand";
    version = "0.6.5";
    description = "Random number generators and other randomness functionality.\n";
    authors = [ "The Rand Project Developers" "The Rust Project Developers" ];
    sha256 = "0zbck48159aj8zrwzf80sd9xxh96w4f4968nshwjpysjvflimvgb";
    build = "build.rs";
    dependencies = mapFeatures features ([
      (crates."rand_chacha"."${deps."rand"."0.6.5"."rand_chacha"}" deps)
      (crates."rand_core"."${deps."rand"."0.6.5"."rand_core"}" deps)
      (crates."rand_hc"."${deps."rand"."0.6.5"."rand_hc"}" deps)
      (crates."rand_isaac"."${deps."rand"."0.6.5"."rand_isaac"}" deps)
      (crates."rand_jitter"."${deps."rand"."0.6.5"."rand_jitter"}" deps)
      (crates."rand_pcg"."${deps."rand"."0.6.5"."rand_pcg"}" deps)
      (crates."rand_xorshift"."${deps."rand"."0.6.5"."rand_xorshift"}" deps)
    ]
      ++ (if features.rand."0.6.5".rand_os or false then [ (crates.rand_os."${deps."rand"."0.6.5".rand_os}" deps) ] else []))
      ++ (if (kernel == "linux" || kernel == "darwin") then mapFeatures features ([
      (crates."libc"."${deps."rand"."0.6.5"."libc"}" deps)
    ]) else [])
      ++ (if kernel == "windows" then mapFeatures features ([
      (crates."winapi"."${deps."rand"."0.6.5"."winapi"}" deps)
    ]) else []);

    buildDependencies = mapFeatures features ([
      (crates."autocfg"."${deps."rand"."0.6.5"."autocfg"}" deps)
    ]);
    features = mkFeatures (features."rand"."0.6.5" or {});
  };
  features_.rand."0.6.5" = deps: f: updateFeatures f (rec {
    autocfg."${deps.rand."0.6.5".autocfg}".default = true;
    libc."${deps.rand."0.6.5".libc}".default = (f.libc."${deps.rand."0.6.5".libc}".default or false);
    rand = fold recursiveUpdate {} [
      { "0.6.5"."alloc" =
        (f.rand."0.6.5"."alloc" or false) ||
        (f.rand."0.6.5".std or false) ||
        (rand."0.6.5"."std" or false); }
      { "0.6.5"."packed_simd" =
        (f.rand."0.6.5"."packed_simd" or false) ||
        (f.rand."0.6.5".simd_support or false) ||
        (rand."0.6.5"."simd_support" or false); }
      { "0.6.5"."rand_os" =
        (f.rand."0.6.5"."rand_os" or false) ||
        (f.rand."0.6.5".std or false) ||
        (rand."0.6.5"."std" or false); }
      { "0.6.5"."simd_support" =
        (f.rand."0.6.5"."simd_support" or false) ||
        (f.rand."0.6.5".nightly or false) ||
        (rand."0.6.5"."nightly" or false); }
      { "0.6.5"."std" =
        (f.rand."0.6.5"."std" or false) ||
        (f.rand."0.6.5".default or false) ||
        (rand."0.6.5"."default" or false); }
      { "0.6.5".default = (f.rand."0.6.5".default or true); }
    ];
    rand_chacha."${deps.rand."0.6.5".rand_chacha}".default = true;
    rand_core = fold recursiveUpdate {} [
      { "${deps.rand."0.6.5".rand_core}"."alloc" =
        (f.rand_core."${deps.rand."0.6.5".rand_core}"."alloc" or false) ||
        (rand."0.6.5"."alloc" or false) ||
        (f."rand"."0.6.5"."alloc" or false); }
      { "${deps.rand."0.6.5".rand_core}"."serde1" =
        (f.rand_core."${deps.rand."0.6.5".rand_core}"."serde1" or false) ||
        (rand."0.6.5"."serde1" or false) ||
        (f."rand"."0.6.5"."serde1" or false); }
      { "${deps.rand."0.6.5".rand_core}"."std" =
        (f.rand_core."${deps.rand."0.6.5".rand_core}"."std" or false) ||
        (rand."0.6.5"."std" or false) ||
        (f."rand"."0.6.5"."std" or false); }
      { "${deps.rand."0.6.5".rand_core}".default = true; }
    ];
    rand_hc."${deps.rand."0.6.5".rand_hc}".default = true;
    rand_isaac = fold recursiveUpdate {} [
      { "${deps.rand."0.6.5".rand_isaac}"."serde1" =
        (f.rand_isaac."${deps.rand."0.6.5".rand_isaac}"."serde1" or false) ||
        (rand."0.6.5"."serde1" or false) ||
        (f."rand"."0.6.5"."serde1" or false); }
      { "${deps.rand."0.6.5".rand_isaac}".default = true; }
    ];
    rand_jitter = fold recursiveUpdate {} [
      { "${deps.rand."0.6.5".rand_jitter}"."std" =
        (f.rand_jitter."${deps.rand."0.6.5".rand_jitter}"."std" or false) ||
        (rand."0.6.5"."std" or false) ||
        (f."rand"."0.6.5"."std" or false); }
      { "${deps.rand."0.6.5".rand_jitter}".default = true; }
    ];
    rand_os = fold recursiveUpdate {} [
      { "${deps.rand."0.6.5".rand_os}"."stdweb" =
        (f.rand_os."${deps.rand."0.6.5".rand_os}"."stdweb" or false) ||
        (rand."0.6.5"."stdweb" or false) ||
        (f."rand"."0.6.5"."stdweb" or false); }
      { "${deps.rand."0.6.5".rand_os}"."wasm-bindgen" =
        (f.rand_os."${deps.rand."0.6.5".rand_os}"."wasm-bindgen" or false) ||
        (rand."0.6.5"."wasm-bindgen" or false) ||
        (f."rand"."0.6.5"."wasm-bindgen" or false); }
      { "${deps.rand."0.6.5".rand_os}".default = true; }
    ];
    rand_pcg."${deps.rand."0.6.5".rand_pcg}".default = true;
    rand_xorshift = fold recursiveUpdate {} [
      { "${deps.rand."0.6.5".rand_xorshift}"."serde1" =
        (f.rand_xorshift."${deps.rand."0.6.5".rand_xorshift}"."serde1" or false) ||
        (rand."0.6.5"."serde1" or false) ||
        (f."rand"."0.6.5"."serde1" or false); }
      { "${deps.rand."0.6.5".rand_xorshift}".default = true; }
    ];
    winapi = fold recursiveUpdate {} [
      { "${deps.rand."0.6.5".winapi}"."minwindef" = true; }
      { "${deps.rand."0.6.5".winapi}"."ntsecapi" = true; }
      { "${deps.rand."0.6.5".winapi}"."profileapi" = true; }
      { "${deps.rand."0.6.5".winapi}"."winnt" = true; }
      { "${deps.rand."0.6.5".winapi}".default = true; }
    ];
  }) [
    (features_.rand_chacha."${deps."rand"."0.6.5"."rand_chacha"}" deps)
    (features_.rand_core."${deps."rand"."0.6.5"."rand_core"}" deps)
    (features_.rand_hc."${deps."rand"."0.6.5"."rand_hc"}" deps)
    (features_.rand_isaac."${deps."rand"."0.6.5"."rand_isaac"}" deps)
    (features_.rand_jitter."${deps."rand"."0.6.5"."rand_jitter"}" deps)
    (features_.rand_os."${deps."rand"."0.6.5"."rand_os"}" deps)
    (features_.rand_pcg."${deps."rand"."0.6.5"."rand_pcg"}" deps)
    (features_.rand_xorshift."${deps."rand"."0.6.5"."rand_xorshift"}" deps)
    (features_.autocfg."${deps."rand"."0.6.5"."autocfg"}" deps)
    (features_.libc."${deps."rand"."0.6.5"."libc"}" deps)
    (features_.winapi."${deps."rand"."0.6.5"."winapi"}" deps)
  ];


# end
# rand-0.7.2

  crates.rand."0.7.2" = deps: { features?(features_.rand."0.7.2" deps {}) }: buildRustCrate {
    crateName = "rand";
    version = "0.7.2";
    description = "Random number generators and other randomness functionality.\n";
    authors = [ "The Rand Project Developers" "The Rust Project Developers" ];
    edition = "2018";
    sha256 = "1f53047g63b9kyyx1k8wgwzspk4n96w2n2h1a9848ggl9y9h0ik6";
    dependencies = mapFeatures features ([
      (crates."rand_core"."${deps."rand"."0.7.2"."rand_core"}" deps)
    ])
      ++ (if !(kernel == "emscripten") then mapFeatures features ([
      (crates."rand_chacha"."${deps."rand"."0.7.2"."rand_chacha"}" deps)
    ]) else [])
      ++ (if kernel == "emscripten" then mapFeatures features ([
      (crates."rand_hc"."${deps."rand"."0.7.2"."rand_hc"}" deps)
    ]) else [])
      ++ (if (kernel == "linux" || kernel == "darwin") then mapFeatures features ([
      (crates."libc"."${deps."rand"."0.7.2"."libc"}" deps)
    ]) else []);
    features = mkFeatures (features."rand"."0.7.2" or {});
  };
  features_.rand."0.7.2" = deps: f: updateFeatures f (rec {
    libc."${deps.rand."0.7.2".libc}".default = (f.libc."${deps.rand."0.7.2".libc}".default or false);
    rand = fold recursiveUpdate {} [
      { "0.7.2"."alloc" =
        (f.rand."0.7.2"."alloc" or false) ||
        (f.rand."0.7.2".std or false) ||
        (rand."0.7.2"."std" or false); }
      { "0.7.2"."getrandom" =
        (f.rand."0.7.2"."getrandom" or false) ||
        (f.rand."0.7.2".std or false) ||
        (rand."0.7.2"."std" or false); }
      { "0.7.2"."getrandom_package" =
        (f.rand."0.7.2"."getrandom_package" or false) ||
        (f.rand."0.7.2".getrandom or false) ||
        (rand."0.7.2"."getrandom" or false); }
      { "0.7.2"."packed_simd" =
        (f.rand."0.7.2"."packed_simd" or false) ||
        (f.rand."0.7.2".simd_support or false) ||
        (rand."0.7.2"."simd_support" or false); }
      { "0.7.2"."rand_pcg" =
        (f.rand."0.7.2"."rand_pcg" or false) ||
        (f.rand."0.7.2".small_rng or false) ||
        (rand."0.7.2"."small_rng" or false); }
      { "0.7.2"."simd_support" =
        (f.rand."0.7.2"."simd_support" or false) ||
        (f.rand."0.7.2".nightly or false) ||
        (rand."0.7.2"."nightly" or false); }
      { "0.7.2"."std" =
        (f.rand."0.7.2"."std" or false) ||
        (f.rand."0.7.2".default or false) ||
        (rand."0.7.2"."default" or false); }
      { "0.7.2".default = (f.rand."0.7.2".default or true); }
    ];
    rand_chacha."${deps.rand."0.7.2".rand_chacha}".default = (f.rand_chacha."${deps.rand."0.7.2".rand_chacha}".default or false);
    rand_core = fold recursiveUpdate {} [
      { "${deps.rand."0.7.2".rand_core}"."alloc" =
        (f.rand_core."${deps.rand."0.7.2".rand_core}"."alloc" or false) ||
        (rand."0.7.2"."alloc" or false) ||
        (f."rand"."0.7.2"."alloc" or false); }
      { "${deps.rand."0.7.2".rand_core}"."getrandom" =
        (f.rand_core."${deps.rand."0.7.2".rand_core}"."getrandom" or false) ||
        (rand."0.7.2"."getrandom" or false) ||
        (f."rand"."0.7.2"."getrandom" or false); }
      { "${deps.rand."0.7.2".rand_core}"."std" =
        (f.rand_core."${deps.rand."0.7.2".rand_core}"."std" or false) ||
        (rand."0.7.2"."std" or false) ||
        (f."rand"."0.7.2"."std" or false); }
      { "${deps.rand."0.7.2".rand_core}".default = true; }
    ];
    rand_hc."${deps.rand."0.7.2".rand_hc}".default = true;
  }) [
    (features_.rand_core."${deps."rand"."0.7.2"."rand_core"}" deps)
    (features_.rand_chacha."${deps."rand"."0.7.2"."rand_chacha"}" deps)
    (features_.rand_hc."${deps."rand"."0.7.2"."rand_hc"}" deps)
    (features_.libc."${deps."rand"."0.7.2"."libc"}" deps)
  ];


# end
# rand_chacha-0.1.1

  crates.rand_chacha."0.1.1" = deps: { features?(features_.rand_chacha."0.1.1" deps {}) }: buildRustCrate {
    crateName = "rand_chacha";
    version = "0.1.1";
    description = "ChaCha random number generator\n";
    authors = [ "The Rand Project Developers" "The Rust Project Developers" ];
    sha256 = "0xnxm4mjd7wjnh18zxc1yickw58axbycp35ciraplqdfwn1gffwi";
    build = "build.rs";
    dependencies = mapFeatures features ([
      (crates."rand_core"."${deps."rand_chacha"."0.1.1"."rand_core"}" deps)
    ]);

    buildDependencies = mapFeatures features ([
      (crates."autocfg"."${deps."rand_chacha"."0.1.1"."autocfg"}" deps)
    ]);
  };
  features_.rand_chacha."0.1.1" = deps: f: updateFeatures f (rec {
    autocfg."${deps.rand_chacha."0.1.1".autocfg}".default = true;
    rand_chacha."0.1.1".default = (f.rand_chacha."0.1.1".default or true);
    rand_core."${deps.rand_chacha."0.1.1".rand_core}".default = (f.rand_core."${deps.rand_chacha."0.1.1".rand_core}".default or false);
  }) [
    (features_.rand_core."${deps."rand_chacha"."0.1.1"."rand_core"}" deps)
    (features_.autocfg."${deps."rand_chacha"."0.1.1"."autocfg"}" deps)
  ];


# end
# rand_chacha-0.2.1

  crates.rand_chacha."0.2.1" = deps: { features?(features_.rand_chacha."0.2.1" deps {}) }: buildRustCrate {
    crateName = "rand_chacha";
    version = "0.2.1";
    description = "ChaCha random number generator\n";
    authors = [ "The Rand Project Developers" "The Rust Project Developers" "The CryptoCorrosion Contributors" ];
    edition = "2018";
    sha256 = "0zpp3wmxhhmripb6bywhzhx5rfwl4dfbny85hpalwdj0sncv0p0k";
    dependencies = mapFeatures features ([
      (crates."c2_chacha"."${deps."rand_chacha"."0.2.1"."c2_chacha"}" deps)
      (crates."rand_core"."${deps."rand_chacha"."0.2.1"."rand_core"}" deps)
    ]);
    features = mkFeatures (features."rand_chacha"."0.2.1" or {});
  };
  features_.rand_chacha."0.2.1" = deps: f: updateFeatures f (rec {
    c2_chacha = fold recursiveUpdate {} [
      { "${deps.rand_chacha."0.2.1".c2_chacha}"."simd" = true; }
      { "${deps.rand_chacha."0.2.1".c2_chacha}"."std" =
        (f.c2_chacha."${deps.rand_chacha."0.2.1".c2_chacha}"."std" or false) ||
        (rand_chacha."0.2.1"."std" or false) ||
        (f."rand_chacha"."0.2.1"."std" or false); }
      { "${deps.rand_chacha."0.2.1".c2_chacha}".default = (f.c2_chacha."${deps.rand_chacha."0.2.1".c2_chacha}".default or false); }
    ];
    rand_chacha = fold recursiveUpdate {} [
      { "0.2.1"."simd" =
        (f.rand_chacha."0.2.1"."simd" or false) ||
        (f.rand_chacha."0.2.1".default or false) ||
        (rand_chacha."0.2.1"."default" or false); }
      { "0.2.1"."std" =
        (f.rand_chacha."0.2.1"."std" or false) ||
        (f.rand_chacha."0.2.1".default or false) ||
        (rand_chacha."0.2.1"."default" or false); }
      { "0.2.1".default = (f.rand_chacha."0.2.1".default or true); }
    ];
    rand_core."${deps.rand_chacha."0.2.1".rand_core}".default = true;
  }) [
    (features_.c2_chacha."${deps."rand_chacha"."0.2.1"."c2_chacha"}" deps)
    (features_.rand_core."${deps."rand_chacha"."0.2.1"."rand_core"}" deps)
  ];


# end
# rand_core-0.3.1

  crates.rand_core."0.3.1" = deps: { features?(features_.rand_core."0.3.1" deps {}) }: buildRustCrate {
    crateName = "rand_core";
    version = "0.3.1";
    description = "Core random number generator traits and tools for implementation.\n";
    authors = [ "The Rand Project Developers" "The Rust Project Developers" ];
    sha256 = "0q0ssgpj9x5a6fda83nhmfydy7a6c0wvxm0jhncsmjx8qp8gw91m";
    dependencies = mapFeatures features ([
      (crates."rand_core"."${deps."rand_core"."0.3.1"."rand_core"}" deps)
    ]);
    features = mkFeatures (features."rand_core"."0.3.1" or {});
  };
  features_.rand_core."0.3.1" = deps: f: updateFeatures f (rec {
    rand_core = fold recursiveUpdate {} [
      { "${deps.rand_core."0.3.1".rand_core}"."alloc" =
        (f.rand_core."${deps.rand_core."0.3.1".rand_core}"."alloc" or false) ||
        (rand_core."0.3.1"."alloc" or false) ||
        (f."rand_core"."0.3.1"."alloc" or false); }
      { "${deps.rand_core."0.3.1".rand_core}"."serde1" =
        (f.rand_core."${deps.rand_core."0.3.1".rand_core}"."serde1" or false) ||
        (rand_core."0.3.1"."serde1" or false) ||
        (f."rand_core"."0.3.1"."serde1" or false); }
      { "${deps.rand_core."0.3.1".rand_core}"."std" =
        (f.rand_core."${deps.rand_core."0.3.1".rand_core}"."std" or false) ||
        (rand_core."0.3.1"."std" or false) ||
        (f."rand_core"."0.3.1"."std" or false); }
      { "${deps.rand_core."0.3.1".rand_core}".default = true; }
      { "0.3.1"."std" =
        (f.rand_core."0.3.1"."std" or false) ||
        (f.rand_core."0.3.1".default or false) ||
        (rand_core."0.3.1"."default" or false); }
      { "0.3.1".default = (f.rand_core."0.3.1".default or true); }
    ];
  }) [
    (features_.rand_core."${deps."rand_core"."0.3.1"."rand_core"}" deps)
  ];


# end
# rand_core-0.4.2

  crates.rand_core."0.4.2" = deps: { features?(features_.rand_core."0.4.2" deps {}) }: buildRustCrate {
    crateName = "rand_core";
    version = "0.4.2";
    description = "Core random number generator traits and tools for implementation.\n";
    authors = [ "The Rand Project Developers" "The Rust Project Developers" ];
    sha256 = "18zpzwn4bl7lp9f36iacy8mvdnfrhfmzsl35gmln98dcindff2ly";
    dependencies = mapFeatures features ([
]);
    features = mkFeatures (features."rand_core"."0.4.2" or {});
  };
  features_.rand_core."0.4.2" = deps: f: updateFeatures f (rec {
    rand_core = fold recursiveUpdate {} [
      { "0.4.2"."alloc" =
        (f.rand_core."0.4.2"."alloc" or false) ||
        (f.rand_core."0.4.2".std or false) ||
        (rand_core."0.4.2"."std" or false); }
      { "0.4.2"."serde" =
        (f.rand_core."0.4.2"."serde" or false) ||
        (f.rand_core."0.4.2".serde1 or false) ||
        (rand_core."0.4.2"."serde1" or false); }
      { "0.4.2"."serde_derive" =
        (f.rand_core."0.4.2"."serde_derive" or false) ||
        (f.rand_core."0.4.2".serde1 or false) ||
        (rand_core."0.4.2"."serde1" or false); }
      { "0.4.2".default = (f.rand_core."0.4.2".default or true); }
    ];
  }) [];


# end
# rand_core-0.5.1

  crates.rand_core."0.5.1" = deps: { features?(features_.rand_core."0.5.1" deps {}) }: buildRustCrate {
    crateName = "rand_core";
    version = "0.5.1";
    description = "Core random number generator traits and tools for implementation.\n";
    authors = [ "The Rand Project Developers" "The Rust Project Developers" ];
    edition = "2018";
    sha256 = "19qfnh77bzz0x2gfsk91h0gygy0z1s5l3yyc2j91gmprq60d6s3r";
    dependencies = mapFeatures features ([
    ]
      ++ (if features.rand_core."0.5.1".getrandom or false then [ (crates.getrandom."${deps."rand_core"."0.5.1".getrandom}" deps) ] else []));
    features = mkFeatures (features."rand_core"."0.5.1" or {});
  };
  features_.rand_core."0.5.1" = deps: f: updateFeatures f (rec {
    getrandom = fold recursiveUpdate {} [
      { "${deps.rand_core."0.5.1".getrandom}"."std" =
        (f.getrandom."${deps.rand_core."0.5.1".getrandom}"."std" or false) ||
        (rand_core."0.5.1"."std" or false) ||
        (f."rand_core"."0.5.1"."std" or false); }
      { "${deps.rand_core."0.5.1".getrandom}".default = true; }
    ];
    rand_core = fold recursiveUpdate {} [
      { "0.5.1"."alloc" =
        (f.rand_core."0.5.1"."alloc" or false) ||
        (f.rand_core."0.5.1".std or false) ||
        (rand_core."0.5.1"."std" or false); }
      { "0.5.1"."getrandom" =
        (f.rand_core."0.5.1"."getrandom" or false) ||
        (f.rand_core."0.5.1".std or false) ||
        (rand_core."0.5.1"."std" or false); }
      { "0.5.1"."serde" =
        (f.rand_core."0.5.1"."serde" or false) ||
        (f.rand_core."0.5.1".serde1 or false) ||
        (rand_core."0.5.1"."serde1" or false); }
      { "0.5.1".default = (f.rand_core."0.5.1".default or true); }
    ];
  }) [
    (features_.getrandom."${deps."rand_core"."0.5.1"."getrandom"}" deps)
  ];


# end
# rand_hc-0.1.0

  crates.rand_hc."0.1.0" = deps: { features?(features_.rand_hc."0.1.0" deps {}) }: buildRustCrate {
    crateName = "rand_hc";
    version = "0.1.0";
    description = "HC128 random number generator\n";
    authors = [ "The Rand Project Developers" ];
    sha256 = "05agb75j87yp7y1zk8yf7bpm66hc0673r3dlypn0kazynr6fdgkz";
    dependencies = mapFeatures features ([
      (crates."rand_core"."${deps."rand_hc"."0.1.0"."rand_core"}" deps)
    ]);
  };
  features_.rand_hc."0.1.0" = deps: f: updateFeatures f (rec {
    rand_core."${deps.rand_hc."0.1.0".rand_core}".default = (f.rand_core."${deps.rand_hc."0.1.0".rand_core}".default or false);
    rand_hc."0.1.0".default = (f.rand_hc."0.1.0".default or true);
  }) [
    (features_.rand_core."${deps."rand_hc"."0.1.0"."rand_core"}" deps)
  ];


# end
# rand_hc-0.2.0

  crates.rand_hc."0.2.0" = deps: { features?(features_.rand_hc."0.2.0" deps {}) }: buildRustCrate {
    crateName = "rand_hc";
    version = "0.2.0";
    description = "HC128 random number generator\n";
    authors = [ "The Rand Project Developers" ];
    edition = "2018";
    sha256 = "0592q9kqcna9aiyzy6vp3fadxkkbpfkmi2cnkv48zhybr0v2yf01";
    dependencies = mapFeatures features ([
      (crates."rand_core"."${deps."rand_hc"."0.2.0"."rand_core"}" deps)
    ]);
  };
  features_.rand_hc."0.2.0" = deps: f: updateFeatures f (rec {
    rand_core."${deps.rand_hc."0.2.0".rand_core}".default = true;
    rand_hc."0.2.0".default = (f.rand_hc."0.2.0".default or true);
  }) [
    (features_.rand_core."${deps."rand_hc"."0.2.0"."rand_core"}" deps)
  ];


# end
# rand_isaac-0.1.1

  crates.rand_isaac."0.1.1" = deps: { features?(features_.rand_isaac."0.1.1" deps {}) }: buildRustCrate {
    crateName = "rand_isaac";
    version = "0.1.1";
    description = "ISAAC random number generator\n";
    authors = [ "The Rand Project Developers" "The Rust Project Developers" ];
    sha256 = "10hhdh5b5sa03s6b63y9bafm956jwilx41s71jbrzl63ccx8lxdq";
    dependencies = mapFeatures features ([
      (crates."rand_core"."${deps."rand_isaac"."0.1.1"."rand_core"}" deps)
    ]);
    features = mkFeatures (features."rand_isaac"."0.1.1" or {});
  };
  features_.rand_isaac."0.1.1" = deps: f: updateFeatures f (rec {
    rand_core = fold recursiveUpdate {} [
      { "${deps.rand_isaac."0.1.1".rand_core}"."serde1" =
        (f.rand_core."${deps.rand_isaac."0.1.1".rand_core}"."serde1" or false) ||
        (rand_isaac."0.1.1"."serde1" or false) ||
        (f."rand_isaac"."0.1.1"."serde1" or false); }
      { "${deps.rand_isaac."0.1.1".rand_core}".default = (f.rand_core."${deps.rand_isaac."0.1.1".rand_core}".default or false); }
    ];
    rand_isaac = fold recursiveUpdate {} [
      { "0.1.1"."serde" =
        (f.rand_isaac."0.1.1"."serde" or false) ||
        (f.rand_isaac."0.1.1".serde1 or false) ||
        (rand_isaac."0.1.1"."serde1" or false); }
      { "0.1.1"."serde_derive" =
        (f.rand_isaac."0.1.1"."serde_derive" or false) ||
        (f.rand_isaac."0.1.1".serde1 or false) ||
        (rand_isaac."0.1.1"."serde1" or false); }
      { "0.1.1".default = (f.rand_isaac."0.1.1".default or true); }
    ];
  }) [
    (features_.rand_core."${deps."rand_isaac"."0.1.1"."rand_core"}" deps)
  ];


# end
# rand_jitter-0.1.4

  crates.rand_jitter."0.1.4" = deps: { features?(features_.rand_jitter."0.1.4" deps {}) }: buildRustCrate {
    crateName = "rand_jitter";
    version = "0.1.4";
    description = "Random number generator based on timing jitter";
    authors = [ "The Rand Project Developers" ];
    sha256 = "13nr4h042ab9l7qcv47bxrxw3gkf2pc3cni6c9pyi4nxla0mm7b6";
    dependencies = mapFeatures features ([
      (crates."rand_core"."${deps."rand_jitter"."0.1.4"."rand_core"}" deps)
    ])
      ++ (if kernel == "darwin" || kernel == "ios" then mapFeatures features ([
      (crates."libc"."${deps."rand_jitter"."0.1.4"."libc"}" deps)
    ]) else [])
      ++ (if kernel == "windows" then mapFeatures features ([
      (crates."winapi"."${deps."rand_jitter"."0.1.4"."winapi"}" deps)
    ]) else []);
    features = mkFeatures (features."rand_jitter"."0.1.4" or {});
  };
  features_.rand_jitter."0.1.4" = deps: f: updateFeatures f (rec {
    libc."${deps.rand_jitter."0.1.4".libc}".default = true;
    rand_core = fold recursiveUpdate {} [
      { "${deps.rand_jitter."0.1.4".rand_core}"."std" =
        (f.rand_core."${deps.rand_jitter."0.1.4".rand_core}"."std" or false) ||
        (rand_jitter."0.1.4"."std" or false) ||
        (f."rand_jitter"."0.1.4"."std" or false); }
      { "${deps.rand_jitter."0.1.4".rand_core}".default = true; }
    ];
    rand_jitter."0.1.4".default = (f.rand_jitter."0.1.4".default or true);
    winapi = fold recursiveUpdate {} [
      { "${deps.rand_jitter."0.1.4".winapi}"."profileapi" = true; }
      { "${deps.rand_jitter."0.1.4".winapi}".default = true; }
    ];
  }) [
    (features_.rand_core."${deps."rand_jitter"."0.1.4"."rand_core"}" deps)
    (features_.libc."${deps."rand_jitter"."0.1.4"."libc"}" deps)
    (features_.winapi."${deps."rand_jitter"."0.1.4"."winapi"}" deps)
  ];


# end
# rand_os-0.1.3

  crates.rand_os."0.1.3" = deps: { features?(features_.rand_os."0.1.3" deps {}) }: buildRustCrate {
    crateName = "rand_os";
    version = "0.1.3";
    description = "OS backed Random Number Generator";
    authors = [ "The Rand Project Developers" ];
    sha256 = "0ywwspizgs9g8vzn6m5ix9yg36n15119d6n792h7mk4r5vs0ww4j";
    dependencies = mapFeatures features ([
      (crates."rand_core"."${deps."rand_os"."0.1.3"."rand_core"}" deps)
    ])
      ++ (if abi == "sgx" then mapFeatures features ([
      (crates."rdrand"."${deps."rand_os"."0.1.3"."rdrand"}" deps)
    ]) else [])
      ++ (if kernel == "cloudabi" then mapFeatures features ([
      (crates."cloudabi"."${deps."rand_os"."0.1.3"."cloudabi"}" deps)
    ]) else [])
      ++ (if kernel == "fuchsia" then mapFeatures features ([
      (crates."fuchsia_cprng"."${deps."rand_os"."0.1.3"."fuchsia_cprng"}" deps)
    ]) else [])
      ++ (if (kernel == "linux" || kernel == "darwin") then mapFeatures features ([
      (crates."libc"."${deps."rand_os"."0.1.3"."libc"}" deps)
    ]) else [])
      ++ (if kernel == "windows" then mapFeatures features ([
      (crates."winapi"."${deps."rand_os"."0.1.3"."winapi"}" deps)
    ]) else [])
      ++ (if kernel == "wasm32-unknown-unknown" then mapFeatures features ([
]) else []);
  };
  features_.rand_os."0.1.3" = deps: f: updateFeatures f (rec {
    cloudabi."${deps.rand_os."0.1.3".cloudabi}".default = true;
    fuchsia_cprng."${deps.rand_os."0.1.3".fuchsia_cprng}".default = true;
    libc."${deps.rand_os."0.1.3".libc}".default = true;
    rand_core = fold recursiveUpdate {} [
      { "${deps.rand_os."0.1.3".rand_core}"."std" = true; }
      { "${deps.rand_os."0.1.3".rand_core}".default = true; }
    ];
    rand_os."0.1.3".default = (f.rand_os."0.1.3".default or true);
    rdrand."${deps.rand_os."0.1.3".rdrand}".default = true;
    winapi = fold recursiveUpdate {} [
      { "${deps.rand_os."0.1.3".winapi}"."minwindef" = true; }
      { "${deps.rand_os."0.1.3".winapi}"."ntsecapi" = true; }
      { "${deps.rand_os."0.1.3".winapi}"."winnt" = true; }
      { "${deps.rand_os."0.1.3".winapi}".default = true; }
    ];
  }) [
    (features_.rand_core."${deps."rand_os"."0.1.3"."rand_core"}" deps)
    (features_.rdrand."${deps."rand_os"."0.1.3"."rdrand"}" deps)
    (features_.cloudabi."${deps."rand_os"."0.1.3"."cloudabi"}" deps)
    (features_.fuchsia_cprng."${deps."rand_os"."0.1.3"."fuchsia_cprng"}" deps)
    (features_.libc."${deps."rand_os"."0.1.3"."libc"}" deps)
    (features_.winapi."${deps."rand_os"."0.1.3"."winapi"}" deps)
  ];


# end
# rand_pcg-0.1.2

  crates.rand_pcg."0.1.2" = deps: { features?(features_.rand_pcg."0.1.2" deps {}) }: buildRustCrate {
    crateName = "rand_pcg";
    version = "0.1.2";
    description = "Selected PCG random number generators\n";
    authors = [ "The Rand Project Developers" ];
    sha256 = "04qgi2ai2z42li5h4aawvxbpnlqyjfnipz9d6k73mdnl6p1xq938";
    build = "build.rs";
    dependencies = mapFeatures features ([
      (crates."rand_core"."${deps."rand_pcg"."0.1.2"."rand_core"}" deps)
    ]);

    buildDependencies = mapFeatures features ([
      (crates."autocfg"."${deps."rand_pcg"."0.1.2"."autocfg"}" deps)
    ]);
    features = mkFeatures (features."rand_pcg"."0.1.2" or {});
  };
  features_.rand_pcg."0.1.2" = deps: f: updateFeatures f (rec {
    autocfg."${deps.rand_pcg."0.1.2".autocfg}".default = true;
    rand_core."${deps.rand_pcg."0.1.2".rand_core}".default = true;
    rand_pcg = fold recursiveUpdate {} [
      { "0.1.2"."serde" =
        (f.rand_pcg."0.1.2"."serde" or false) ||
        (f.rand_pcg."0.1.2".serde1 or false) ||
        (rand_pcg."0.1.2"."serde1" or false); }
      { "0.1.2"."serde_derive" =
        (f.rand_pcg."0.1.2"."serde_derive" or false) ||
        (f.rand_pcg."0.1.2".serde1 or false) ||
        (rand_pcg."0.1.2"."serde1" or false); }
      { "0.1.2".default = (f.rand_pcg."0.1.2".default or true); }
    ];
  }) [
    (features_.rand_core."${deps."rand_pcg"."0.1.2"."rand_core"}" deps)
    (features_.autocfg."${deps."rand_pcg"."0.1.2"."autocfg"}" deps)
  ];


# end
# rand_xorshift-0.1.1

  crates.rand_xorshift."0.1.1" = deps: { features?(features_.rand_xorshift."0.1.1" deps {}) }: buildRustCrate {
    crateName = "rand_xorshift";
    version = "0.1.1";
    description = "Xorshift random number generator\n";
    authors = [ "The Rand Project Developers" "The Rust Project Developers" ];
    sha256 = "0v365c4h4lzxwz5k5kp9m0661s0sss7ylv74if0xb4svis9sswnn";
    dependencies = mapFeatures features ([
      (crates."rand_core"."${deps."rand_xorshift"."0.1.1"."rand_core"}" deps)
    ]);
    features = mkFeatures (features."rand_xorshift"."0.1.1" or {});
  };
  features_.rand_xorshift."0.1.1" = deps: f: updateFeatures f (rec {
    rand_core."${deps.rand_xorshift."0.1.1".rand_core}".default = (f.rand_core."${deps.rand_xorshift."0.1.1".rand_core}".default or false);
    rand_xorshift = fold recursiveUpdate {} [
      { "0.1.1"."serde" =
        (f.rand_xorshift."0.1.1"."serde" or false) ||
        (f.rand_xorshift."0.1.1".serde1 or false) ||
        (rand_xorshift."0.1.1"."serde1" or false); }
      { "0.1.1"."serde_derive" =
        (f.rand_xorshift."0.1.1"."serde_derive" or false) ||
        (f.rand_xorshift."0.1.1".serde1 or false) ||
        (rand_xorshift."0.1.1"."serde1" or false); }
      { "0.1.1".default = (f.rand_xorshift."0.1.1".default or true); }
    ];
  }) [
    (features_.rand_core."${deps."rand_xorshift"."0.1.1"."rand_core"}" deps)
  ];


# end
# rayon-1.2.0

  crates.rayon."1.2.0" = deps: { features?(features_.rayon."1.2.0" deps {}) }: buildRustCrate {
    crateName = "rayon";
    version = "1.2.0";
    description = "Simple work-stealing parallelism for Rust";
    authors = [ "Niko Matsakis <niko@alum.mit.edu>" "Josh Stone <cuviper@gmail.com>" ];
    sha256 = "171ma39i8mzfpxndxpy8b6b7bdfxl9pmn3yh0jyvmh204nml2xfk";
    dependencies = mapFeatures features ([
      (crates."crossbeam_deque"."${deps."rayon"."1.2.0"."crossbeam_deque"}" deps)
      (crates."either"."${deps."rayon"."1.2.0"."either"}" deps)
      (crates."rayon_core"."${deps."rayon"."1.2.0"."rayon_core"}" deps)
    ]);
  };
  features_.rayon."1.2.0" = deps: f: updateFeatures f (rec {
    crossbeam_deque."${deps.rayon."1.2.0".crossbeam_deque}".default = true;
    either."${deps.rayon."1.2.0".either}".default = (f.either."${deps.rayon."1.2.0".either}".default or false);
    rayon."1.2.0".default = (f.rayon."1.2.0".default or true);
    rayon_core."${deps.rayon."1.2.0".rayon_core}".default = true;
  }) [
    (features_.crossbeam_deque."${deps."rayon"."1.2.0"."crossbeam_deque"}" deps)
    (features_.either."${deps."rayon"."1.2.0"."either"}" deps)
    (features_.rayon_core."${deps."rayon"."1.2.0"."rayon_core"}" deps)
  ];


# end
# rayon-core-1.6.0

  crates.rayon_core."1.6.0" = deps: { features?(features_.rayon_core."1.6.0" deps {}) }: buildRustCrate {
    crateName = "rayon-core";
    version = "1.6.0";
    description = "Core APIs for Rayon";
    authors = [ "Niko Matsakis <niko@alum.mit.edu>" "Josh Stone <cuviper@gmail.com>" ];
    sha256 = "1gisjwv2l7mcvj9h1iwzp7z1c7sjs3kqsi3zqg9mw50jkc6lbvxl";
    build = "build.rs";
    dependencies = mapFeatures features ([
      (crates."crossbeam_deque"."${deps."rayon_core"."1.6.0"."crossbeam_deque"}" deps)
      (crates."crossbeam_queue"."${deps."rayon_core"."1.6.0"."crossbeam_queue"}" deps)
      (crates."crossbeam_utils"."${deps."rayon_core"."1.6.0"."crossbeam_utils"}" deps)
      (crates."lazy_static"."${deps."rayon_core"."1.6.0"."lazy_static"}" deps)
      (crates."num_cpus"."${deps."rayon_core"."1.6.0"."num_cpus"}" deps)
    ])
      ++ (if (kernel == "linux" || kernel == "darwin") then mapFeatures features ([
]) else []);
  };
  features_.rayon_core."1.6.0" = deps: f: updateFeatures f (rec {
    crossbeam_deque."${deps.rayon_core."1.6.0".crossbeam_deque}".default = true;
    crossbeam_queue."${deps.rayon_core."1.6.0".crossbeam_queue}".default = true;
    crossbeam_utils."${deps.rayon_core."1.6.0".crossbeam_utils}".default = true;
    lazy_static."${deps.rayon_core."1.6.0".lazy_static}".default = true;
    num_cpus."${deps.rayon_core."1.6.0".num_cpus}".default = true;
    rayon_core."1.6.0".default = (f.rayon_core."1.6.0".default or true);
  }) [
    (features_.crossbeam_deque."${deps."rayon_core"."1.6.0"."crossbeam_deque"}" deps)
    (features_.crossbeam_queue."${deps."rayon_core"."1.6.0"."crossbeam_queue"}" deps)
    (features_.crossbeam_utils."${deps."rayon_core"."1.6.0"."crossbeam_utils"}" deps)
    (features_.lazy_static."${deps."rayon_core"."1.6.0"."lazy_static"}" deps)
    (features_.num_cpus."${deps."rayon_core"."1.6.0"."num_cpus"}" deps)
  ];


# end
# rdrand-0.4.0

  crates.rdrand."0.4.0" = deps: { features?(features_.rdrand."0.4.0" deps {}) }: buildRustCrate {
    crateName = "rdrand";
    version = "0.4.0";
    description = "An implementation of random number generator based on rdrand and rdseed instructions";
    authors = [ "Simonas Kazlauskas <rdrand@kazlauskas.me>" ];
    sha256 = "15hrcasn0v876wpkwab1dwbk9kvqwrb3iv4y4dibb6yxnfvzwajk";
    dependencies = mapFeatures features ([
      (crates."rand_core"."${deps."rdrand"."0.4.0"."rand_core"}" deps)
    ]);
    features = mkFeatures (features."rdrand"."0.4.0" or {});
  };
  features_.rdrand."0.4.0" = deps: f: updateFeatures f (rec {
    rand_core."${deps.rdrand."0.4.0".rand_core}".default = (f.rand_core."${deps.rdrand."0.4.0".rand_core}".default or false);
    rdrand = fold recursiveUpdate {} [
      { "0.4.0"."std" =
        (f.rdrand."0.4.0"."std" or false) ||
        (f.rdrand."0.4.0".default or false) ||
        (rdrand."0.4.0"."default" or false); }
      { "0.4.0".default = (f.rdrand."0.4.0".default or true); }
    ];
  }) [
    (features_.rand_core."${deps."rdrand"."0.4.0"."rand_core"}" deps)
  ];


# end
# redox_syscall-0.1.56

  crates.redox_syscall."0.1.56" = deps: { features?(features_.redox_syscall."0.1.56" deps {}) }: buildRustCrate {
    crateName = "redox_syscall";
    version = "0.1.56";
    description = "A Rust library to access raw Redox system calls";
    authors = [ "Jeremy Soller <jackpot51@gmail.com>" ];
    sha256 = "0jcp8nd947zcy938bz09pzlmi3vyxfdzg92pjxdvvk0699vwcc26";
    libName = "syscall";
  };
  features_.redox_syscall."0.1.56" = deps: f: updateFeatures f (rec {
    redox_syscall."0.1.56".default = (f.redox_syscall."0.1.56".default or true);
  }) [];


# end
# ref-cast-0.2.7

  crates.ref_cast."0.2.7" = deps: { features?(features_.ref_cast."0.2.7" deps {}) }: buildRustCrate {
    crateName = "ref-cast";
    version = "0.2.7";
    description = "Safely cast &T to &U where the struct U contains a single field of type T.";
    authors = [ "David Tolnay <dtolnay@gmail.com>" ];
    edition = "2018";
    sha256 = "1ss6495xi8hykg8qr6zxwsw74hx7s5p03df30cwz1x1nzhx8672f";
    dependencies = mapFeatures features ([
      (crates."ref_cast_impl"."${deps."ref_cast"."0.2.7"."ref_cast_impl"}" deps)
    ]);
  };
  features_.ref_cast."0.2.7" = deps: f: updateFeatures f (rec {
    ref_cast."0.2.7".default = (f.ref_cast."0.2.7".default or true);
    ref_cast_impl."${deps.ref_cast."0.2.7".ref_cast_impl}".default = true;
  }) [
    (features_.ref_cast_impl."${deps."ref_cast"."0.2.7"."ref_cast_impl"}" deps)
  ];


# end
# ref-cast-impl-0.2.7

  crates.ref_cast_impl."0.2.7" = deps: { features?(features_.ref_cast_impl."0.2.7" deps {}) }: buildRustCrate {
    crateName = "ref-cast-impl";
    version = "0.2.7";
    description = "Derive implementation for ref_cast::RefCast.";
    authors = [ "David Tolnay <dtolnay@gmail.com>" ];
    edition = "2018";
    sha256 = "0k0yqf8k1bq0zqkpxyddwag0lc0i566k9f7xz8iry2zx40slvrph";
    libName = "ref_cast_impl";
    procMacro = true;
    dependencies = mapFeatures features ([
      (crates."proc_macro2"."${deps."ref_cast_impl"."0.2.7"."proc_macro2"}" deps)
      (crates."quote"."${deps."ref_cast_impl"."0.2.7"."quote"}" deps)
      (crates."syn"."${deps."ref_cast_impl"."0.2.7"."syn"}" deps)
    ]);
  };
  features_.ref_cast_impl."0.2.7" = deps: f: updateFeatures f (rec {
    proc_macro2."${deps.ref_cast_impl."0.2.7".proc_macro2}".default = true;
    quote."${deps.ref_cast_impl."0.2.7".quote}".default = true;
    ref_cast_impl."0.2.7".default = (f.ref_cast_impl."0.2.7".default or true);
    syn."${deps.ref_cast_impl."0.2.7".syn}".default = true;
  }) [
    (features_.proc_macro2."${deps."ref_cast_impl"."0.2.7"."proc_macro2"}" deps)
    (features_.quote."${deps."ref_cast_impl"."0.2.7"."quote"}" deps)
    (features_.syn."${deps."ref_cast_impl"."0.2.7"."syn"}" deps)
  ];


# end
# regex-1.3.1

  crates.regex."1.3.1" = deps: { features?(features_.regex."1.3.1" deps {}) }: buildRustCrate {
    crateName = "regex";
    version = "1.3.1";
    description = "An implementation of regular expressions for Rust. This implementation uses\nfinite automata and guarantees linear time matching on all inputs.\n";
    authors = [ "The Rust Project Developers" ];
    sha256 = "0508b01q7iwky5gzp1cc3lpz6al1qam8skgcvkfgxr67nikiz7jn";
    dependencies = mapFeatures features ([
      (crates."regex_syntax"."${deps."regex"."1.3.1"."regex_syntax"}" deps)
    ]
      ++ (if features.regex."1.3.1".aho-corasick or false then [ (crates.aho_corasick."${deps."regex"."1.3.1".aho_corasick}" deps) ] else [])
      ++ (if features.regex."1.3.1".memchr or false then [ (crates.memchr."${deps."regex"."1.3.1".memchr}" deps) ] else [])
      ++ (if features.regex."1.3.1".thread_local or false then [ (crates.thread_local."${deps."regex"."1.3.1".thread_local}" deps) ] else []));
    features = mkFeatures (features."regex"."1.3.1" or {});
  };
  features_.regex."1.3.1" = deps: f: updateFeatures f (rec {
    aho_corasick."${deps.regex."1.3.1".aho_corasick}".default = true;
    memchr."${deps.regex."1.3.1".memchr}".default = true;
    regex = fold recursiveUpdate {} [
      { "1.3.1"."aho-corasick" =
        (f.regex."1.3.1"."aho-corasick" or false) ||
        (f.regex."1.3.1".perf-literal or false) ||
        (regex."1.3.1"."perf-literal" or false); }
      { "1.3.1"."memchr" =
        (f.regex."1.3.1"."memchr" or false) ||
        (f.regex."1.3.1".perf-literal or false) ||
        (regex."1.3.1"."perf-literal" or false); }
      { "1.3.1"."pattern" =
        (f.regex."1.3.1"."pattern" or false) ||
        (f.regex."1.3.1".unstable or false) ||
        (regex."1.3.1"."unstable" or false); }
      { "1.3.1"."perf" =
        (f.regex."1.3.1"."perf" or false) ||
        (f.regex."1.3.1".default or false) ||
        (regex."1.3.1"."default" or false); }
      { "1.3.1"."perf-cache" =
        (f.regex."1.3.1"."perf-cache" or false) ||
        (f.regex."1.3.1".perf or false) ||
        (regex."1.3.1"."perf" or false); }
      { "1.3.1"."perf-dfa" =
        (f.regex."1.3.1"."perf-dfa" or false) ||
        (f.regex."1.3.1".perf or false) ||
        (regex."1.3.1"."perf" or false); }
      { "1.3.1"."perf-inline" =
        (f.regex."1.3.1"."perf-inline" or false) ||
        (f.regex."1.3.1".perf or false) ||
        (regex."1.3.1"."perf" or false); }
      { "1.3.1"."perf-literal" =
        (f.regex."1.3.1"."perf-literal" or false) ||
        (f.regex."1.3.1".perf or false) ||
        (regex."1.3.1"."perf" or false); }
      { "1.3.1"."std" =
        (f.regex."1.3.1"."std" or false) ||
        (f.regex."1.3.1".default or false) ||
        (regex."1.3.1"."default" or false) ||
        (f.regex."1.3.1".use_std or false) ||
        (regex."1.3.1"."use_std" or false); }
      { "1.3.1"."thread_local" =
        (f.regex."1.3.1"."thread_local" or false) ||
        (f.regex."1.3.1".perf-cache or false) ||
        (regex."1.3.1"."perf-cache" or false); }
      { "1.3.1"."unicode" =
        (f.regex."1.3.1"."unicode" or false) ||
        (f.regex."1.3.1".default or false) ||
        (regex."1.3.1"."default" or false); }
      { "1.3.1"."unicode-age" =
        (f.regex."1.3.1"."unicode-age" or false) ||
        (f.regex."1.3.1".unicode or false) ||
        (regex."1.3.1"."unicode" or false); }
      { "1.3.1"."unicode-bool" =
        (f.regex."1.3.1"."unicode-bool" or false) ||
        (f.regex."1.3.1".unicode or false) ||
        (regex."1.3.1"."unicode" or false); }
      { "1.3.1"."unicode-case" =
        (f.regex."1.3.1"."unicode-case" or false) ||
        (f.regex."1.3.1".unicode or false) ||
        (regex."1.3.1"."unicode" or false); }
      { "1.3.1"."unicode-gencat" =
        (f.regex."1.3.1"."unicode-gencat" or false) ||
        (f.regex."1.3.1".unicode or false) ||
        (regex."1.3.1"."unicode" or false); }
      { "1.3.1"."unicode-perl" =
        (f.regex."1.3.1"."unicode-perl" or false) ||
        (f.regex."1.3.1".unicode or false) ||
        (regex."1.3.1"."unicode" or false); }
      { "1.3.1"."unicode-script" =
        (f.regex."1.3.1"."unicode-script" or false) ||
        (f.regex."1.3.1".unicode or false) ||
        (regex."1.3.1"."unicode" or false); }
      { "1.3.1"."unicode-segment" =
        (f.regex."1.3.1"."unicode-segment" or false) ||
        (f.regex."1.3.1".unicode or false) ||
        (regex."1.3.1"."unicode" or false); }
      { "1.3.1".default = (f.regex."1.3.1".default or true); }
    ];
    regex_syntax = fold recursiveUpdate {} [
      { "${deps.regex."1.3.1".regex_syntax}"."unicode-age" =
        (f.regex_syntax."${deps.regex."1.3.1".regex_syntax}"."unicode-age" or false) ||
        (regex."1.3.1"."unicode-age" or false) ||
        (f."regex"."1.3.1"."unicode-age" or false); }
      { "${deps.regex."1.3.1".regex_syntax}"."unicode-bool" =
        (f.regex_syntax."${deps.regex."1.3.1".regex_syntax}"."unicode-bool" or false) ||
        (regex."1.3.1"."unicode-bool" or false) ||
        (f."regex"."1.3.1"."unicode-bool" or false); }
      { "${deps.regex."1.3.1".regex_syntax}"."unicode-case" =
        (f.regex_syntax."${deps.regex."1.3.1".regex_syntax}"."unicode-case" or false) ||
        (regex."1.3.1"."unicode-case" or false) ||
        (f."regex"."1.3.1"."unicode-case" or false); }
      { "${deps.regex."1.3.1".regex_syntax}"."unicode-gencat" =
        (f.regex_syntax."${deps.regex."1.3.1".regex_syntax}"."unicode-gencat" or false) ||
        (regex."1.3.1"."unicode-gencat" or false) ||
        (f."regex"."1.3.1"."unicode-gencat" or false); }
      { "${deps.regex."1.3.1".regex_syntax}"."unicode-perl" =
        (f.regex_syntax."${deps.regex."1.3.1".regex_syntax}"."unicode-perl" or false) ||
        (regex."1.3.1"."unicode-perl" or false) ||
        (f."regex"."1.3.1"."unicode-perl" or false); }
      { "${deps.regex."1.3.1".regex_syntax}"."unicode-script" =
        (f.regex_syntax."${deps.regex."1.3.1".regex_syntax}"."unicode-script" or false) ||
        (regex."1.3.1"."unicode-script" or false) ||
        (f."regex"."1.3.1"."unicode-script" or false); }
      { "${deps.regex."1.3.1".regex_syntax}"."unicode-segment" =
        (f.regex_syntax."${deps.regex."1.3.1".regex_syntax}"."unicode-segment" or false) ||
        (regex."1.3.1"."unicode-segment" or false) ||
        (f."regex"."1.3.1"."unicode-segment" or false); }
      { "${deps.regex."1.3.1".regex_syntax}".default = (f.regex_syntax."${deps.regex."1.3.1".regex_syntax}".default or false); }
    ];
    thread_local."${deps.regex."1.3.1".thread_local}".default = true;
  }) [
    (features_.aho_corasick."${deps."regex"."1.3.1"."aho_corasick"}" deps)
    (features_.memchr."${deps."regex"."1.3.1"."memchr"}" deps)
    (features_.regex_syntax."${deps."regex"."1.3.1"."regex_syntax"}" deps)
    (features_.thread_local."${deps."regex"."1.3.1"."thread_local"}" deps)
  ];


# end
# regex-syntax-0.6.12

  crates.regex_syntax."0.6.12" = deps: { features?(features_.regex_syntax."0.6.12" deps {}) }: buildRustCrate {
    crateName = "regex-syntax";
    version = "0.6.12";
    description = "A regular expression parser.";
    authors = [ "The Rust Project Developers" ];
    sha256 = "1lqhddhwzpgq8zfkxhm241n7g4m3yc11fb4098dkgawbxvybr53v";
    features = mkFeatures (features."regex_syntax"."0.6.12" or {});
  };
  features_.regex_syntax."0.6.12" = deps: f: updateFeatures f (rec {
    regex_syntax = fold recursiveUpdate {} [
      { "0.6.12"."unicode" =
        (f.regex_syntax."0.6.12"."unicode" or false) ||
        (f.regex_syntax."0.6.12".default or false) ||
        (regex_syntax."0.6.12"."default" or false); }
      { "0.6.12"."unicode-age" =
        (f.regex_syntax."0.6.12"."unicode-age" or false) ||
        (f.regex_syntax."0.6.12".unicode or false) ||
        (regex_syntax."0.6.12"."unicode" or false); }
      { "0.6.12"."unicode-bool" =
        (f.regex_syntax."0.6.12"."unicode-bool" or false) ||
        (f.regex_syntax."0.6.12".unicode or false) ||
        (regex_syntax."0.6.12"."unicode" or false); }
      { "0.6.12"."unicode-case" =
        (f.regex_syntax."0.6.12"."unicode-case" or false) ||
        (f.regex_syntax."0.6.12".unicode or false) ||
        (regex_syntax."0.6.12"."unicode" or false); }
      { "0.6.12"."unicode-gencat" =
        (f.regex_syntax."0.6.12"."unicode-gencat" or false) ||
        (f.regex_syntax."0.6.12".unicode or false) ||
        (regex_syntax."0.6.12"."unicode" or false); }
      { "0.6.12"."unicode-perl" =
        (f.regex_syntax."0.6.12"."unicode-perl" or false) ||
        (f.regex_syntax."0.6.12".unicode or false) ||
        (regex_syntax."0.6.12"."unicode" or false); }
      { "0.6.12"."unicode-script" =
        (f.regex_syntax."0.6.12"."unicode-script" or false) ||
        (f.regex_syntax."0.6.12".unicode or false) ||
        (regex_syntax."0.6.12"."unicode" or false); }
      { "0.6.12"."unicode-segment" =
        (f.regex_syntax."0.6.12"."unicode-segment" or false) ||
        (f.regex_syntax."0.6.12".unicode or false) ||
        (regex_syntax."0.6.12"."unicode" or false); }
      { "0.6.12".default = (f.regex_syntax."0.6.12".default or true); }
    ];
  }) [];


# end
# remove_dir_all-0.5.2

  crates.remove_dir_all."0.5.2" = deps: { features?(features_.remove_dir_all."0.5.2" deps {}) }: buildRustCrate {
    crateName = "remove_dir_all";
    version = "0.5.2";
    description = "A safe, reliable implementation of remove_dir_all for Windows";
    authors = [ "Aaronepower <theaaronepower@gmail.com>" ];
    sha256 = "04sxg2ppvxiljc2i13bwvpbi540rf9d2a89cq0wmqf9pjvr3a1wm";
    dependencies = (if kernel == "windows" then mapFeatures features ([
      (crates."winapi"."${deps."remove_dir_all"."0.5.2"."winapi"}" deps)
    ]) else []);
  };
  features_.remove_dir_all."0.5.2" = deps: f: updateFeatures f (rec {
    remove_dir_all."0.5.2".default = (f.remove_dir_all."0.5.2".default or true);
    winapi = fold recursiveUpdate {} [
      { "${deps.remove_dir_all."0.5.2".winapi}"."errhandlingapi" = true; }
      { "${deps.remove_dir_all."0.5.2".winapi}"."fileapi" = true; }
      { "${deps.remove_dir_all."0.5.2".winapi}"."std" = true; }
      { "${deps.remove_dir_all."0.5.2".winapi}"."winbase" = true; }
      { "${deps.remove_dir_all."0.5.2".winapi}"."winerror" = true; }
      { "${deps.remove_dir_all."0.5.2".winapi}".default = true; }
    ];
  }) [
    (features_.winapi."${deps."remove_dir_all"."0.5.2"."winapi"}" deps)
  ];


# end
# reqwest-0.9.20

  crates.reqwest."0.9.20" = deps: { features?(features_.reqwest."0.9.20" deps {}) }: buildRustCrate {
    crateName = "reqwest";
    version = "0.9.20";
    description = "higher level HTTP client library";
    authors = [ "Sean McArthur <sean@seanmonstar.com>" ];
    sha256 = "1fjcjvh9qqcxzxbb2vws1j7xsjigkzdrzvkma0rdi10y5bnaikii";
    dependencies = mapFeatures features ([
      (crates."base64"."${deps."reqwest"."0.9.20"."base64"}" deps)
      (crates."bytes"."${deps."reqwest"."0.9.20"."bytes"}" deps)
      (crates."cookie"."${deps."reqwest"."0.9.20"."cookie"}" deps)
      (crates."cookie_store"."${deps."reqwest"."0.9.20"."cookie_store"}" deps)
      (crates."encoding_rs"."${deps."reqwest"."0.9.20"."encoding_rs"}" deps)
      (crates."flate2"."${deps."reqwest"."0.9.20"."flate2"}" deps)
      (crates."futures"."${deps."reqwest"."0.9.20"."futures"}" deps)
      (crates."http"."${deps."reqwest"."0.9.20"."http"}" deps)
      (crates."hyper"."${deps."reqwest"."0.9.20"."hyper"}" deps)
      (crates."log"."${deps."reqwest"."0.9.20"."log"}" deps)
      (crates."mime"."${deps."reqwest"."0.9.20"."mime"}" deps)
      (crates."mime_guess"."${deps."reqwest"."0.9.20"."mime_guess"}" deps)
      (crates."serde"."${deps."reqwest"."0.9.20"."serde"}" deps)
      (crates."serde_json"."${deps."reqwest"."0.9.20"."serde_json"}" deps)
      (crates."serde_urlencoded"."${deps."reqwest"."0.9.20"."serde_urlencoded"}" deps)
      (crates."time"."${deps."reqwest"."0.9.20"."time"}" deps)
      (crates."tokio"."${deps."reqwest"."0.9.20"."tokio"}" deps)
      (crates."tokio_executor"."${deps."reqwest"."0.9.20"."tokio_executor"}" deps)
      (crates."tokio_io"."${deps."reqwest"."0.9.20"."tokio_io"}" deps)
      (crates."tokio_threadpool"."${deps."reqwest"."0.9.20"."tokio_threadpool"}" deps)
      (crates."tokio_timer"."${deps."reqwest"."0.9.20"."tokio_timer"}" deps)
      (crates."url"."${deps."reqwest"."0.9.20"."url"}" deps)
      (crates."uuid"."${deps."reqwest"."0.9.20"."uuid"}" deps)
    ]
      ++ (if features.reqwest."0.9.20".hyper-tls or false then [ (crates.hyper_tls."${deps."reqwest"."0.9.20".hyper_tls}" deps) ] else [])
      ++ (if features.reqwest."0.9.20".native-tls or false then [ (crates.native_tls."${deps."reqwest"."0.9.20".native_tls}" deps) ] else []))
      ++ (if kernel == "windows" then mapFeatures features ([
      (crates."winreg"."${deps."reqwest"."0.9.20"."winreg"}" deps)
    ]) else []);
    features = mkFeatures (features."reqwest"."0.9.20" or {});
  };
  features_.reqwest."0.9.20" = deps: f: updateFeatures f (rec {
    base64."${deps.reqwest."0.9.20".base64}".default = true;
    bytes."${deps.reqwest."0.9.20".bytes}".default = true;
    cookie."${deps.reqwest."0.9.20".cookie}".default = true;
    cookie_store."${deps.reqwest."0.9.20".cookie_store}".default = true;
    encoding_rs."${deps.reqwest."0.9.20".encoding_rs}".default = true;
    flate2 = fold recursiveUpdate {} [
      { "${deps.reqwest."0.9.20".flate2}"."rust_backend" = true; }
      { "${deps.reqwest."0.9.20".flate2}".default = (f.flate2."${deps.reqwest."0.9.20".flate2}".default or false); }
    ];
    futures."${deps.reqwest."0.9.20".futures}".default = true;
    http."${deps.reqwest."0.9.20".http}".default = true;
    hyper."${deps.reqwest."0.9.20".hyper}".default = true;
    hyper_tls."${deps.reqwest."0.9.20".hyper_tls}".default = true;
    log."${deps.reqwest."0.9.20".log}".default = true;
    mime."${deps.reqwest."0.9.20".mime}".default = true;
    mime_guess."${deps.reqwest."0.9.20".mime_guess}".default = true;
    native_tls = fold recursiveUpdate {} [
      { "${deps.reqwest."0.9.20".native_tls}"."vendored" =
        (f.native_tls."${deps.reqwest."0.9.20".native_tls}"."vendored" or false) ||
        (reqwest."0.9.20"."default-tls-vendored" or false) ||
        (f."reqwest"."0.9.20"."default-tls-vendored" or false); }
      { "${deps.reqwest."0.9.20".native_tls}".default = true; }
    ];
    reqwest = fold recursiveUpdate {} [
      { "0.9.20"."default-tls" =
        (f.reqwest."0.9.20"."default-tls" or false) ||
        (f.reqwest."0.9.20".default or false) ||
        (reqwest."0.9.20"."default" or false) ||
        (f.reqwest."0.9.20".default-tls-vendored or false) ||
        (reqwest."0.9.20"."default-tls-vendored" or false); }
      { "0.9.20"."hyper-old-types" =
        (f.reqwest."0.9.20"."hyper-old-types" or false) ||
        (f.reqwest."0.9.20".hyper-011 or false) ||
        (reqwest."0.9.20"."hyper-011" or false); }
      { "0.9.20"."hyper-rustls" =
        (f.reqwest."0.9.20"."hyper-rustls" or false) ||
        (f.reqwest."0.9.20".rustls-tls or false) ||
        (reqwest."0.9.20"."rustls-tls" or false); }
      { "0.9.20"."hyper-tls" =
        (f.reqwest."0.9.20"."hyper-tls" or false) ||
        (f.reqwest."0.9.20".default-tls or false) ||
        (reqwest."0.9.20"."default-tls" or false); }
      { "0.9.20"."native-tls" =
        (f.reqwest."0.9.20"."native-tls" or false) ||
        (f.reqwest."0.9.20".default-tls or false) ||
        (reqwest."0.9.20"."default-tls" or false); }
      { "0.9.20"."rustls" =
        (f.reqwest."0.9.20"."rustls" or false) ||
        (f.reqwest."0.9.20".rustls-tls or false) ||
        (reqwest."0.9.20"."rustls-tls" or false); }
      { "0.9.20"."tls" =
        (f.reqwest."0.9.20"."tls" or false) ||
        (f.reqwest."0.9.20".default-tls or false) ||
        (reqwest."0.9.20"."default-tls" or false) ||
        (f.reqwest."0.9.20".rustls-tls or false) ||
        (reqwest."0.9.20"."rustls-tls" or false); }
      { "0.9.20"."tokio-rustls" =
        (f.reqwest."0.9.20"."tokio-rustls" or false) ||
        (f.reqwest."0.9.20".rustls-tls or false) ||
        (reqwest."0.9.20"."rustls-tls" or false); }
      { "0.9.20"."trust-dns-resolver" =
        (f.reqwest."0.9.20"."trust-dns-resolver" or false) ||
        (f.reqwest."0.9.20".trust-dns or false) ||
        (reqwest."0.9.20"."trust-dns" or false); }
      { "0.9.20"."webpki-roots" =
        (f.reqwest."0.9.20"."webpki-roots" or false) ||
        (f.reqwest."0.9.20".rustls-tls or false) ||
        (reqwest."0.9.20"."rustls-tls" or false); }
      { "0.9.20".default = (f.reqwest."0.9.20".default or true); }
    ];
    serde."${deps.reqwest."0.9.20".serde}".default = true;
    serde_json."${deps.reqwest."0.9.20".serde_json}".default = true;
    serde_urlencoded."${deps.reqwest."0.9.20".serde_urlencoded}".default = true;
    time."${deps.reqwest."0.9.20".time}".default = true;
    tokio = fold recursiveUpdate {} [
      { "${deps.reqwest."0.9.20".tokio}"."rt-full" = true; }
      { "${deps.reqwest."0.9.20".tokio}"."tcp" = true; }
      { "${deps.reqwest."0.9.20".tokio}".default = (f.tokio."${deps.reqwest."0.9.20".tokio}".default or false); }
    ];
    tokio_executor."${deps.reqwest."0.9.20".tokio_executor}".default = true;
    tokio_io."${deps.reqwest."0.9.20".tokio_io}".default = true;
    tokio_threadpool."${deps.reqwest."0.9.20".tokio_threadpool}".default = true;
    tokio_timer."${deps.reqwest."0.9.20".tokio_timer}".default = true;
    url."${deps.reqwest."0.9.20".url}".default = true;
    uuid = fold recursiveUpdate {} [
      { "${deps.reqwest."0.9.20".uuid}"."v4" = true; }
      { "${deps.reqwest."0.9.20".uuid}".default = true; }
    ];
    winreg."${deps.reqwest."0.9.20".winreg}".default = true;
  }) [
    (features_.base64."${deps."reqwest"."0.9.20"."base64"}" deps)
    (features_.bytes."${deps."reqwest"."0.9.20"."bytes"}" deps)
    (features_.cookie."${deps."reqwest"."0.9.20"."cookie"}" deps)
    (features_.cookie_store."${deps."reqwest"."0.9.20"."cookie_store"}" deps)
    (features_.encoding_rs."${deps."reqwest"."0.9.20"."encoding_rs"}" deps)
    (features_.flate2."${deps."reqwest"."0.9.20"."flate2"}" deps)
    (features_.futures."${deps."reqwest"."0.9.20"."futures"}" deps)
    (features_.http."${deps."reqwest"."0.9.20"."http"}" deps)
    (features_.hyper."${deps."reqwest"."0.9.20"."hyper"}" deps)
    (features_.hyper_tls."${deps."reqwest"."0.9.20"."hyper_tls"}" deps)
    (features_.log."${deps."reqwest"."0.9.20"."log"}" deps)
    (features_.mime."${deps."reqwest"."0.9.20"."mime"}" deps)
    (features_.mime_guess."${deps."reqwest"."0.9.20"."mime_guess"}" deps)
    (features_.native_tls."${deps."reqwest"."0.9.20"."native_tls"}" deps)
    (features_.serde."${deps."reqwest"."0.9.20"."serde"}" deps)
    (features_.serde_json."${deps."reqwest"."0.9.20"."serde_json"}" deps)
    (features_.serde_urlencoded."${deps."reqwest"."0.9.20"."serde_urlencoded"}" deps)
    (features_.time."${deps."reqwest"."0.9.20"."time"}" deps)
    (features_.tokio."${deps."reqwest"."0.9.20"."tokio"}" deps)
    (features_.tokio_executor."${deps."reqwest"."0.9.20"."tokio_executor"}" deps)
    (features_.tokio_io."${deps."reqwest"."0.9.20"."tokio_io"}" deps)
    (features_.tokio_threadpool."${deps."reqwest"."0.9.20"."tokio_threadpool"}" deps)
    (features_.tokio_timer."${deps."reqwest"."0.9.20"."tokio_timer"}" deps)
    (features_.url."${deps."reqwest"."0.9.20"."url"}" deps)
    (features_.uuid."${deps."reqwest"."0.9.20"."uuid"}" deps)
    (features_.winreg."${deps."reqwest"."0.9.20"."winreg"}" deps)
  ];


# end
# robots_txt-0.6.0

  crates.robots_txt."0.6.0" = deps: { features?(features_.robots_txt."0.6.0" deps {}) }: buildRustCrate {
    crateName = "robots_txt";
    version = "0.6.0";
    description = "Lightweight robots.txt parser and generator";
    authors = [ "Alexander Irbis <irbis.labs@gmail.com>" ];
    edition = "2018";
    sha256 = "1fh2pxg36jhmyk006v57649ifa05bgbq0ms9if8hbvh10490pblr";
    dependencies = mapFeatures features ([
      (crates."url"."${deps."robots_txt"."0.6.0"."url"}" deps)
    ]);
    features = mkFeatures (features."robots_txt"."0.6.0" or {});
  };
  features_.robots_txt."0.6.0" = deps: f: updateFeatures f (rec {
    robots_txt = fold recursiveUpdate {} [
      { "0.6.0"."release" =
        (f.robots_txt."0.6.0"."release" or false) ||
        (f.robots_txt."0.6.0".default or false) ||
        (robots_txt."0.6.0"."default" or false); }
      { "0.6.0".default = (f.robots_txt."0.6.0".default or true); }
    ];
    url."${deps.robots_txt."0.6.0".url}".default = true;
  }) [
    (features_.url."${deps."robots_txt"."0.6.0"."url"}" deps)
  ];


# end
# rustc-demangle-0.1.16

  crates.rustc_demangle."0.1.16" = deps: { features?(features_.rustc_demangle."0.1.16" deps {}) }: buildRustCrate {
    crateName = "rustc-demangle";
    version = "0.1.16";
    description = "Rust compiler symbol demangling.\n";
    authors = [ "Alex Crichton <alex@alexcrichton.com>" ];
    sha256 = "0zmn448d0f898ahfkz7cir0fi0vk84dabjpw84mk6a1r6nf9vzmi";
    dependencies = mapFeatures features ([
]);
    features = mkFeatures (features."rustc_demangle"."0.1.16" or {});
  };
  features_.rustc_demangle."0.1.16" = deps: f: updateFeatures f (rec {
    rustc_demangle = fold recursiveUpdate {} [
      { "0.1.16"."compiler_builtins" =
        (f.rustc_demangle."0.1.16"."compiler_builtins" or false) ||
        (f.rustc_demangle."0.1.16".rustc-dep-of-std or false) ||
        (rustc_demangle."0.1.16"."rustc-dep-of-std" or false); }
      { "0.1.16"."core" =
        (f.rustc_demangle."0.1.16"."core" or false) ||
        (f.rustc_demangle."0.1.16".rustc-dep-of-std or false) ||
        (rustc_demangle."0.1.16"."rustc-dep-of-std" or false); }
      { "0.1.16".default = (f.rustc_demangle."0.1.16".default or true); }
    ];
  }) [];


# end
# rustc_version-0.2.3

  crates.rustc_version."0.2.3" = deps: { features?(features_.rustc_version."0.2.3" deps {}) }: buildRustCrate {
    crateName = "rustc_version";
    version = "0.2.3";
    description = "A library for querying the version of a installed rustc compiler";
    authors = [ "Marvin Löbel <loebel.marvin@gmail.com>" ];
    sha256 = "0rgwzbgs3i9fqjm1p4ra3n7frafmpwl29c8lw85kv1rxn7n2zaa7";
    dependencies = mapFeatures features ([
      (crates."semver"."${deps."rustc_version"."0.2.3"."semver"}" deps)
    ]);
  };
  features_.rustc_version."0.2.3" = deps: f: updateFeatures f (rec {
    rustc_version."0.2.3".default = (f.rustc_version."0.2.3".default or true);
    semver."${deps.rustc_version."0.2.3".semver}".default = true;
  }) [
    (features_.semver."${deps."rustc_version"."0.2.3"."semver"}" deps)
  ];


# end
# ryu-1.0.0

  crates.ryu."1.0.0" = deps: { features?(features_.ryu."1.0.0" deps {}) }: buildRustCrate {
    crateName = "ryu";
    version = "1.0.0";
    description = "Fast floating point to string conversion";
    authors = [ "David Tolnay <dtolnay@gmail.com>" ];
    sha256 = "0hysqba7hi31xw1jka8jh7qb4m9fx5l6vik55wpc3rpsg46cwgbf";
    build = "build.rs";
    dependencies = mapFeatures features ([
]);
    features = mkFeatures (features."ryu"."1.0.0" or {});
  };
  features_.ryu."1.0.0" = deps: f: updateFeatures f (rec {
    ryu."1.0.0".default = (f.ryu."1.0.0".default or true);
  }) [];


# end
# schannel-0.1.16

  crates.schannel."0.1.16" = deps: { features?(features_.schannel."0.1.16" deps {}) }: buildRustCrate {
    crateName = "schannel";
    version = "0.1.16";
    description = "Schannel bindings for rust, allowing SSL/TLS (e.g. https) without openssl";
    authors = [ "Steven Fackler <sfackler@gmail.com>" "Steffen Butzer <steffen.butzer@outlook.com>" ];
    sha256 = "1qf391890l43lzkyadhrwrlkpryyjmral75x9xj664vi3asl854g";
    dependencies = mapFeatures features ([
      (crates."lazy_static"."${deps."schannel"."0.1.16"."lazy_static"}" deps)
      (crates."winapi"."${deps."schannel"."0.1.16"."winapi"}" deps)
    ]);
  };
  features_.schannel."0.1.16" = deps: f: updateFeatures f (rec {
    lazy_static."${deps.schannel."0.1.16".lazy_static}".default = true;
    schannel."0.1.16".default = (f.schannel."0.1.16".default or true);
    winapi = fold recursiveUpdate {} [
      { "${deps.schannel."0.1.16".winapi}"."lmcons" = true; }
      { "${deps.schannel."0.1.16".winapi}"."minschannel" = true; }
      { "${deps.schannel."0.1.16".winapi}"."schannel" = true; }
      { "${deps.schannel."0.1.16".winapi}"."securitybaseapi" = true; }
      { "${deps.schannel."0.1.16".winapi}"."sspi" = true; }
      { "${deps.schannel."0.1.16".winapi}"."sysinfoapi" = true; }
      { "${deps.schannel."0.1.16".winapi}"."timezoneapi" = true; }
      { "${deps.schannel."0.1.16".winapi}"."winbase" = true; }
      { "${deps.schannel."0.1.16".winapi}"."wincrypt" = true; }
      { "${deps.schannel."0.1.16".winapi}"."winerror" = true; }
      { "${deps.schannel."0.1.16".winapi}".default = true; }
    ];
  }) [
    (features_.lazy_static."${deps."schannel"."0.1.16"."lazy_static"}" deps)
    (features_.winapi."${deps."schannel"."0.1.16"."winapi"}" deps)
  ];


# end
# scopeguard-0.3.3

  crates.scopeguard."0.3.3" = deps: { features?(features_.scopeguard."0.3.3" deps {}) }: buildRustCrate {
    crateName = "scopeguard";
    version = "0.3.3";
    description = "A RAII scope guard that will run a given closure when it goes out of scope,\neven if the code between panics (assuming unwinding panic).\n\nDefines the macros `defer!` and `defer_on_unwind!`; the latter only runs\nif the scope is extited through unwinding on panic.\n";
    authors = [ "bluss" ];
    sha256 = "0i1l013csrqzfz6c68pr5pi01hg5v5yahq8fsdmaxy6p8ygsjf3r";
    features = mkFeatures (features."scopeguard"."0.3.3" or {});
  };
  features_.scopeguard."0.3.3" = deps: f: updateFeatures f (rec {
    scopeguard = fold recursiveUpdate {} [
      { "0.3.3"."use_std" =
        (f.scopeguard."0.3.3"."use_std" or false) ||
        (f.scopeguard."0.3.3".default or false) ||
        (scopeguard."0.3.3"."default" or false); }
      { "0.3.3".default = (f.scopeguard."0.3.3".default or true); }
    ];
  }) [];


# end
# scopeguard-1.0.0

  crates.scopeguard."1.0.0" = deps: { features?(features_.scopeguard."1.0.0" deps {}) }: buildRustCrate {
    crateName = "scopeguard";
    version = "1.0.0";
    description = "A RAII scope guard that will run a given closure when it goes out of scope,\neven if the code between panics (assuming unwinding panic).\n\nDefines the macros `defer!`, `defer_on_unwind!`, `defer_on_success!` as\nshorthands for guards with one of the implemented strategies.\n";
    authors = [ "bluss" ];
    sha256 = "15vrix0jx3i4naqnjswddzn4m036krrv71a8vkh3b1zq4hxmrb0q";
    features = mkFeatures (features."scopeguard"."1.0.0" or {});
  };
  features_.scopeguard."1.0.0" = deps: f: updateFeatures f (rec {
    scopeguard = fold recursiveUpdate {} [
      { "1.0.0"."use_std" =
        (f.scopeguard."1.0.0"."use_std" or false) ||
        (f.scopeguard."1.0.0".default or false) ||
        (scopeguard."1.0.0"."default" or false); }
      { "1.0.0".default = (f.scopeguard."1.0.0".default or true); }
    ];
  }) [];


# end
# scraper-0.10.1

  crates.scraper."0.10.1" = deps: { features?(features_.scraper."0.10.1" deps {}) }: buildRustCrate {
    crateName = "scraper";
    version = "0.10.1";
    description = "HTML parsing and querying with CSS selectors";
    authors = [ "Curtis McEnroe <june@causal.agency>" "Vivek Kushwaha <yoursvivek@gmail.com>" ];
    sha256 = "04vikd5dizcr3azsi8026gr1hbrpjwh3q3w4s24bhy1piplqnf4f";
    crateBin =
      (if features."scraper"."0.10.1"."main" then [{  name = "scraper";  path = "src/main.rs"; } ] else []);
    dependencies = mapFeatures features ([
      (crates."cssparser"."${deps."scraper"."0.10.1"."cssparser"}" deps)
      (crates."ego_tree"."${deps."scraper"."0.10.1"."ego_tree"}" deps)
      (crates."html5ever"."${deps."scraper"."0.10.1"."html5ever"}" deps)
      (crates."matches"."${deps."scraper"."0.10.1"."matches"}" deps)
      (crates."selectors"."${deps."scraper"."0.10.1"."selectors"}" deps)
      (crates."smallvec"."${deps."scraper"."0.10.1"."smallvec"}" deps)
      (crates."tendril"."${deps."scraper"."0.10.1"."tendril"}" deps)
    ]
      ++ (if features.scraper."0.10.1".getopts or false then [ (crates.getopts."${deps."scraper"."0.10.1".getopts}" deps) ] else []));
    features = mkFeatures (features."scraper"."0.10.1" or {});
  };
  features_.scraper."0.10.1" = deps: f: updateFeatures f (rec {
    cssparser."${deps.scraper."0.10.1".cssparser}".default = true;
    ego_tree."${deps.scraper."0.10.1".ego_tree}".default = true;
    getopts."${deps.scraper."0.10.1".getopts}".default = true;
    html5ever."${deps.scraper."0.10.1".html5ever}".default = true;
    matches."${deps.scraper."0.10.1".matches}".default = true;
    scraper = fold recursiveUpdate {} [
      { "0.10.1"."getopts" =
        (f.scraper."0.10.1"."getopts" or false) ||
        (f.scraper."0.10.1".main or false) ||
        (scraper."0.10.1"."main" or false); }
      { "0.10.1"."main" =
        (f.scraper."0.10.1"."main" or false) ||
        (f.scraper."0.10.1".default or false) ||
        (scraper."0.10.1"."default" or false); }
      { "0.10.1".default = (f.scraper."0.10.1".default or true); }
    ];
    selectors."${deps.scraper."0.10.1".selectors}".default = true;
    smallvec."${deps.scraper."0.10.1".smallvec}".default = true;
    tendril."${deps.scraper."0.10.1".tendril}".default = true;
  }) [
    (features_.cssparser."${deps."scraper"."0.10.1"."cssparser"}" deps)
    (features_.ego_tree."${deps."scraper"."0.10.1"."ego_tree"}" deps)
    (features_.getopts."${deps."scraper"."0.10.1"."getopts"}" deps)
    (features_.html5ever."${deps."scraper"."0.10.1"."html5ever"}" deps)
    (features_.matches."${deps."scraper"."0.10.1"."matches"}" deps)
    (features_.selectors."${deps."scraper"."0.10.1"."selectors"}" deps)
    (features_.smallvec."${deps."scraper"."0.10.1"."smallvec"}" deps)
    (features_.tendril."${deps."scraper"."0.10.1"."tendril"}" deps)
  ];


# end
# security-framework-0.3.1

  crates.security_framework."0.3.1" = deps: { features?(features_.security_framework."0.3.1" deps {}) }: buildRustCrate {
    crateName = "security-framework";
    version = "0.3.1";
    description = "Security.framework bindings for macOS and iOS";
    authors = [ "Steven Fackler <sfackler@gmail.com>" "Kornel <kornel@geekhood.net>" ];
    sha256 = "1vycb3xhdd91sy2j6a19iykn6wzdjj0r7cd9p3bx4522fl0l5m84";
    dependencies = mapFeatures features ([
      (crates."core_foundation"."${deps."security_framework"."0.3.1"."core_foundation"}" deps)
      (crates."core_foundation_sys"."${deps."security_framework"."0.3.1"."core_foundation_sys"}" deps)
      (crates."libc"."${deps."security_framework"."0.3.1"."libc"}" deps)
      (crates."security_framework_sys"."${deps."security_framework"."0.3.1"."security_framework_sys"}" deps)
    ]);
    features = mkFeatures (features."security_framework"."0.3.1" or {});
  };
  features_.security_framework."0.3.1" = deps: f: updateFeatures f (rec {
    core_foundation."${deps.security_framework."0.3.1".core_foundation}".default = true;
    core_foundation_sys."${deps.security_framework."0.3.1".core_foundation_sys}".default = true;
    libc."${deps.security_framework."0.3.1".libc}".default = true;
    security_framework = fold recursiveUpdate {} [
      { "0.3.1"."OSX_10_10" =
        (f.security_framework."0.3.1"."OSX_10_10" or false) ||
        (f.security_framework."0.3.1".OSX_10_11 or false) ||
        (security_framework."0.3.1"."OSX_10_11" or false); }
      { "0.3.1"."OSX_10_11" =
        (f.security_framework."0.3.1"."OSX_10_11" or false) ||
        (f.security_framework."0.3.1".OSX_10_12 or false) ||
        (security_framework."0.3.1"."OSX_10_12" or false); }
      { "0.3.1"."OSX_10_12" =
        (f.security_framework."0.3.1"."OSX_10_12" or false) ||
        (f.security_framework."0.3.1".OSX_10_13 or false) ||
        (security_framework."0.3.1"."OSX_10_13" or false); }
      { "0.3.1"."OSX_10_9" =
        (f.security_framework."0.3.1"."OSX_10_9" or false) ||
        (f.security_framework."0.3.1".OSX_10_10 or false) ||
        (security_framework."0.3.1"."OSX_10_10" or false); }
      { "0.3.1"."alpn" =
        (f.security_framework."0.3.1"."alpn" or false) ||
        (f.security_framework."0.3.1".OSX_10_13 or false) ||
        (security_framework."0.3.1"."OSX_10_13" or false); }
      { "0.3.1".default = (f.security_framework."0.3.1".default or true); }
    ];
    security_framework_sys = fold recursiveUpdate {} [
      { "${deps.security_framework."0.3.1".security_framework_sys}"."OSX_10_10" =
        (f.security_framework_sys."${deps.security_framework."0.3.1".security_framework_sys}"."OSX_10_10" or false) ||
        (security_framework."0.3.1"."OSX_10_10" or false) ||
        (f."security_framework"."0.3.1"."OSX_10_10" or false); }
      { "${deps.security_framework."0.3.1".security_framework_sys}"."OSX_10_11" =
        (f.security_framework_sys."${deps.security_framework."0.3.1".security_framework_sys}"."OSX_10_11" or false) ||
        (security_framework."0.3.1"."OSX_10_11" or false) ||
        (f."security_framework"."0.3.1"."OSX_10_11" or false); }
      { "${deps.security_framework."0.3.1".security_framework_sys}"."OSX_10_12" =
        (f.security_framework_sys."${deps.security_framework."0.3.1".security_framework_sys}"."OSX_10_12" or false) ||
        (security_framework."0.3.1"."OSX_10_12" or false) ||
        (f."security_framework"."0.3.1"."OSX_10_12" or false); }
      { "${deps.security_framework."0.3.1".security_framework_sys}"."OSX_10_13" =
        (f.security_framework_sys."${deps.security_framework."0.3.1".security_framework_sys}"."OSX_10_13" or false) ||
        (security_framework."0.3.1"."OSX_10_13" or false) ||
        (f."security_framework"."0.3.1"."OSX_10_13" or false); }
      { "${deps.security_framework."0.3.1".security_framework_sys}"."OSX_10_9" =
        (f.security_framework_sys."${deps.security_framework."0.3.1".security_framework_sys}"."OSX_10_9" or false) ||
        (security_framework."0.3.1"."OSX_10_9" or false) ||
        (f."security_framework"."0.3.1"."OSX_10_9" or false); }
      { "${deps.security_framework."0.3.1".security_framework_sys}".default = true; }
    ];
  }) [
    (features_.core_foundation."${deps."security_framework"."0.3.1"."core_foundation"}" deps)
    (features_.core_foundation_sys."${deps."security_framework"."0.3.1"."core_foundation_sys"}" deps)
    (features_.libc."${deps."security_framework"."0.3.1"."libc"}" deps)
    (features_.security_framework_sys."${deps."security_framework"."0.3.1"."security_framework_sys"}" deps)
  ];


# end
# security-framework-sys-0.3.1

  crates.security_framework_sys."0.3.1" = deps: { features?(features_.security_framework_sys."0.3.1" deps {}) }: buildRustCrate {
    crateName = "security-framework-sys";
    version = "0.3.1";
    description = "Apple `Security.framework` low-level FFI bindings";
    authors = [ "Steven Fackler <sfackler@gmail.com>" "Kornel <kornel@geekhood.net>" ];
    sha256 = "11anqpw72d7xjiaz3pbd2r5d3dx0vddya4f6vjnpfjpnldiyd917";
    dependencies = mapFeatures features ([
      (crates."core_foundation_sys"."${deps."security_framework_sys"."0.3.1"."core_foundation_sys"}" deps)
    ]);
    features = mkFeatures (features."security_framework_sys"."0.3.1" or {});
  };
  features_.security_framework_sys."0.3.1" = deps: f: updateFeatures f (rec {
    core_foundation_sys."${deps.security_framework_sys."0.3.1".core_foundation_sys}".default = true;
    security_framework_sys = fold recursiveUpdate {} [
      { "0.3.1"."OSX_10_10" =
        (f.security_framework_sys."0.3.1"."OSX_10_10" or false) ||
        (f.security_framework_sys."0.3.1".OSX_10_11 or false) ||
        (security_framework_sys."0.3.1"."OSX_10_11" or false); }
      { "0.3.1"."OSX_10_11" =
        (f.security_framework_sys."0.3.1"."OSX_10_11" or false) ||
        (f.security_framework_sys."0.3.1".OSX_10_12 or false) ||
        (security_framework_sys."0.3.1"."OSX_10_12" or false); }
      { "0.3.1"."OSX_10_12" =
        (f.security_framework_sys."0.3.1"."OSX_10_12" or false) ||
        (f.security_framework_sys."0.3.1".OSX_10_13 or false) ||
        (security_framework_sys."0.3.1"."OSX_10_13" or false); }
      { "0.3.1"."OSX_10_9" =
        (f.security_framework_sys."0.3.1"."OSX_10_9" or false) ||
        (f.security_framework_sys."0.3.1".OSX_10_10 or false) ||
        (security_framework_sys."0.3.1"."OSX_10_10" or false); }
      { "0.3.1".default = (f.security_framework_sys."0.3.1".default or true); }
    ];
  }) [
    (features_.core_foundation_sys."${deps."security_framework_sys"."0.3.1"."core_foundation_sys"}" deps)
  ];


# end
# select-0.4.3

  crates.select."0.4.3" = deps: { features?(features_.select."0.4.3" deps {}) }: buildRustCrate {
    crateName = "select";
    version = "0.4.3";
    description = "A library to extract useful data from HTML documents, suitable for web scraping.";
    authors = [ "Utkarsh Kukreti <utkarshkukreti@gmail.com>" ];
    sha256 = "0abiggpg2dav3avj0i16n44nxrwzh1hkjnbhlr44jkdcz8zpbwn2";
    dependencies = mapFeatures features ([
      (crates."bit_set"."${deps."select"."0.4.3"."bit_set"}" deps)
      (crates."html5ever"."${deps."select"."0.4.3"."html5ever"}" deps)
    ]);
  };
  features_.select."0.4.3" = deps: f: updateFeatures f (rec {
    bit_set."${deps.select."0.4.3".bit_set}".default = true;
    html5ever."${deps.select."0.4.3".html5ever}".default = true;
    select."0.4.3".default = (f.select."0.4.3".default or true);
  }) [
    (features_.bit_set."${deps."select"."0.4.3"."bit_set"}" deps)
    (features_.html5ever."${deps."select"."0.4.3"."html5ever"}" deps)
  ];


# end
# selectors-0.21.0

  crates.selectors."0.21.0" = deps: { features?(features_.selectors."0.21.0" deps {}) }: buildRustCrate {
    crateName = "selectors";
    version = "0.21.0";
    description = "CSS Selectors matching for Rust";
    authors = [ "The Servo Project Developers" ];
    sha256 = "0yr6yjrfbddl363ba1lb9cfcrdm18w4y2n8svp0z9glh69y31pdk";
    libPath = "lib.rs";
    build = "build.rs";
    dependencies = mapFeatures features ([
      (crates."bitflags"."${deps."selectors"."0.21.0"."bitflags"}" deps)
      (crates."cssparser"."${deps."selectors"."0.21.0"."cssparser"}" deps)
      (crates."fxhash"."${deps."selectors"."0.21.0"."fxhash"}" deps)
      (crates."log"."${deps."selectors"."0.21.0"."log"}" deps)
      (crates."matches"."${deps."selectors"."0.21.0"."matches"}" deps)
      (crates."phf"."${deps."selectors"."0.21.0"."phf"}" deps)
      (crates."precomputed_hash"."${deps."selectors"."0.21.0"."precomputed_hash"}" deps)
      (crates."servo_arc"."${deps."selectors"."0.21.0"."servo_arc"}" deps)
      (crates."smallvec"."${deps."selectors"."0.21.0"."smallvec"}" deps)
      (crates."thin_slice"."${deps."selectors"."0.21.0"."thin_slice"}" deps)
    ]);

    buildDependencies = mapFeatures features ([
      (crates."phf_codegen"."${deps."selectors"."0.21.0"."phf_codegen"}" deps)
    ]);
    features = mkFeatures (features."selectors"."0.21.0" or {});
  };
  features_.selectors."0.21.0" = deps: f: updateFeatures f (rec {
    bitflags."${deps.selectors."0.21.0".bitflags}".default = true;
    cssparser."${deps.selectors."0.21.0".cssparser}".default = true;
    fxhash."${deps.selectors."0.21.0".fxhash}".default = true;
    log."${deps.selectors."0.21.0".log}".default = true;
    matches."${deps.selectors."0.21.0".matches}".default = true;
    phf."${deps.selectors."0.21.0".phf}".default = true;
    phf_codegen."${deps.selectors."0.21.0".phf_codegen}".default = true;
    precomputed_hash."${deps.selectors."0.21.0".precomputed_hash}".default = true;
    selectors."0.21.0".default = (f.selectors."0.21.0".default or true);
    servo_arc."${deps.selectors."0.21.0".servo_arc}".default = true;
    smallvec."${deps.selectors."0.21.0".smallvec}".default = true;
    thin_slice."${deps.selectors."0.21.0".thin_slice}".default = true;
  }) [
    (features_.bitflags."${deps."selectors"."0.21.0"."bitflags"}" deps)
    (features_.cssparser."${deps."selectors"."0.21.0"."cssparser"}" deps)
    (features_.fxhash."${deps."selectors"."0.21.0"."fxhash"}" deps)
    (features_.log."${deps."selectors"."0.21.0"."log"}" deps)
    (features_.matches."${deps."selectors"."0.21.0"."matches"}" deps)
    (features_.phf."${deps."selectors"."0.21.0"."phf"}" deps)
    (features_.precomputed_hash."${deps."selectors"."0.21.0"."precomputed_hash"}" deps)
    (features_.servo_arc."${deps."selectors"."0.21.0"."servo_arc"}" deps)
    (features_.smallvec."${deps."selectors"."0.21.0"."smallvec"}" deps)
    (features_.thin_slice."${deps."selectors"."0.21.0"."thin_slice"}" deps)
    (features_.phf_codegen."${deps."selectors"."0.21.0"."phf_codegen"}" deps)
  ];


# end
# semver-0.9.0

  crates.semver."0.9.0" = deps: { features?(features_.semver."0.9.0" deps {}) }: buildRustCrate {
    crateName = "semver";
    version = "0.9.0";
    description = "Semantic version parsing and comparison.\n";
    authors = [ "Steve Klabnik <steve@steveklabnik.com>" "The Rust Project Developers" ];
    sha256 = "0azak2lb2wc36s3x15az886kck7rpnksrw14lalm157rg9sc9z63";
    dependencies = mapFeatures features ([
      (crates."semver_parser"."${deps."semver"."0.9.0"."semver_parser"}" deps)
    ]);
    features = mkFeatures (features."semver"."0.9.0" or {});
  };
  features_.semver."0.9.0" = deps: f: updateFeatures f (rec {
    semver = fold recursiveUpdate {} [
      { "0.9.0"."serde" =
        (f.semver."0.9.0"."serde" or false) ||
        (f.semver."0.9.0".ci or false) ||
        (semver."0.9.0"."ci" or false); }
      { "0.9.0".default = (f.semver."0.9.0".default or true); }
    ];
    semver_parser."${deps.semver."0.9.0".semver_parser}".default = true;
  }) [
    (features_.semver_parser."${deps."semver"."0.9.0"."semver_parser"}" deps)
  ];


# end
# semver-parser-0.7.0

  crates.semver_parser."0.7.0" = deps: { features?(features_.semver_parser."0.7.0" deps {}) }: buildRustCrate {
    crateName = "semver-parser";
    version = "0.7.0";
    description = "Parsing of the semver spec.\n";
    authors = [ "Steve Klabnik <steve@steveklabnik.com>" ];
    sha256 = "1da66c8413yakx0y15k8c055yna5lyb6fr0fw9318kdwkrk5k12h";
  };
  features_.semver_parser."0.7.0" = deps: f: updateFeatures f (rec {
    semver_parser."0.7.0".default = (f.semver_parser."0.7.0".default or true);
  }) [];


# end
# serde-1.0.101

  crates.serde."1.0.101" = deps: { features?(features_.serde."1.0.101" deps {}) }: buildRustCrate {
    crateName = "serde";
    version = "1.0.101";
    description = "A generic serialization/deserialization framework";
    authors = [ "Erick Tryzelaar <erick.tryzelaar@gmail.com>" "David Tolnay <dtolnay@gmail.com>" ];
    sha256 = "0sacv3njx99yr8gxsl80cy1h98b9vd1pv6aa8ncbnk0pys8r82vn";
    build = "build.rs";
    dependencies = mapFeatures features ([
    ]
      ++ (if features.serde."1.0.101".serde_derive or false then [ (crates.serde_derive."${deps."serde"."1.0.101".serde_derive}" deps) ] else []));
    features = mkFeatures (features."serde"."1.0.101" or {});
  };
  features_.serde."1.0.101" = deps: f: updateFeatures f (rec {
    serde = fold recursiveUpdate {} [
      { "1.0.101"."serde_derive" =
        (f.serde."1.0.101"."serde_derive" or false) ||
        (f.serde."1.0.101".derive or false) ||
        (serde."1.0.101"."derive" or false); }
      { "1.0.101"."std" =
        (f.serde."1.0.101"."std" or false) ||
        (f.serde."1.0.101".default or false) ||
        (serde."1.0.101"."default" or false); }
      { "1.0.101".default = (f.serde."1.0.101".default or true); }
    ];
    serde_derive."${deps.serde."1.0.101".serde_derive}".default = true;
  }) [
    (features_.serde_derive."${deps."serde"."1.0.101"."serde_derive"}" deps)
  ];


# end
# serde_derive-1.0.101

  crates.serde_derive."1.0.101" = deps: { features?(features_.serde_derive."1.0.101" deps {}) }: buildRustCrate {
    crateName = "serde_derive";
    version = "1.0.101";
    description = "Macros 1.1 implementation of #[derive(Serialize, Deserialize)]";
    authors = [ "Erick Tryzelaar <erick.tryzelaar@gmail.com>" "David Tolnay <dtolnay@gmail.com>" ];
    sha256 = "093x99qff1ihjmy32fp1gxp66qh0nni349j20y3w0h33wqk19dr0";
    procMacro = true;
    dependencies = mapFeatures features ([
      (crates."proc_macro2"."${deps."serde_derive"."1.0.101"."proc_macro2"}" deps)
      (crates."quote"."${deps."serde_derive"."1.0.101"."quote"}" deps)
      (crates."syn"."${deps."serde_derive"."1.0.101"."syn"}" deps)
    ]);
    features = mkFeatures (features."serde_derive"."1.0.101" or {});
  };
  features_.serde_derive."1.0.101" = deps: f: updateFeatures f (rec {
    proc_macro2."${deps.serde_derive."1.0.101".proc_macro2}".default = true;
    quote."${deps.serde_derive."1.0.101".quote}".default = true;
    serde_derive."1.0.101".default = (f.serde_derive."1.0.101".default or true);
    syn = fold recursiveUpdate {} [
      { "${deps.serde_derive."1.0.101".syn}"."visit" = true; }
      { "${deps.serde_derive."1.0.101".syn}".default = true; }
    ];
  }) [
    (features_.proc_macro2."${deps."serde_derive"."1.0.101"."proc_macro2"}" deps)
    (features_.quote."${deps."serde_derive"."1.0.101"."quote"}" deps)
    (features_.syn."${deps."serde_derive"."1.0.101"."syn"}" deps)
  ];


# end
# serde_json-1.0.40

  crates.serde_json."1.0.40" = deps: { features?(features_.serde_json."1.0.40" deps {}) }: buildRustCrate {
    crateName = "serde_json";
    version = "1.0.40";
    description = "A JSON serialization file format";
    authors = [ "Erick Tryzelaar <erick.tryzelaar@gmail.com>" "David Tolnay <dtolnay@gmail.com>" ];
    sha256 = "1wf8lkisjvyg4ghp2fwm3ysymjy66l030l8d7p6033wiayfzpyh3";
    dependencies = mapFeatures features ([
      (crates."itoa"."${deps."serde_json"."1.0.40"."itoa"}" deps)
      (crates."ryu"."${deps."serde_json"."1.0.40"."ryu"}" deps)
      (crates."serde"."${deps."serde_json"."1.0.40"."serde"}" deps)
    ]);
    features = mkFeatures (features."serde_json"."1.0.40" or {});
  };
  features_.serde_json."1.0.40" = deps: f: updateFeatures f (rec {
    itoa."${deps.serde_json."1.0.40".itoa}".default = true;
    ryu."${deps.serde_json."1.0.40".ryu}".default = true;
    serde."${deps.serde_json."1.0.40".serde}".default = true;
    serde_json = fold recursiveUpdate {} [
      { "1.0.40"."indexmap" =
        (f.serde_json."1.0.40"."indexmap" or false) ||
        (f.serde_json."1.0.40".preserve_order or false) ||
        (serde_json."1.0.40"."preserve_order" or false); }
      { "1.0.40".default = (f.serde_json."1.0.40".default or true); }
    ];
  }) [
    (features_.itoa."${deps."serde_json"."1.0.40"."itoa"}" deps)
    (features_.ryu."${deps."serde_json"."1.0.40"."ryu"}" deps)
    (features_.serde."${deps."serde_json"."1.0.40"."serde"}" deps)
  ];


# end
# serde_regex-0.4.0

  crates.serde_regex."0.4.0" = deps: { features?(features_.serde_regex."0.4.0" deps {}) }: buildRustCrate {
    crateName = "serde_regex";
    version = "0.4.0";
    description = "    A serde wrapper that (de)serializes regex as strings\n";
    authors = [ "paul@colomiets.name" ];
    edition = "2018";
    sha256 = "117phyvzjsrybrshb2hwzdjjndv5zskzz5dxxj208zkszq0gh90r";
    dependencies = mapFeatures features ([
      (crates."regex"."${deps."serde_regex"."0.4.0"."regex"}" deps)
      (crates."serde"."${deps."serde_regex"."0.4.0"."serde"}" deps)
    ]);
  };
  features_.serde_regex."0.4.0" = deps: f: updateFeatures f (rec {
    regex."${deps.serde_regex."0.4.0".regex}".default = true;
    serde."${deps.serde_regex."0.4.0".serde}".default = true;
    serde_regex."0.4.0".default = (f.serde_regex."0.4.0".default or true);
  }) [
    (features_.regex."${deps."serde_regex"."0.4.0"."regex"}" deps)
    (features_.serde."${deps."serde_regex"."0.4.0"."serde"}" deps)
  ];


# end
# serde_urlencoded-0.5.5

  crates.serde_urlencoded."0.5.5" = deps: { features?(features_.serde_urlencoded."0.5.5" deps {}) }: buildRustCrate {
    crateName = "serde_urlencoded";
    version = "0.5.5";
    description = "`x-www-form-urlencoded` meets Serde";
    authors = [ "Anthony Ramine <n.oxyde@gmail.com>" ];
    sha256 = "1rf49i9w1p1yhr9fr5xsq6mi23i9ggj7132qwrfsaiimfvs6y7i0";
    dependencies = mapFeatures features ([
      (crates."dtoa"."${deps."serde_urlencoded"."0.5.5"."dtoa"}" deps)
      (crates."itoa"."${deps."serde_urlencoded"."0.5.5"."itoa"}" deps)
      (crates."serde"."${deps."serde_urlencoded"."0.5.5"."serde"}" deps)
      (crates."url"."${deps."serde_urlencoded"."0.5.5"."url"}" deps)
    ]);
  };
  features_.serde_urlencoded."0.5.5" = deps: f: updateFeatures f (rec {
    dtoa."${deps.serde_urlencoded."0.5.5".dtoa}".default = true;
    itoa."${deps.serde_urlencoded."0.5.5".itoa}".default = true;
    serde."${deps.serde_urlencoded."0.5.5".serde}".default = true;
    serde_urlencoded."0.5.5".default = (f.serde_urlencoded."0.5.5".default or true);
    url."${deps.serde_urlencoded."0.5.5".url}".default = true;
  }) [
    (features_.dtoa."${deps."serde_urlencoded"."0.5.5"."dtoa"}" deps)
    (features_.itoa."${deps."serde_urlencoded"."0.5.5"."itoa"}" deps)
    (features_.serde."${deps."serde_urlencoded"."0.5.5"."serde"}" deps)
    (features_.url."${deps."serde_urlencoded"."0.5.5"."url"}" deps)
  ];


# end
# servo_arc-0.1.1

  crates.servo_arc."0.1.1" = deps: { features?(features_.servo_arc."0.1.1" deps {}) }: buildRustCrate {
    crateName = "servo_arc";
    version = "0.1.1";
    description = "A fork of std::sync::Arc with some extra functionality and without weak references";
    authors = [ "The Servo Project Developers" ];
    sha256 = "0c01b1fpdbpaij4k3h1jhlr01bsmjm6p6ls8qbrnid1rk5svs5dq";
    libPath = "lib.rs";
    dependencies = mapFeatures features ([
      (crates."nodrop"."${deps."servo_arc"."0.1.1"."nodrop"}" deps)
      (crates."stable_deref_trait"."${deps."servo_arc"."0.1.1"."stable_deref_trait"}" deps)
    ]);
    features = mkFeatures (features."servo_arc"."0.1.1" or {});
  };
  features_.servo_arc."0.1.1" = deps: f: updateFeatures f (rec {
    nodrop."${deps.servo_arc."0.1.1".nodrop}".default = true;
    servo_arc = fold recursiveUpdate {} [
      { "0.1.1"."serde" =
        (f.servo_arc."0.1.1"."serde" or false) ||
        (f.servo_arc."0.1.1".servo or false) ||
        (servo_arc."0.1.1"."servo" or false); }
      { "0.1.1".default = (f.servo_arc."0.1.1".default or true); }
    ];
    stable_deref_trait."${deps.servo_arc."0.1.1".stable_deref_trait}".default = true;
  }) [
    (features_.nodrop."${deps."servo_arc"."0.1.1"."nodrop"}" deps)
    (features_.stable_deref_trait."${deps."servo_arc"."0.1.1"."stable_deref_trait"}" deps)
  ];


# end
# siphasher-0.2.3

  crates.siphasher."0.2.3" = deps: { features?(features_.siphasher."0.2.3" deps {}) }: buildRustCrate {
    crateName = "siphasher";
    version = "0.2.3";
    description = "SipHash functions from rust-core < 1.13";
    authors = [ "Frank Denis <github@pureftpd.org>" ];
    sha256 = "1ganj1grxqnkvv4ds3vby039bm999jrr58nfq2x3kjhzkw2bnqkw";
  };
  features_.siphasher."0.2.3" = deps: f: updateFeatures f (rec {
    siphasher."0.2.3".default = (f.siphasher."0.2.3".default or true);
  }) [];


# end
# slab-0.4.2

  crates.slab."0.4.2" = deps: { features?(features_.slab."0.4.2" deps {}) }: buildRustCrate {
    crateName = "slab";
    version = "0.4.2";
    description = "Pre-allocated storage for a uniform data type";
    authors = [ "Carl Lerche <me@carllerche.com>" ];
    sha256 = "0h1l2z7qy6207kv0v3iigdf2xfk9yrhbwj1svlxk6wxjmdxvgdl7";
  };
  features_.slab."0.4.2" = deps: f: updateFeatures f (rec {
    slab."0.4.2".default = (f.slab."0.4.2".default or true);
  }) [];


# end
# smallvec-0.6.10

  crates.smallvec."0.6.10" = deps: { features?(features_.smallvec."0.6.10" deps {}) }: buildRustCrate {
    crateName = "smallvec";
    version = "0.6.10";
    description = "'Small vector' optimization: store up to a small number of items on the stack";
    authors = [ "Simon Sapin <simon.sapin@exyr.org>" ];
    sha256 = "01w7xd79q0bwn683gk4ryw50ad1zzxkny10f7gkbaaj1ax6f4q4h";
    libPath = "lib.rs";
    dependencies = mapFeatures features ([
]);
    features = mkFeatures (features."smallvec"."0.6.10" or {});
  };
  features_.smallvec."0.6.10" = deps: f: updateFeatures f (rec {
    smallvec = fold recursiveUpdate {} [
      { "0.6.10"."std" =
        (f.smallvec."0.6.10"."std" or false) ||
        (f.smallvec."0.6.10".default or false) ||
        (smallvec."0.6.10"."default" or false); }
      { "0.6.10".default = (f.smallvec."0.6.10".default or true); }
    ];
  }) [];


# end
# stable_deref_trait-1.1.1

  crates.stable_deref_trait."1.1.1" = deps: { features?(features_.stable_deref_trait."1.1.1" deps {}) }: buildRustCrate {
    crateName = "stable_deref_trait";
    version = "1.1.1";
    description = "An unsafe marker trait for types like Box and Rc that dereference to a stable address even when moved, and hence can be used with libraries such as owning_ref and rental.\n";
    authors = [ "Robert Grosse <n210241048576@gmail.com>" ];
    sha256 = "1xy9slzslrzr31nlnw52sl1d820b09y61b7f13lqgsn8n7y0l4g8";
    features = mkFeatures (features."stable_deref_trait"."1.1.1" or {});
  };
  features_.stable_deref_trait."1.1.1" = deps: f: updateFeatures f (rec {
    stable_deref_trait = fold recursiveUpdate {} [
      { "1.1.1"."std" =
        (f.stable_deref_trait."1.1.1"."std" or false) ||
        (f.stable_deref_trait."1.1.1".default or false) ||
        (stable_deref_trait."1.1.1"."default" or false); }
      { "1.1.1".default = (f.stable_deref_trait."1.1.1".default or true); }
    ];
  }) [];


# end
# string-0.2.1

  crates.string."0.2.1" = deps: { features?(features_.string."0.2.1" deps {}) }: buildRustCrate {
    crateName = "string";
    version = "0.2.1";
    description = "A UTF-8 encoded string with configurable byte storage.";
    authors = [ "Carl Lerche <me@carllerche.com>" ];
    sha256 = "066vpc33qik0f8hpa1841hdzwcwj6ai3vdwsd34k1s2w9p3n7jqk";
    dependencies = mapFeatures features ([
    ]
      ++ (if features.string."0.2.1".bytes or false then [ (crates.bytes."${deps."string"."0.2.1".bytes}" deps) ] else []));
    features = mkFeatures (features."string"."0.2.1" or {});
  };
  features_.string."0.2.1" = deps: f: updateFeatures f (rec {
    bytes."${deps.string."0.2.1".bytes}".default = true;
    string = fold recursiveUpdate {} [
      { "0.2.1"."bytes" =
        (f.string."0.2.1"."bytes" or false) ||
        (f.string."0.2.1".default or false) ||
        (string."0.2.1"."default" or false); }
      { "0.2.1".default = (f.string."0.2.1".default or true); }
    ];
  }) [
    (features_.bytes."${deps."string"."0.2.1"."bytes"}" deps)
  ];


# end
# string_cache-0.7.3

  crates.string_cache."0.7.3" = deps: { features?(features_.string_cache."0.7.3" deps {}) }: buildRustCrate {
    crateName = "string_cache";
    version = "0.7.3";
    description = "A string interning library for Rust, developed as part of the Servo project.";
    authors = [ "The Servo Project Developers" ];
    sha256 = "1z2995v9m7cbz84b8bwpz25xgskq1a7kzsv467zn6fm5gdj8jzh0";
    build = "build.rs";
    dependencies = mapFeatures features ([
      (crates."lazy_static"."${deps."string_cache"."0.7.3"."lazy_static"}" deps)
      (crates."new_debug_unreachable"."${deps."string_cache"."0.7.3"."new_debug_unreachable"}" deps)
      (crates."phf_shared"."${deps."string_cache"."0.7.3"."phf_shared"}" deps)
      (crates."precomputed_hash"."${deps."string_cache"."0.7.3"."precomputed_hash"}" deps)
      (crates."serde"."${deps."string_cache"."0.7.3"."serde"}" deps)
      (crates."string_cache_shared"."${deps."string_cache"."0.7.3"."string_cache_shared"}" deps)
    ]);

    buildDependencies = mapFeatures features ([
      (crates."string_cache_codegen"."${deps."string_cache"."0.7.3"."string_cache_codegen"}" deps)
    ]);
    features = mkFeatures (features."string_cache"."0.7.3" or {});
  };
  features_.string_cache."0.7.3" = deps: f: updateFeatures f (rec {
    lazy_static."${deps.string_cache."0.7.3".lazy_static}".default = true;
    new_debug_unreachable."${deps.string_cache."0.7.3".new_debug_unreachable}".default = true;
    phf_shared."${deps.string_cache."0.7.3".phf_shared}".default = true;
    precomputed_hash."${deps.string_cache."0.7.3".precomputed_hash}".default = true;
    serde."${deps.string_cache."0.7.3".serde}".default = true;
    string_cache."0.7.3".default = (f.string_cache."0.7.3".default or true);
    string_cache_codegen."${deps.string_cache."0.7.3".string_cache_codegen}".default = true;
    string_cache_shared."${deps.string_cache."0.7.3".string_cache_shared}".default = true;
  }) [
    (features_.lazy_static."${deps."string_cache"."0.7.3"."lazy_static"}" deps)
    (features_.new_debug_unreachable."${deps."string_cache"."0.7.3"."new_debug_unreachable"}" deps)
    (features_.phf_shared."${deps."string_cache"."0.7.3"."phf_shared"}" deps)
    (features_.precomputed_hash."${deps."string_cache"."0.7.3"."precomputed_hash"}" deps)
    (features_.serde."${deps."string_cache"."0.7.3"."serde"}" deps)
    (features_.string_cache_shared."${deps."string_cache"."0.7.3"."string_cache_shared"}" deps)
    (features_.string_cache_codegen."${deps."string_cache"."0.7.3"."string_cache_codegen"}" deps)
  ];


# end
# string_cache_codegen-0.4.4

  crates.string_cache_codegen."0.4.4" = deps: { features?(features_.string_cache_codegen."0.4.4" deps {}) }: buildRustCrate {
    crateName = "string_cache_codegen";
    version = "0.4.4";
    description = "A codegen library for string-cache, developed as part of the Servo project.";
    authors = [ "The Servo Project Developers" ];
    sha256 = "0w7q385j23hdjiiqlqnzl763cbcl75sz2jinv4sbdfmrksrnwv14";
    libPath = "lib.rs";
    dependencies = mapFeatures features ([
      (crates."phf_generator"."${deps."string_cache_codegen"."0.4.4"."phf_generator"}" deps)
      (crates."phf_shared"."${deps."string_cache_codegen"."0.4.4"."phf_shared"}" deps)
      (crates."proc_macro2"."${deps."string_cache_codegen"."0.4.4"."proc_macro2"}" deps)
      (crates."quote"."${deps."string_cache_codegen"."0.4.4"."quote"}" deps)
      (crates."string_cache_shared"."${deps."string_cache_codegen"."0.4.4"."string_cache_shared"}" deps)
    ]);
  };
  features_.string_cache_codegen."0.4.4" = deps: f: updateFeatures f (rec {
    phf_generator."${deps.string_cache_codegen."0.4.4".phf_generator}".default = true;
    phf_shared."${deps.string_cache_codegen."0.4.4".phf_shared}".default = true;
    proc_macro2."${deps.string_cache_codegen."0.4.4".proc_macro2}".default = true;
    quote."${deps.string_cache_codegen."0.4.4".quote}".default = true;
    string_cache_codegen."0.4.4".default = (f.string_cache_codegen."0.4.4".default or true);
    string_cache_shared."${deps.string_cache_codegen."0.4.4".string_cache_shared}".default = true;
  }) [
    (features_.phf_generator."${deps."string_cache_codegen"."0.4.4"."phf_generator"}" deps)
    (features_.phf_shared."${deps."string_cache_codegen"."0.4.4"."phf_shared"}" deps)
    (features_.proc_macro2."${deps."string_cache_codegen"."0.4.4"."proc_macro2"}" deps)
    (features_.quote."${deps."string_cache_codegen"."0.4.4"."quote"}" deps)
    (features_.string_cache_shared."${deps."string_cache_codegen"."0.4.4"."string_cache_shared"}" deps)
  ];


# end
# string_cache_shared-0.3.0

  crates.string_cache_shared."0.3.0" = deps: { features?(features_.string_cache_shared."0.3.0" deps {}) }: buildRustCrate {
    crateName = "string_cache_shared";
    version = "0.3.0";
    description = "Code share between string_cache and string_cache_codegen.";
    authors = [ "The Servo Project Developers" ];
    sha256 = "0yc59f5npg4ip56aha03yzc7nxgl7c31hv6kq7zrx7rvs3h1cb8j";
    libPath = "lib.rs";
  };
  features_.string_cache_shared."0.3.0" = deps: f: updateFeatures f (rec {
    string_cache_shared."0.3.0".default = (f.string_cache_shared."0.3.0".default or true);
  }) [];


# end
# strsim-0.8.0

  crates.strsim."0.8.0" = deps: { features?(features_.strsim."0.8.0" deps {}) }: buildRustCrate {
    crateName = "strsim";
    version = "0.8.0";
    description = "Implementations of string similarity metrics.\nIncludes Hamming, Levenshtein, OSA, Damerau-Levenshtein, Jaro, and Jaro-Winkler.\n";
    authors = [ "Danny Guo <dannyguo91@gmail.com>" ];
    sha256 = "0d3jsdz22wgjyxdakqnvdgmwjdvkximz50d9zfk4qlalw635qcvy";
  };
  features_.strsim."0.8.0" = deps: f: updateFeatures f (rec {
    strsim."0.8.0".default = (f.strsim."0.8.0".default or true);
  }) [];


# end
# syn-0.15.44

  crates.syn."0.15.44" = deps: { features?(features_.syn."0.15.44" deps {}) }: buildRustCrate {
    crateName = "syn";
    version = "0.15.44";
    description = "Parser for Rust source code";
    authors = [ "David Tolnay <dtolnay@gmail.com>" ];
    sha256 = "09v11h141grmsnamd5j14mn8vpnfng6p60kdmsm8akz9m0qn7s1n";
    dependencies = mapFeatures features ([
      (crates."proc_macro2"."${deps."syn"."0.15.44"."proc_macro2"}" deps)
      (crates."unicode_xid"."${deps."syn"."0.15.44"."unicode_xid"}" deps)
    ]
      ++ (if features.syn."0.15.44".quote or false then [ (crates.quote."${deps."syn"."0.15.44".quote}" deps) ] else []));
    features = mkFeatures (features."syn"."0.15.44" or {});
  };
  features_.syn."0.15.44" = deps: f: updateFeatures f (rec {
    proc_macro2 = fold recursiveUpdate {} [
      { "${deps.syn."0.15.44".proc_macro2}"."proc-macro" =
        (f.proc_macro2."${deps.syn."0.15.44".proc_macro2}"."proc-macro" or false) ||
        (syn."0.15.44"."proc-macro" or false) ||
        (f."syn"."0.15.44"."proc-macro" or false); }
      { "${deps.syn."0.15.44".proc_macro2}".default = (f.proc_macro2."${deps.syn."0.15.44".proc_macro2}".default or false); }
    ];
    quote = fold recursiveUpdate {} [
      { "${deps.syn."0.15.44".quote}"."proc-macro" =
        (f.quote."${deps.syn."0.15.44".quote}"."proc-macro" or false) ||
        (syn."0.15.44"."proc-macro" or false) ||
        (f."syn"."0.15.44"."proc-macro" or false); }
      { "${deps.syn."0.15.44".quote}".default = (f.quote."${deps.syn."0.15.44".quote}".default or false); }
    ];
    syn = fold recursiveUpdate {} [
      { "0.15.44"."clone-impls" =
        (f.syn."0.15.44"."clone-impls" or false) ||
        (f.syn."0.15.44".default or false) ||
        (syn."0.15.44"."default" or false); }
      { "0.15.44"."derive" =
        (f.syn."0.15.44"."derive" or false) ||
        (f.syn."0.15.44".default or false) ||
        (syn."0.15.44"."default" or false); }
      { "0.15.44"."parsing" =
        (f.syn."0.15.44"."parsing" or false) ||
        (f.syn."0.15.44".default or false) ||
        (syn."0.15.44"."default" or false); }
      { "0.15.44"."printing" =
        (f.syn."0.15.44"."printing" or false) ||
        (f.syn."0.15.44".default or false) ||
        (syn."0.15.44"."default" or false); }
      { "0.15.44"."proc-macro" =
        (f.syn."0.15.44"."proc-macro" or false) ||
        (f.syn."0.15.44".default or false) ||
        (syn."0.15.44"."default" or false); }
      { "0.15.44"."quote" =
        (f.syn."0.15.44"."quote" or false) ||
        (f.syn."0.15.44".printing or false) ||
        (syn."0.15.44"."printing" or false); }
      { "0.15.44".default = (f.syn."0.15.44".default or true); }
    ];
    unicode_xid."${deps.syn."0.15.44".unicode_xid}".default = true;
  }) [
    (features_.proc_macro2."${deps."syn"."0.15.44"."proc_macro2"}" deps)
    (features_.quote."${deps."syn"."0.15.44"."quote"}" deps)
    (features_.unicode_xid."${deps."syn"."0.15.44"."unicode_xid"}" deps)
  ];


# end
# syn-1.0.5

  crates.syn."1.0.5" = deps: { features?(features_.syn."1.0.5" deps {}) }: buildRustCrate {
    crateName = "syn";
    version = "1.0.5";
    description = "Parser for Rust source code";
    authors = [ "David Tolnay <dtolnay@gmail.com>" ];
    edition = "2018";
    sha256 = "08qbk425r8c4q4rrpq1q9wkd3v3bji8nlfaxj8v4l7lkpjkh0xgs";
    dependencies = mapFeatures features ([
      (crates."proc_macro2"."${deps."syn"."1.0.5"."proc_macro2"}" deps)
      (crates."unicode_xid"."${deps."syn"."1.0.5"."unicode_xid"}" deps)
    ]
      ++ (if features.syn."1.0.5".quote or false then [ (crates.quote."${deps."syn"."1.0.5".quote}" deps) ] else []));
    features = mkFeatures (features."syn"."1.0.5" or {});
  };
  features_.syn."1.0.5" = deps: f: updateFeatures f (rec {
    proc_macro2 = fold recursiveUpdate {} [
      { "${deps.syn."1.0.5".proc_macro2}"."proc-macro" =
        (f.proc_macro2."${deps.syn."1.0.5".proc_macro2}"."proc-macro" or false) ||
        (syn."1.0.5"."proc-macro" or false) ||
        (f."syn"."1.0.5"."proc-macro" or false); }
      { "${deps.syn."1.0.5".proc_macro2}".default = (f.proc_macro2."${deps.syn."1.0.5".proc_macro2}".default or false); }
    ];
    quote = fold recursiveUpdate {} [
      { "${deps.syn."1.0.5".quote}"."proc-macro" =
        (f.quote."${deps.syn."1.0.5".quote}"."proc-macro" or false) ||
        (syn."1.0.5"."proc-macro" or false) ||
        (f."syn"."1.0.5"."proc-macro" or false); }
      { "${deps.syn."1.0.5".quote}".default = (f.quote."${deps.syn."1.0.5".quote}".default or false); }
    ];
    syn = fold recursiveUpdate {} [
      { "1.0.5"."clone-impls" =
        (f.syn."1.0.5"."clone-impls" or false) ||
        (f.syn."1.0.5".default or false) ||
        (syn."1.0.5"."default" or false); }
      { "1.0.5"."derive" =
        (f.syn."1.0.5"."derive" or false) ||
        (f.syn."1.0.5".default or false) ||
        (syn."1.0.5"."default" or false); }
      { "1.0.5"."parsing" =
        (f.syn."1.0.5"."parsing" or false) ||
        (f.syn."1.0.5".default or false) ||
        (syn."1.0.5"."default" or false); }
      { "1.0.5"."printing" =
        (f.syn."1.0.5"."printing" or false) ||
        (f.syn."1.0.5".default or false) ||
        (syn."1.0.5"."default" or false); }
      { "1.0.5"."proc-macro" =
        (f.syn."1.0.5"."proc-macro" or false) ||
        (f.syn."1.0.5".default or false) ||
        (syn."1.0.5"."default" or false); }
      { "1.0.5"."quote" =
        (f.syn."1.0.5"."quote" or false) ||
        (f.syn."1.0.5".printing or false) ||
        (syn."1.0.5"."printing" or false); }
      { "1.0.5".default = (f.syn."1.0.5".default or true); }
    ];
    unicode_xid."${deps.syn."1.0.5".unicode_xid}".default = true;
  }) [
    (features_.proc_macro2."${deps."syn"."1.0.5"."proc_macro2"}" deps)
    (features_.quote."${deps."syn"."1.0.5"."quote"}" deps)
    (features_.unicode_xid."${deps."syn"."1.0.5"."unicode_xid"}" deps)
  ];


# end
# synstructure-0.10.2

  crates.synstructure."0.10.2" = deps: { features?(features_.synstructure."0.10.2" deps {}) }: buildRustCrate {
    crateName = "synstructure";
    version = "0.10.2";
    description = "Helper methods and macros for custom derives";
    authors = [ "Nika Layzell <nika@thelayzells.com>" ];
    sha256 = "0bp29grjsim99xm1l6h38mbl98gnk47lf82rawlmws5zn4asdpj4";
    dependencies = mapFeatures features ([
      (crates."proc_macro2"."${deps."synstructure"."0.10.2"."proc_macro2"}" deps)
      (crates."quote"."${deps."synstructure"."0.10.2"."quote"}" deps)
      (crates."syn"."${deps."synstructure"."0.10.2"."syn"}" deps)
      (crates."unicode_xid"."${deps."synstructure"."0.10.2"."unicode_xid"}" deps)
    ]);
    features = mkFeatures (features."synstructure"."0.10.2" or {});
  };
  features_.synstructure."0.10.2" = deps: f: updateFeatures f (rec {
    proc_macro2."${deps.synstructure."0.10.2".proc_macro2}".default = true;
    quote."${deps.synstructure."0.10.2".quote}".default = true;
    syn = fold recursiveUpdate {} [
      { "${deps.synstructure."0.10.2".syn}"."extra-traits" = true; }
      { "${deps.synstructure."0.10.2".syn}"."visit" = true; }
      { "${deps.synstructure."0.10.2".syn}".default = true; }
    ];
    synstructure."0.10.2".default = (f.synstructure."0.10.2".default or true);
    unicode_xid."${deps.synstructure."0.10.2".unicode_xid}".default = true;
  }) [
    (features_.proc_macro2."${deps."synstructure"."0.10.2"."proc_macro2"}" deps)
    (features_.quote."${deps."synstructure"."0.10.2"."quote"}" deps)
    (features_.syn."${deps."synstructure"."0.10.2"."syn"}" deps)
    (features_.unicode_xid."${deps."synstructure"."0.10.2"."unicode_xid"}" deps)
  ];


# end
# tempfile-3.1.0

  crates.tempfile."3.1.0" = deps: { features?(features_.tempfile."3.1.0" deps {}) }: buildRustCrate {
    crateName = "tempfile";
    version = "3.1.0";
    description = "A library for managing temporary files and directories.";
    authors = [ "Steven Allen <steven@stebalien.com>" "The Rust Project Developers" "Ashley Mannix <ashleymannix@live.com.au>" "Jason White <jasonaw0@gmail.com>" ];
    edition = "2018";
    sha256 = "1r7ykxw90p5hm1g46i8ia33j5iwl3q252kbb6b074qhdav3sqndk";
    dependencies = mapFeatures features ([
      (crates."cfg_if"."${deps."tempfile"."3.1.0"."cfg_if"}" deps)
      (crates."rand"."${deps."tempfile"."3.1.0"."rand"}" deps)
      (crates."remove_dir_all"."${deps."tempfile"."3.1.0"."remove_dir_all"}" deps)
    ])
      ++ (if kernel == "redox" then mapFeatures features ([
      (crates."redox_syscall"."${deps."tempfile"."3.1.0"."redox_syscall"}" deps)
    ]) else [])
      ++ (if (kernel == "linux" || kernel == "darwin") then mapFeatures features ([
      (crates."libc"."${deps."tempfile"."3.1.0"."libc"}" deps)
    ]) else [])
      ++ (if kernel == "windows" then mapFeatures features ([
      (crates."winapi"."${deps."tempfile"."3.1.0"."winapi"}" deps)
    ]) else []);
  };
  features_.tempfile."3.1.0" = deps: f: updateFeatures f (rec {
    cfg_if."${deps.tempfile."3.1.0".cfg_if}".default = true;
    libc."${deps.tempfile."3.1.0".libc}".default = true;
    rand."${deps.tempfile."3.1.0".rand}".default = true;
    redox_syscall."${deps.tempfile."3.1.0".redox_syscall}".default = true;
    remove_dir_all."${deps.tempfile."3.1.0".remove_dir_all}".default = true;
    tempfile."3.1.0".default = (f.tempfile."3.1.0".default or true);
    winapi = fold recursiveUpdate {} [
      { "${deps.tempfile."3.1.0".winapi}"."fileapi" = true; }
      { "${deps.tempfile."3.1.0".winapi}"."handleapi" = true; }
      { "${deps.tempfile."3.1.0".winapi}"."winbase" = true; }
      { "${deps.tempfile."3.1.0".winapi}".default = true; }
    ];
  }) [
    (features_.cfg_if."${deps."tempfile"."3.1.0"."cfg_if"}" deps)
    (features_.rand."${deps."tempfile"."3.1.0"."rand"}" deps)
    (features_.remove_dir_all."${deps."tempfile"."3.1.0"."remove_dir_all"}" deps)
    (features_.redox_syscall."${deps."tempfile"."3.1.0"."redox_syscall"}" deps)
    (features_.libc."${deps."tempfile"."3.1.0"."libc"}" deps)
    (features_.winapi."${deps."tempfile"."3.1.0"."winapi"}" deps)
  ];


# end
# tendril-0.4.1

  crates.tendril."0.4.1" = deps: { features?(features_.tendril."0.4.1" deps {}) }: buildRustCrate {
    crateName = "tendril";
    version = "0.4.1";
    description = "Compact buffer/string type for zero-copy parsing";
    authors = [ "Keegan McAllister <mcallister.keegan@gmail.com>" "Simon Sapin <simon.sapin@exyr.org>" "Chris Morgan <me@chrismorgan.info>" ];
    sha256 = "02k6iwlyqd3xvjvi50l6n5yspmcf4rkhs6b49h3a1d6kr4ydmydm";
    dependencies = mapFeatures features ([
      (crates."futf"."${deps."tendril"."0.4.1"."futf"}" deps)
      (crates."mac"."${deps."tendril"."0.4.1"."mac"}" deps)
      (crates."utf_8"."${deps."tendril"."0.4.1"."utf_8"}" deps)
    ]);
    features = mkFeatures (features."tendril"."0.4.1" or {});
  };
  features_.tendril."0.4.1" = deps: f: updateFeatures f (rec {
    futf."${deps.tendril."0.4.1".futf}".default = true;
    mac."${deps.tendril."0.4.1".mac}".default = true;
    tendril."0.4.1".default = (f.tendril."0.4.1".default or true);
    utf_8."${deps.tendril."0.4.1".utf_8}".default = true;
  }) [
    (features_.futf."${deps."tendril"."0.4.1"."futf"}" deps)
    (features_.mac."${deps."tendril"."0.4.1"."mac"}" deps)
    (features_.utf_8."${deps."tendril"."0.4.1"."utf_8"}" deps)
  ];


# end
# textwrap-0.11.0

  crates.textwrap."0.11.0" = deps: { features?(features_.textwrap."0.11.0" deps {}) }: buildRustCrate {
    crateName = "textwrap";
    version = "0.11.0";
    description = "Textwrap is a small library for word wrapping, indenting, and\ndedenting strings.\n\nYou can use it to format strings (such as help and error messages) for\ndisplay in commandline applications. It is designed to be efficient\nand handle Unicode characters correctly.\n";
    authors = [ "Martin Geisler <martin@geisler.net>" ];
    sha256 = "0s25qh49n7kjayrdj4q3v0jk0jc6vy88rdw0bvgfxqlscpqpxi7d";
    dependencies = mapFeatures features ([
      (crates."unicode_width"."${deps."textwrap"."0.11.0"."unicode_width"}" deps)
    ]);
  };
  features_.textwrap."0.11.0" = deps: f: updateFeatures f (rec {
    textwrap."0.11.0".default = (f.textwrap."0.11.0".default or true);
    unicode_width."${deps.textwrap."0.11.0".unicode_width}".default = true;
  }) [
    (features_.unicode_width."${deps."textwrap"."0.11.0"."unicode_width"}" deps)
  ];


# end
# thin-slice-0.1.1

  crates.thin_slice."0.1.1" = deps: { features?(features_.thin_slice."0.1.1" deps {}) }: buildRustCrate {
    crateName = "thin-slice";
    version = "0.1.1";
    description = "An owned slice that packs the slice storage into a single word when possible";
    authors = [ "Cameron McCormack <cam@mcc.id.au>" ];
    sha256 = "0hs3qd4hsrwgr68xj5b0qdr5pib2g40p3cnn02ssqfj4nlc6wglc";
  };
  features_.thin_slice."0.1.1" = deps: f: updateFeatures f (rec {
    thin_slice."0.1.1".default = (f.thin_slice."0.1.1".default or true);
  }) [];


# end
# thread_local-0.3.6

  crates.thread_local."0.3.6" = deps: { features?(features_.thread_local."0.3.6" deps {}) }: buildRustCrate {
    crateName = "thread_local";
    version = "0.3.6";
    description = "Per-object thread-local storage";
    authors = [ "Amanieu d'Antras <amanieu@gmail.com>" ];
    sha256 = "02rksdwjmz2pw9bmgbb4c0bgkbq5z6nvg510sq1s6y2j1gam0c7i";
    dependencies = mapFeatures features ([
      (crates."lazy_static"."${deps."thread_local"."0.3.6"."lazy_static"}" deps)
    ]);
  };
  features_.thread_local."0.3.6" = deps: f: updateFeatures f (rec {
    lazy_static."${deps.thread_local."0.3.6".lazy_static}".default = true;
    thread_local."0.3.6".default = (f.thread_local."0.3.6".default or true);
  }) [
    (features_.lazy_static."${deps."thread_local"."0.3.6"."lazy_static"}" deps)
  ];


# end
# time-0.1.42

  crates.time."0.1.42" = deps: { features?(features_.time."0.1.42" deps {}) }: buildRustCrate {
    crateName = "time";
    version = "0.1.42";
    description = "Utilities for working with time-related functions in Rust.\n";
    authors = [ "The Rust Project Developers" ];
    sha256 = "1ny809kmdjwd4b478ipc33dz7q6nq7rxk766x8cnrg6zygcksmmx";
    dependencies = mapFeatures features ([
      (crates."libc"."${deps."time"."0.1.42"."libc"}" deps)
    ])
      ++ (if kernel == "redox" then mapFeatures features ([
      (crates."redox_syscall"."${deps."time"."0.1.42"."redox_syscall"}" deps)
    ]) else [])
      ++ (if kernel == "windows" then mapFeatures features ([
      (crates."winapi"."${deps."time"."0.1.42"."winapi"}" deps)
    ]) else []);
  };
  features_.time."0.1.42" = deps: f: updateFeatures f (rec {
    libc."${deps.time."0.1.42".libc}".default = true;
    redox_syscall."${deps.time."0.1.42".redox_syscall}".default = true;
    time."0.1.42".default = (f.time."0.1.42".default or true);
    winapi = fold recursiveUpdate {} [
      { "${deps.time."0.1.42".winapi}"."minwinbase" = true; }
      { "${deps.time."0.1.42".winapi}"."minwindef" = true; }
      { "${deps.time."0.1.42".winapi}"."ntdef" = true; }
      { "${deps.time."0.1.42".winapi}"."profileapi" = true; }
      { "${deps.time."0.1.42".winapi}"."std" = true; }
      { "${deps.time."0.1.42".winapi}"."sysinfoapi" = true; }
      { "${deps.time."0.1.42".winapi}"."timezoneapi" = true; }
      { "${deps.time."0.1.42".winapi}".default = true; }
    ];
  }) [
    (features_.libc."${deps."time"."0.1.42"."libc"}" deps)
    (features_.redox_syscall."${deps."time"."0.1.42"."redox_syscall"}" deps)
    (features_.winapi."${deps."time"."0.1.42"."winapi"}" deps)
  ];


# end
# tokio-0.1.22

  crates.tokio."0.1.22" = deps: { features?(features_.tokio."0.1.22" deps {}) }: buildRustCrate {
    crateName = "tokio";
    version = "0.1.22";
    description = "An event-driven, non-blocking I/O platform for writing asynchronous I/O\nbacked applications.\n";
    authors = [ "Carl Lerche <me@carllerche.com>" ];
    sha256 = "1nx8yg8fdwf5nm2ykfza24cx8xy5in6da5va5w76mv347r1irr0b";
    dependencies = mapFeatures features ([
      (crates."futures"."${deps."tokio"."0.1.22"."futures"}" deps)
    ]
      ++ (if features.tokio."0.1.22".bytes or false then [ (crates.bytes."${deps."tokio"."0.1.22".bytes}" deps) ] else [])
      ++ (if features.tokio."0.1.22".mio or false then [ (crates.mio."${deps."tokio"."0.1.22".mio}" deps) ] else [])
      ++ (if features.tokio."0.1.22".num_cpus or false then [ (crates.num_cpus."${deps."tokio"."0.1.22".num_cpus}" deps) ] else [])
      ++ (if features.tokio."0.1.22".tokio-current-thread or false then [ (crates.tokio_current_thread."${deps."tokio"."0.1.22".tokio_current_thread}" deps) ] else [])
      ++ (if features.tokio."0.1.22".tokio-executor or false then [ (crates.tokio_executor."${deps."tokio"."0.1.22".tokio_executor}" deps) ] else [])
      ++ (if features.tokio."0.1.22".tokio-io or false then [ (crates.tokio_io."${deps."tokio"."0.1.22".tokio_io}" deps) ] else [])
      ++ (if features.tokio."0.1.22".tokio-reactor or false then [ (crates.tokio_reactor."${deps."tokio"."0.1.22".tokio_reactor}" deps) ] else [])
      ++ (if features.tokio."0.1.22".tokio-tcp or false then [ (crates.tokio_tcp."${deps."tokio"."0.1.22".tokio_tcp}" deps) ] else [])
      ++ (if features.tokio."0.1.22".tokio-threadpool or false then [ (crates.tokio_threadpool."${deps."tokio"."0.1.22".tokio_threadpool}" deps) ] else [])
      ++ (if features.tokio."0.1.22".tokio-timer or false then [ (crates.tokio_timer."${deps."tokio"."0.1.22".tokio_timer}" deps) ] else []))
      ++ (if (kernel == "linux" || kernel == "darwin") then mapFeatures features ([
]) else []);
    features = mkFeatures (features."tokio"."0.1.22" or {});
  };
  features_.tokio."0.1.22" = deps: f: updateFeatures f (rec {
    bytes."${deps.tokio."0.1.22".bytes}".default = true;
    futures."${deps.tokio."0.1.22".futures}".default = true;
    mio."${deps.tokio."0.1.22".mio}".default = true;
    num_cpus."${deps.tokio."0.1.22".num_cpus}".default = true;
    tokio = fold recursiveUpdate {} [
      { "0.1.22"."bytes" =
        (f.tokio."0.1.22"."bytes" or false) ||
        (f.tokio."0.1.22".io or false) ||
        (tokio."0.1.22"."io" or false); }
      { "0.1.22"."codec" =
        (f.tokio."0.1.22"."codec" or false) ||
        (f.tokio."0.1.22".default or false) ||
        (tokio."0.1.22"."default" or false); }
      { "0.1.22"."fs" =
        (f.tokio."0.1.22"."fs" or false) ||
        (f.tokio."0.1.22".default or false) ||
        (tokio."0.1.22"."default" or false); }
      { "0.1.22"."io" =
        (f.tokio."0.1.22"."io" or false) ||
        (f.tokio."0.1.22".codec or false) ||
        (tokio."0.1.22"."codec" or false) ||
        (f.tokio."0.1.22".default or false) ||
        (tokio."0.1.22"."default" or false) ||
        (f.tokio."0.1.22".reactor or false) ||
        (tokio."0.1.22"."reactor" or false); }
      { "0.1.22"."mio" =
        (f.tokio."0.1.22"."mio" or false) ||
        (f.tokio."0.1.22".reactor or false) ||
        (tokio."0.1.22"."reactor" or false); }
      { "0.1.22"."num_cpus" =
        (f.tokio."0.1.22"."num_cpus" or false) ||
        (f.tokio."0.1.22".rt-full or false) ||
        (tokio."0.1.22"."rt-full" or false); }
      { "0.1.22"."reactor" =
        (f.tokio."0.1.22"."reactor" or false) ||
        (f.tokio."0.1.22".default or false) ||
        (tokio."0.1.22"."default" or false) ||
        (f.tokio."0.1.22".rt-full or false) ||
        (tokio."0.1.22"."rt-full" or false); }
      { "0.1.22"."rt-full" =
        (f.tokio."0.1.22"."rt-full" or false) ||
        (f.tokio."0.1.22".default or false) ||
        (tokio."0.1.22"."default" or false); }
      { "0.1.22"."sync" =
        (f.tokio."0.1.22"."sync" or false) ||
        (f.tokio."0.1.22".default or false) ||
        (tokio."0.1.22"."default" or false); }
      { "0.1.22"."tcp" =
        (f.tokio."0.1.22"."tcp" or false) ||
        (f.tokio."0.1.22".default or false) ||
        (tokio."0.1.22"."default" or false); }
      { "0.1.22"."timer" =
        (f.tokio."0.1.22"."timer" or false) ||
        (f.tokio."0.1.22".default or false) ||
        (tokio."0.1.22"."default" or false) ||
        (f.tokio."0.1.22".rt-full or false) ||
        (tokio."0.1.22"."rt-full" or false); }
      { "0.1.22"."tokio-codec" =
        (f.tokio."0.1.22"."tokio-codec" or false) ||
        (f.tokio."0.1.22".codec or false) ||
        (tokio."0.1.22"."codec" or false); }
      { "0.1.22"."tokio-current-thread" =
        (f.tokio."0.1.22"."tokio-current-thread" or false) ||
        (f.tokio."0.1.22".rt-full or false) ||
        (tokio."0.1.22"."rt-full" or false); }
      { "0.1.22"."tokio-executor" =
        (f.tokio."0.1.22"."tokio-executor" or false) ||
        (f.tokio."0.1.22".rt-full or false) ||
        (tokio."0.1.22"."rt-full" or false); }
      { "0.1.22"."tokio-fs" =
        (f.tokio."0.1.22"."tokio-fs" or false) ||
        (f.tokio."0.1.22".fs or false) ||
        (tokio."0.1.22"."fs" or false); }
      { "0.1.22"."tokio-io" =
        (f.tokio."0.1.22"."tokio-io" or false) ||
        (f.tokio."0.1.22".io or false) ||
        (tokio."0.1.22"."io" or false); }
      { "0.1.22"."tokio-reactor" =
        (f.tokio."0.1.22"."tokio-reactor" or false) ||
        (f.tokio."0.1.22".reactor or false) ||
        (tokio."0.1.22"."reactor" or false); }
      { "0.1.22"."tokio-sync" =
        (f.tokio."0.1.22"."tokio-sync" or false) ||
        (f.tokio."0.1.22".sync or false) ||
        (tokio."0.1.22"."sync" or false); }
      { "0.1.22"."tokio-tcp" =
        (f.tokio."0.1.22"."tokio-tcp" or false) ||
        (f.tokio."0.1.22".tcp or false) ||
        (tokio."0.1.22"."tcp" or false); }
      { "0.1.22"."tokio-threadpool" =
        (f.tokio."0.1.22"."tokio-threadpool" or false) ||
        (f.tokio."0.1.22".rt-full or false) ||
        (tokio."0.1.22"."rt-full" or false); }
      { "0.1.22"."tokio-timer" =
        (f.tokio."0.1.22"."tokio-timer" or false) ||
        (f.tokio."0.1.22".timer or false) ||
        (tokio."0.1.22"."timer" or false); }
      { "0.1.22"."tokio-udp" =
        (f.tokio."0.1.22"."tokio-udp" or false) ||
        (f.tokio."0.1.22".udp or false) ||
        (tokio."0.1.22"."udp" or false); }
      { "0.1.22"."tokio-uds" =
        (f.tokio."0.1.22"."tokio-uds" or false) ||
        (f.tokio."0.1.22".uds or false) ||
        (tokio."0.1.22"."uds" or false); }
      { "0.1.22"."tracing-core" =
        (f.tokio."0.1.22"."tracing-core" or false) ||
        (f.tokio."0.1.22".experimental-tracing or false) ||
        (tokio."0.1.22"."experimental-tracing" or false); }
      { "0.1.22"."udp" =
        (f.tokio."0.1.22"."udp" or false) ||
        (f.tokio."0.1.22".default or false) ||
        (tokio."0.1.22"."default" or false); }
      { "0.1.22"."uds" =
        (f.tokio."0.1.22"."uds" or false) ||
        (f.tokio."0.1.22".default or false) ||
        (tokio."0.1.22"."default" or false); }
      { "0.1.22".default = (f.tokio."0.1.22".default or true); }
    ];
    tokio_current_thread."${deps.tokio."0.1.22".tokio_current_thread}".default = true;
    tokio_executor."${deps.tokio."0.1.22".tokio_executor}".default = true;
    tokio_io."${deps.tokio."0.1.22".tokio_io}".default = true;
    tokio_reactor."${deps.tokio."0.1.22".tokio_reactor}".default = true;
    tokio_tcp."${deps.tokio."0.1.22".tokio_tcp}".default = true;
    tokio_threadpool."${deps.tokio."0.1.22".tokio_threadpool}".default = true;
    tokio_timer."${deps.tokio."0.1.22".tokio_timer}".default = true;
  }) [
    (features_.bytes."${deps."tokio"."0.1.22"."bytes"}" deps)
    (features_.futures."${deps."tokio"."0.1.22"."futures"}" deps)
    (features_.mio."${deps."tokio"."0.1.22"."mio"}" deps)
    (features_.num_cpus."${deps."tokio"."0.1.22"."num_cpus"}" deps)
    (features_.tokio_current_thread."${deps."tokio"."0.1.22"."tokio_current_thread"}" deps)
    (features_.tokio_executor."${deps."tokio"."0.1.22"."tokio_executor"}" deps)
    (features_.tokio_io."${deps."tokio"."0.1.22"."tokio_io"}" deps)
    (features_.tokio_reactor."${deps."tokio"."0.1.22"."tokio_reactor"}" deps)
    (features_.tokio_tcp."${deps."tokio"."0.1.22"."tokio_tcp"}" deps)
    (features_.tokio_threadpool."${deps."tokio"."0.1.22"."tokio_threadpool"}" deps)
    (features_.tokio_timer."${deps."tokio"."0.1.22"."tokio_timer"}" deps)
  ];


# end
# tokio-buf-0.1.1

  crates.tokio_buf."0.1.1" = deps: { features?(features_.tokio_buf."0.1.1" deps {}) }: buildRustCrate {
    crateName = "tokio-buf";
    version = "0.1.1";
    description = "Asynchronous stream of byte buffers\n";
    authors = [ "Carl Lerche <me@carllerche.com>" ];
    sha256 = "11qjcqvhsjwwy66njn2c3nzl0i89a9k06l08s0vz9cswwkjc2427";
    dependencies = mapFeatures features ([
      (crates."bytes"."${deps."tokio_buf"."0.1.1"."bytes"}" deps)
      (crates."futures"."${deps."tokio_buf"."0.1.1"."futures"}" deps)
    ]
      ++ (if features.tokio_buf."0.1.1".either or false then [ (crates.either."${deps."tokio_buf"."0.1.1".either}" deps) ] else []));
    features = mkFeatures (features."tokio_buf"."0.1.1" or {});
  };
  features_.tokio_buf."0.1.1" = deps: f: updateFeatures f (rec {
    bytes = fold recursiveUpdate {} [
      { "${deps.tokio_buf."0.1.1".bytes}"."either" =
        (f.bytes."${deps.tokio_buf."0.1.1".bytes}"."either" or false) ||
        (tokio_buf."0.1.1"."util" or false) ||
        (f."tokio_buf"."0.1.1"."util" or false); }
      { "${deps.tokio_buf."0.1.1".bytes}".default = true; }
    ];
    either."${deps.tokio_buf."0.1.1".either}".default = true;
    futures."${deps.tokio_buf."0.1.1".futures}".default = true;
    tokio_buf = fold recursiveUpdate {} [
      { "0.1.1"."either" =
        (f.tokio_buf."0.1.1"."either" or false) ||
        (f.tokio_buf."0.1.1".util or false) ||
        (tokio_buf."0.1.1"."util" or false); }
      { "0.1.1"."util" =
        (f.tokio_buf."0.1.1"."util" or false) ||
        (f.tokio_buf."0.1.1".default or false) ||
        (tokio_buf."0.1.1"."default" or false); }
      { "0.1.1".default = (f.tokio_buf."0.1.1".default or true); }
    ];
  }) [
    (features_.bytes."${deps."tokio_buf"."0.1.1"."bytes"}" deps)
    (features_.either."${deps."tokio_buf"."0.1.1"."either"}" deps)
    (features_.futures."${deps."tokio_buf"."0.1.1"."futures"}" deps)
  ];


# end
# tokio-current-thread-0.1.6

  crates.tokio_current_thread."0.1.6" = deps: { features?(features_.tokio_current_thread."0.1.6" deps {}) }: buildRustCrate {
    crateName = "tokio-current-thread";
    version = "0.1.6";
    description = "Single threaded executor which manage many tasks concurrently on the current thread.\n";
    authors = [ "Carl Lerche <me@carllerche.com>" ];
    sha256 = "07dm43svkrpifkcnv8f5w477cd9260pnkvnps39qkhkf5ixi8fzg";
    dependencies = mapFeatures features ([
      (crates."futures"."${deps."tokio_current_thread"."0.1.6"."futures"}" deps)
      (crates."tokio_executor"."${deps."tokio_current_thread"."0.1.6"."tokio_executor"}" deps)
    ]);
  };
  features_.tokio_current_thread."0.1.6" = deps: f: updateFeatures f (rec {
    futures."${deps.tokio_current_thread."0.1.6".futures}".default = true;
    tokio_current_thread."0.1.6".default = (f.tokio_current_thread."0.1.6".default or true);
    tokio_executor."${deps.tokio_current_thread."0.1.6".tokio_executor}".default = true;
  }) [
    (features_.futures."${deps."tokio_current_thread"."0.1.6"."futures"}" deps)
    (features_.tokio_executor."${deps."tokio_current_thread"."0.1.6"."tokio_executor"}" deps)
  ];


# end
# tokio-executor-0.1.8

  crates.tokio_executor."0.1.8" = deps: { features?(features_.tokio_executor."0.1.8" deps {}) }: buildRustCrate {
    crateName = "tokio-executor";
    version = "0.1.8";
    description = "Future execution primitives\n";
    authors = [ "Carl Lerche <me@carllerche.com>" ];
    sha256 = "017pvi6ii0wb1s78vrbjhzwrjlc0mga3x98dz3g19lhylcl50f7r";
    dependencies = mapFeatures features ([
      (crates."crossbeam_utils"."${deps."tokio_executor"."0.1.8"."crossbeam_utils"}" deps)
      (crates."futures"."${deps."tokio_executor"."0.1.8"."futures"}" deps)
    ]);
  };
  features_.tokio_executor."0.1.8" = deps: f: updateFeatures f (rec {
    crossbeam_utils."${deps.tokio_executor."0.1.8".crossbeam_utils}".default = true;
    futures."${deps.tokio_executor."0.1.8".futures}".default = true;
    tokio_executor."0.1.8".default = (f.tokio_executor."0.1.8".default or true);
  }) [
    (features_.crossbeam_utils."${deps."tokio_executor"."0.1.8"."crossbeam_utils"}" deps)
    (features_.futures."${deps."tokio_executor"."0.1.8"."futures"}" deps)
  ];


# end
# tokio-io-0.1.12

  crates.tokio_io."0.1.12" = deps: { features?(features_.tokio_io."0.1.12" deps {}) }: buildRustCrate {
    crateName = "tokio-io";
    version = "0.1.12";
    description = "Core I/O primitives for asynchronous I/O in Rust.\n";
    authors = [ "Carl Lerche <me@carllerche.com>" ];
    sha256 = "0z64yfcm9i5ci2h9h7npa292plia9kb04xbm7cp0bzp1wsddv91r";
    dependencies = mapFeatures features ([
      (crates."bytes"."${deps."tokio_io"."0.1.12"."bytes"}" deps)
      (crates."futures"."${deps."tokio_io"."0.1.12"."futures"}" deps)
      (crates."log"."${deps."tokio_io"."0.1.12"."log"}" deps)
    ]);
  };
  features_.tokio_io."0.1.12" = deps: f: updateFeatures f (rec {
    bytes."${deps.tokio_io."0.1.12".bytes}".default = true;
    futures."${deps.tokio_io."0.1.12".futures}".default = true;
    log."${deps.tokio_io."0.1.12".log}".default = true;
    tokio_io."0.1.12".default = (f.tokio_io."0.1.12".default or true);
  }) [
    (features_.bytes."${deps."tokio_io"."0.1.12"."bytes"}" deps)
    (features_.futures."${deps."tokio_io"."0.1.12"."futures"}" deps)
    (features_.log."${deps."tokio_io"."0.1.12"."log"}" deps)
  ];


# end
# tokio-reactor-0.1.9

  crates.tokio_reactor."0.1.9" = deps: { features?(features_.tokio_reactor."0.1.9" deps {}) }: buildRustCrate {
    crateName = "tokio-reactor";
    version = "0.1.9";
    description = "Event loop that drives Tokio I/O resources.\n";
    authors = [ "Carl Lerche <me@carllerche.com>" ];
    sha256 = "11gpxrykd6lbpj9b26dh4fymzawfxgqdx1pbhc771gxbf8qyj1gc";
    dependencies = mapFeatures features ([
      (crates."crossbeam_utils"."${deps."tokio_reactor"."0.1.9"."crossbeam_utils"}" deps)
      (crates."futures"."${deps."tokio_reactor"."0.1.9"."futures"}" deps)
      (crates."lazy_static"."${deps."tokio_reactor"."0.1.9"."lazy_static"}" deps)
      (crates."log"."${deps."tokio_reactor"."0.1.9"."log"}" deps)
      (crates."mio"."${deps."tokio_reactor"."0.1.9"."mio"}" deps)
      (crates."num_cpus"."${deps."tokio_reactor"."0.1.9"."num_cpus"}" deps)
      (crates."parking_lot"."${deps."tokio_reactor"."0.1.9"."parking_lot"}" deps)
      (crates."slab"."${deps."tokio_reactor"."0.1.9"."slab"}" deps)
      (crates."tokio_executor"."${deps."tokio_reactor"."0.1.9"."tokio_executor"}" deps)
      (crates."tokio_io"."${deps."tokio_reactor"."0.1.9"."tokio_io"}" deps)
      (crates."tokio_sync"."${deps."tokio_reactor"."0.1.9"."tokio_sync"}" deps)
    ]);
  };
  features_.tokio_reactor."0.1.9" = deps: f: updateFeatures f (rec {
    crossbeam_utils."${deps.tokio_reactor."0.1.9".crossbeam_utils}".default = true;
    futures."${deps.tokio_reactor."0.1.9".futures}".default = true;
    lazy_static."${deps.tokio_reactor."0.1.9".lazy_static}".default = true;
    log."${deps.tokio_reactor."0.1.9".log}".default = true;
    mio."${deps.tokio_reactor."0.1.9".mio}".default = true;
    num_cpus."${deps.tokio_reactor."0.1.9".num_cpus}".default = true;
    parking_lot."${deps.tokio_reactor."0.1.9".parking_lot}".default = true;
    slab."${deps.tokio_reactor."0.1.9".slab}".default = true;
    tokio_executor."${deps.tokio_reactor."0.1.9".tokio_executor}".default = true;
    tokio_io."${deps.tokio_reactor."0.1.9".tokio_io}".default = true;
    tokio_reactor."0.1.9".default = (f.tokio_reactor."0.1.9".default or true);
    tokio_sync."${deps.tokio_reactor."0.1.9".tokio_sync}".default = true;
  }) [
    (features_.crossbeam_utils."${deps."tokio_reactor"."0.1.9"."crossbeam_utils"}" deps)
    (features_.futures."${deps."tokio_reactor"."0.1.9"."futures"}" deps)
    (features_.lazy_static."${deps."tokio_reactor"."0.1.9"."lazy_static"}" deps)
    (features_.log."${deps."tokio_reactor"."0.1.9"."log"}" deps)
    (features_.mio."${deps."tokio_reactor"."0.1.9"."mio"}" deps)
    (features_.num_cpus."${deps."tokio_reactor"."0.1.9"."num_cpus"}" deps)
    (features_.parking_lot."${deps."tokio_reactor"."0.1.9"."parking_lot"}" deps)
    (features_.slab."${deps."tokio_reactor"."0.1.9"."slab"}" deps)
    (features_.tokio_executor."${deps."tokio_reactor"."0.1.9"."tokio_executor"}" deps)
    (features_.tokio_io."${deps."tokio_reactor"."0.1.9"."tokio_io"}" deps)
    (features_.tokio_sync."${deps."tokio_reactor"."0.1.9"."tokio_sync"}" deps)
  ];


# end
# tokio-sync-0.1.6

  crates.tokio_sync."0.1.6" = deps: { features?(features_.tokio_sync."0.1.6" deps {}) }: buildRustCrate {
    crateName = "tokio-sync";
    version = "0.1.6";
    description = "Synchronization utilities.\n";
    authors = [ "Carl Lerche <me@carllerche.com>" ];
    sha256 = "0csjpxf7m088lh3nfkhj5q1zi5hycdk5xqcginw328rnl1srzyl7";
    dependencies = mapFeatures features ([
      (crates."fnv"."${deps."tokio_sync"."0.1.6"."fnv"}" deps)
      (crates."futures"."${deps."tokio_sync"."0.1.6"."futures"}" deps)
    ]);
  };
  features_.tokio_sync."0.1.6" = deps: f: updateFeatures f (rec {
    fnv."${deps.tokio_sync."0.1.6".fnv}".default = true;
    futures."${deps.tokio_sync."0.1.6".futures}".default = true;
    tokio_sync."0.1.6".default = (f.tokio_sync."0.1.6".default or true);
  }) [
    (features_.fnv."${deps."tokio_sync"."0.1.6"."fnv"}" deps)
    (features_.futures."${deps."tokio_sync"."0.1.6"."futures"}" deps)
  ];


# end
# tokio-tcp-0.1.3

  crates.tokio_tcp."0.1.3" = deps: { features?(features_.tokio_tcp."0.1.3" deps {}) }: buildRustCrate {
    crateName = "tokio-tcp";
    version = "0.1.3";
    description = "TCP bindings for tokio.\n";
    authors = [ "Carl Lerche <me@carllerche.com>" ];
    sha256 = "07v5p339660zjy1w73wddagj3n5wa4v7v5gj7hnvw95ka407zvcz";
    dependencies = mapFeatures features ([
      (crates."bytes"."${deps."tokio_tcp"."0.1.3"."bytes"}" deps)
      (crates."futures"."${deps."tokio_tcp"."0.1.3"."futures"}" deps)
      (crates."iovec"."${deps."tokio_tcp"."0.1.3"."iovec"}" deps)
      (crates."mio"."${deps."tokio_tcp"."0.1.3"."mio"}" deps)
      (crates."tokio_io"."${deps."tokio_tcp"."0.1.3"."tokio_io"}" deps)
      (crates."tokio_reactor"."${deps."tokio_tcp"."0.1.3"."tokio_reactor"}" deps)
    ]);
  };
  features_.tokio_tcp."0.1.3" = deps: f: updateFeatures f (rec {
    bytes."${deps.tokio_tcp."0.1.3".bytes}".default = true;
    futures."${deps.tokio_tcp."0.1.3".futures}".default = true;
    iovec."${deps.tokio_tcp."0.1.3".iovec}".default = true;
    mio."${deps.tokio_tcp."0.1.3".mio}".default = true;
    tokio_io."${deps.tokio_tcp."0.1.3".tokio_io}".default = true;
    tokio_reactor."${deps.tokio_tcp."0.1.3".tokio_reactor}".default = true;
    tokio_tcp."0.1.3".default = (f.tokio_tcp."0.1.3".default or true);
  }) [
    (features_.bytes."${deps."tokio_tcp"."0.1.3"."bytes"}" deps)
    (features_.futures."${deps."tokio_tcp"."0.1.3"."futures"}" deps)
    (features_.iovec."${deps."tokio_tcp"."0.1.3"."iovec"}" deps)
    (features_.mio."${deps."tokio_tcp"."0.1.3"."mio"}" deps)
    (features_.tokio_io."${deps."tokio_tcp"."0.1.3"."tokio_io"}" deps)
    (features_.tokio_reactor."${deps."tokio_tcp"."0.1.3"."tokio_reactor"}" deps)
  ];


# end
# tokio-threadpool-0.1.15

  crates.tokio_threadpool."0.1.15" = deps: { features?(features_.tokio_threadpool."0.1.15" deps {}) }: buildRustCrate {
    crateName = "tokio-threadpool";
    version = "0.1.15";
    description = "A task scheduler backed by a work-stealing thread pool.\n";
    authors = [ "Carl Lerche <me@carllerche.com>" ];
    sha256 = "07wsanfx01hjz6gr1pfbr8v0b3wwbnckc0z52svrkh5msy74wgrj";
    dependencies = mapFeatures features ([
      (crates."crossbeam_deque"."${deps."tokio_threadpool"."0.1.15"."crossbeam_deque"}" deps)
      (crates."crossbeam_queue"."${deps."tokio_threadpool"."0.1.15"."crossbeam_queue"}" deps)
      (crates."crossbeam_utils"."${deps."tokio_threadpool"."0.1.15"."crossbeam_utils"}" deps)
      (crates."futures"."${deps."tokio_threadpool"."0.1.15"."futures"}" deps)
      (crates."log"."${deps."tokio_threadpool"."0.1.15"."log"}" deps)
      (crates."num_cpus"."${deps."tokio_threadpool"."0.1.15"."num_cpus"}" deps)
      (crates."rand"."${deps."tokio_threadpool"."0.1.15"."rand"}" deps)
      (crates."slab"."${deps."tokio_threadpool"."0.1.15"."slab"}" deps)
      (crates."tokio_executor"."${deps."tokio_threadpool"."0.1.15"."tokio_executor"}" deps)
    ]);
  };
  features_.tokio_threadpool."0.1.15" = deps: f: updateFeatures f (rec {
    crossbeam_deque."${deps.tokio_threadpool."0.1.15".crossbeam_deque}".default = true;
    crossbeam_queue."${deps.tokio_threadpool."0.1.15".crossbeam_queue}".default = true;
    crossbeam_utils."${deps.tokio_threadpool."0.1.15".crossbeam_utils}".default = true;
    futures."${deps.tokio_threadpool."0.1.15".futures}".default = true;
    log."${deps.tokio_threadpool."0.1.15".log}".default = true;
    num_cpus."${deps.tokio_threadpool."0.1.15".num_cpus}".default = true;
    rand."${deps.tokio_threadpool."0.1.15".rand}".default = true;
    slab."${deps.tokio_threadpool."0.1.15".slab}".default = true;
    tokio_executor."${deps.tokio_threadpool."0.1.15".tokio_executor}".default = true;
    tokio_threadpool."0.1.15".default = (f.tokio_threadpool."0.1.15".default or true);
  }) [
    (features_.crossbeam_deque."${deps."tokio_threadpool"."0.1.15"."crossbeam_deque"}" deps)
    (features_.crossbeam_queue."${deps."tokio_threadpool"."0.1.15"."crossbeam_queue"}" deps)
    (features_.crossbeam_utils."${deps."tokio_threadpool"."0.1.15"."crossbeam_utils"}" deps)
    (features_.futures."${deps."tokio_threadpool"."0.1.15"."futures"}" deps)
    (features_.log."${deps."tokio_threadpool"."0.1.15"."log"}" deps)
    (features_.num_cpus."${deps."tokio_threadpool"."0.1.15"."num_cpus"}" deps)
    (features_.rand."${deps."tokio_threadpool"."0.1.15"."rand"}" deps)
    (features_.slab."${deps."tokio_threadpool"."0.1.15"."slab"}" deps)
    (features_.tokio_executor."${deps."tokio_threadpool"."0.1.15"."tokio_executor"}" deps)
  ];


# end
# tokio-timer-0.2.11

  crates.tokio_timer."0.2.11" = deps: { features?(features_.tokio_timer."0.2.11" deps {}) }: buildRustCrate {
    crateName = "tokio-timer";
    version = "0.2.11";
    description = "Timer facilities for Tokio\n";
    authors = [ "Carl Lerche <me@carllerche.com>" ];
    sha256 = "1g1np0mdhiwl52kxp543q9jdidf9vws403jh2nay3srlpnqhrkx9";
    dependencies = mapFeatures features ([
      (crates."crossbeam_utils"."${deps."tokio_timer"."0.2.11"."crossbeam_utils"}" deps)
      (crates."futures"."${deps."tokio_timer"."0.2.11"."futures"}" deps)
      (crates."slab"."${deps."tokio_timer"."0.2.11"."slab"}" deps)
      (crates."tokio_executor"."${deps."tokio_timer"."0.2.11"."tokio_executor"}" deps)
    ]);
  };
  features_.tokio_timer."0.2.11" = deps: f: updateFeatures f (rec {
    crossbeam_utils."${deps.tokio_timer."0.2.11".crossbeam_utils}".default = true;
    futures."${deps.tokio_timer."0.2.11".futures}".default = true;
    slab."${deps.tokio_timer."0.2.11".slab}".default = true;
    tokio_executor."${deps.tokio_timer."0.2.11".tokio_executor}".default = true;
    tokio_timer."0.2.11".default = (f.tokio_timer."0.2.11".default or true);
  }) [
    (features_.crossbeam_utils."${deps."tokio_timer"."0.2.11"."crossbeam_utils"}" deps)
    (features_.futures."${deps."tokio_timer"."0.2.11"."futures"}" deps)
    (features_.slab."${deps."tokio_timer"."0.2.11"."slab"}" deps)
    (features_.tokio_executor."${deps."tokio_timer"."0.2.11"."tokio_executor"}" deps)
  ];


# end
# toml-0.5.3

  crates.toml."0.5.3" = deps: { features?(features_.toml."0.5.3" deps {}) }: buildRustCrate {
    crateName = "toml";
    version = "0.5.3";
    description = "A native Rust encoder and decoder of TOML-formatted files and streams. Provides\nimplementations of the standard Serialize/Deserialize traits for TOML data to\nfacilitate deserializing and serializing Rust structures.\n";
    authors = [ "Alex Crichton <alex@alexcrichton.com>" ];
    edition = "2018";
    sha256 = "0kdagcqxv1p5xxnqd0d4ganr7fq011pdspcm7j45vrd4ka4mzjk5";
    dependencies = mapFeatures features ([
      (crates."serde"."${deps."toml"."0.5.3"."serde"}" deps)
    ]);
    features = mkFeatures (features."toml"."0.5.3" or {});
  };
  features_.toml."0.5.3" = deps: f: updateFeatures f (rec {
    serde."${deps.toml."0.5.3".serde}".default = true;
    toml = fold recursiveUpdate {} [
      { "0.5.3"."linked-hash-map" =
        (f.toml."0.5.3"."linked-hash-map" or false) ||
        (f.toml."0.5.3".preserve_order or false) ||
        (toml."0.5.3"."preserve_order" or false); }
      { "0.5.3".default = (f.toml."0.5.3".default or true); }
    ];
  }) [
    (features_.serde."${deps."toml"."0.5.3"."serde"}" deps)
  ];


# end
# try-lock-0.2.2

  crates.try_lock."0.2.2" = deps: { features?(features_.try_lock."0.2.2" deps {}) }: buildRustCrate {
    crateName = "try-lock";
    version = "0.2.2";
    description = "A lightweight atomic lock.";
    authors = [ "Sean McArthur <sean@seanmonstar.com>" ];
    sha256 = "1k8xc0jpbrmzp0fwghdh6pwzjb9xx2p8yy0xxnnb8065smc5fsrv";
  };
  features_.try_lock."0.2.2" = deps: f: updateFeatures f (rec {
    try_lock."0.2.2".default = (f.try_lock."0.2.2".default or true);
  }) [];


# end
# try_from-0.3.2

  crates.try_from."0.3.2" = deps: { features?(features_.try_from."0.3.2" deps {}) }: buildRustCrate {
    crateName = "try_from";
    version = "0.3.2";
    description = "TryFrom and TryInto traits for failable conversions that return a Result.";
    authors = [ "Derek Williams <derek@fyrie.net>" ];
    sha256 = "05jnndmiqz2sf8xsnf7ysaj3fpl3rhgzbfn1jx6casaahakrzald";
    dependencies = mapFeatures features ([
      (crates."cfg_if"."${deps."try_from"."0.3.2"."cfg_if"}" deps)
    ]);
    features = mkFeatures (features."try_from"."0.3.2" or {});
  };
  features_.try_from."0.3.2" = deps: f: updateFeatures f (rec {
    cfg_if."${deps.try_from."0.3.2".cfg_if}".default = true;
    try_from."0.3.2".default = (f.try_from."0.3.2".default or true);
  }) [
    (features_.cfg_if."${deps."try_from"."0.3.2"."cfg_if"}" deps)
  ];


# end
# unicase-2.5.1

  crates.unicase."2.5.1" = deps: { features?(features_.unicase."2.5.1" deps {}) }: buildRustCrate {
    crateName = "unicase";
    version = "2.5.1";
    description = "A case-insensitive wrapper around strings.";
    authors = [ "Sean McArthur <sean@seanmonstar.com>" ];
    sha256 = "002myydpgm20afbdfavi3ks9jaqji7i1sdyafld1j8hhcrvajlv1";
    build = "build.rs";

    buildDependencies = mapFeatures features ([
      (crates."version_check"."${deps."unicase"."2.5.1"."version_check"}" deps)
    ]);
    features = mkFeatures (features."unicase"."2.5.1" or {});
  };
  features_.unicase."2.5.1" = deps: f: updateFeatures f (rec {
    unicase."2.5.1".default = (f.unicase."2.5.1".default or true);
    version_check."${deps.unicase."2.5.1".version_check}".default = true;
  }) [
    (features_.version_check."${deps."unicase"."2.5.1"."version_check"}" deps)
  ];


# end
# unicode-bidi-0.3.4

  crates.unicode_bidi."0.3.4" = deps: { features?(features_.unicode_bidi."0.3.4" deps {}) }: buildRustCrate {
    crateName = "unicode-bidi";
    version = "0.3.4";
    description = "Implementation of the Unicode Bidirectional Algorithm";
    authors = [ "The Servo Project Developers" ];
    sha256 = "0lcd6jasrf8p9p0q20qyf10c6xhvw40m2c4rr105hbk6zy26nj1q";
    libName = "unicode_bidi";
    dependencies = mapFeatures features ([
      (crates."matches"."${deps."unicode_bidi"."0.3.4"."matches"}" deps)
    ]);
    features = mkFeatures (features."unicode_bidi"."0.3.4" or {});
  };
  features_.unicode_bidi."0.3.4" = deps: f: updateFeatures f (rec {
    matches."${deps.unicode_bidi."0.3.4".matches}".default = true;
    unicode_bidi = fold recursiveUpdate {} [
      { "0.3.4"."flame" =
        (f.unicode_bidi."0.3.4"."flame" or false) ||
        (f.unicode_bidi."0.3.4".flame_it or false) ||
        (unicode_bidi."0.3.4"."flame_it" or false); }
      { "0.3.4"."flamer" =
        (f.unicode_bidi."0.3.4"."flamer" or false) ||
        (f.unicode_bidi."0.3.4".flame_it or false) ||
        (unicode_bidi."0.3.4"."flame_it" or false); }
      { "0.3.4"."serde" =
        (f.unicode_bidi."0.3.4"."serde" or false) ||
        (f.unicode_bidi."0.3.4".with_serde or false) ||
        (unicode_bidi."0.3.4"."with_serde" or false); }
      { "0.3.4".default = (f.unicode_bidi."0.3.4".default or true); }
    ];
  }) [
    (features_.matches."${deps."unicode_bidi"."0.3.4"."matches"}" deps)
  ];


# end
# unicode-normalization-0.1.8

  crates.unicode_normalization."0.1.8" = deps: { features?(features_.unicode_normalization."0.1.8" deps {}) }: buildRustCrate {
    crateName = "unicode-normalization";
    version = "0.1.8";
    description = "This crate provides functions for normalization of\nUnicode strings, including Canonical and Compatible\nDecomposition and Recomposition, as described in\nUnicode Standard Annex #15.\n";
    authors = [ "kwantam <kwantam@gmail.com>" ];
    sha256 = "1pb26i2xd5zz0icabyqahikpca0iwj2jd4145pczc4bb7p641dsz";
    dependencies = mapFeatures features ([
      (crates."smallvec"."${deps."unicode_normalization"."0.1.8"."smallvec"}" deps)
    ]);
  };
  features_.unicode_normalization."0.1.8" = deps: f: updateFeatures f (rec {
    smallvec."${deps.unicode_normalization."0.1.8".smallvec}".default = true;
    unicode_normalization."0.1.8".default = (f.unicode_normalization."0.1.8".default or true);
  }) [
    (features_.smallvec."${deps."unicode_normalization"."0.1.8"."smallvec"}" deps)
  ];


# end
# unicode-width-0.1.6

  crates.unicode_width."0.1.6" = deps: { features?(features_.unicode_width."0.1.6" deps {}) }: buildRustCrate {
    crateName = "unicode-width";
    version = "0.1.6";
    description = "Determine displayed width of `char` and `str` types\naccording to Unicode Standard Annex #11 rules.\n";
    authors = [ "kwantam <kwantam@gmail.com>" ];
    sha256 = "1mss965j7d8pv7z7zg6qfkcb7lyhxkxvbh8akzr4xxxx3vzazwsi";
    dependencies = mapFeatures features ([
]);
    features = mkFeatures (features."unicode_width"."0.1.6" or {});
  };
  features_.unicode_width."0.1.6" = deps: f: updateFeatures f (rec {
    unicode_width = fold recursiveUpdate {} [
      { "0.1.6"."compiler_builtins" =
        (f.unicode_width."0.1.6"."compiler_builtins" or false) ||
        (f.unicode_width."0.1.6".rustc-dep-of-std or false) ||
        (unicode_width."0.1.6"."rustc-dep-of-std" or false); }
      { "0.1.6"."core" =
        (f.unicode_width."0.1.6"."core" or false) ||
        (f.unicode_width."0.1.6".rustc-dep-of-std or false) ||
        (unicode_width."0.1.6"."rustc-dep-of-std" or false); }
      { "0.1.6"."std" =
        (f.unicode_width."0.1.6"."std" or false) ||
        (f.unicode_width."0.1.6".rustc-dep-of-std or false) ||
        (unicode_width."0.1.6"."rustc-dep-of-std" or false); }
      { "0.1.6".default = (f.unicode_width."0.1.6".default or true); }
    ];
  }) [];


# end
# unicode-xid-0.1.0

  crates.unicode_xid."0.1.0" = deps: { features?(features_.unicode_xid."0.1.0" deps {}) }: buildRustCrate {
    crateName = "unicode-xid";
    version = "0.1.0";
    description = "Determine whether characters have the XID_Start\nor XID_Continue properties according to\nUnicode Standard Annex #31.\n";
    authors = [ "erick.tryzelaar <erick.tryzelaar@gmail.com>" "kwantam <kwantam@gmail.com>" ];
    sha256 = "05wdmwlfzxhq3nhsxn6wx4q8dhxzzfb9szsz6wiw092m1rjj01zj";
    features = mkFeatures (features."unicode_xid"."0.1.0" or {});
  };
  features_.unicode_xid."0.1.0" = deps: f: updateFeatures f (rec {
    unicode_xid."0.1.0".default = (f.unicode_xid."0.1.0".default or true);
  }) [];


# end
# unicode-xid-0.2.0

  crates.unicode_xid."0.2.0" = deps: { features?(features_.unicode_xid."0.2.0" deps {}) }: buildRustCrate {
    crateName = "unicode-xid";
    version = "0.2.0";
    description = "Determine whether characters have the XID_Start\nor XID_Continue properties according to\nUnicode Standard Annex #31.\n";
    authors = [ "erick.tryzelaar <erick.tryzelaar@gmail.com>" "kwantam <kwantam@gmail.com>" ];
    sha256 = "1c85gb3p3qhbjvfyjb31m06la4f024jx319k10ig7n47dz2fk8v7";
    features = mkFeatures (features."unicode_xid"."0.2.0" or {});
  };
  features_.unicode_xid."0.2.0" = deps: f: updateFeatures f (rec {
    unicode_xid."0.2.0".default = (f.unicode_xid."0.2.0".default or true);
  }) [];


# end
# url-1.7.2

  crates.url."1.7.2" = deps: { features?(features_.url."1.7.2" deps {}) }: buildRustCrate {
    crateName = "url";
    version = "1.7.2";
    description = "URL library for Rust, based on the WHATWG URL Standard";
    authors = [ "The rust-url developers" ];
    sha256 = "0qzrjzd9r1niv7037x4cgnv98fs1vj0k18lpxx890ipc47x5gc09";
    dependencies = mapFeatures features ([
      (crates."idna"."${deps."url"."1.7.2"."idna"}" deps)
      (crates."matches"."${deps."url"."1.7.2"."matches"}" deps)
      (crates."percent_encoding"."${deps."url"."1.7.2"."percent_encoding"}" deps)
    ]);
    features = mkFeatures (features."url"."1.7.2" or {});
  };
  features_.url."1.7.2" = deps: f: updateFeatures f (rec {
    idna."${deps.url."1.7.2".idna}".default = true;
    matches."${deps.url."1.7.2".matches}".default = true;
    percent_encoding."${deps.url."1.7.2".percent_encoding}".default = true;
    url = fold recursiveUpdate {} [
      { "1.7.2"."encoding" =
        (f.url."1.7.2"."encoding" or false) ||
        (f.url."1.7.2".query_encoding or false) ||
        (url."1.7.2"."query_encoding" or false); }
      { "1.7.2"."heapsize" =
        (f.url."1.7.2"."heapsize" or false) ||
        (f.url."1.7.2".heap_size or false) ||
        (url."1.7.2"."heap_size" or false); }
      { "1.7.2".default = (f.url."1.7.2".default or true); }
    ];
  }) [
    (features_.idna."${deps."url"."1.7.2"."idna"}" deps)
    (features_.matches."${deps."url"."1.7.2"."matches"}" deps)
    (features_.percent_encoding."${deps."url"."1.7.2"."percent_encoding"}" deps)
  ];


# end
# url-2.1.0

  crates.url."2.1.0" = deps: { features?(features_.url."2.1.0" deps {}) }: buildRustCrate {
    crateName = "url";
    version = "2.1.0";
    description = "URL library for Rust, based on the WHATWG URL Standard";
    authors = [ "The rust-url developers" ];
    sha256 = "0mvv28fvrrv3hc064gjgpqjvjn1j151qbi9i5bcilal6rkcd1brq";
    dependencies = mapFeatures features ([
      (crates."idna"."${deps."url"."2.1.0"."idna"}" deps)
      (crates."matches"."${deps."url"."2.1.0"."matches"}" deps)
      (crates."percent_encoding"."${deps."url"."2.1.0"."percent_encoding"}" deps)
    ]
      ++ (if features.url."2.1.0".serde or false then [ (crates.serde."${deps."url"."2.1.0".serde}" deps) ] else []));
    features = mkFeatures (features."url"."2.1.0" or {});
  };
  features_.url."2.1.0" = deps: f: updateFeatures f (rec {
    idna."${deps.url."2.1.0".idna}".default = true;
    matches."${deps.url."2.1.0".matches}".default = true;
    percent_encoding."${deps.url."2.1.0".percent_encoding}".default = true;
    serde = fold recursiveUpdate {} [
      { "${deps.url."2.1.0".serde}"."derive" = true; }
      { "${deps.url."2.1.0".serde}".default = true; }
    ];
    url."2.1.0".default = (f.url."2.1.0".default or true);
  }) [
    (features_.idna."${deps."url"."2.1.0"."idna"}" deps)
    (features_.matches."${deps."url"."2.1.0"."matches"}" deps)
    (features_.percent_encoding."${deps."url"."2.1.0"."percent_encoding"}" deps)
    (features_.serde."${deps."url"."2.1.0"."serde"}" deps)
  ];


# end
# utf-8-0.7.5

  crates.utf_8."0.7.5" = deps: { features?(features_.utf_8."0.7.5" deps {}) }: buildRustCrate {
    crateName = "utf-8";
    version = "0.7.5";
    description = "Incremental, zero-copy UTF-8 decoding with error handling";
    authors = [ "Simon Sapin <simon.sapin@exyr.org>" ];
    sha256 = "02y7d0ch5zfdy0mailqfb14vcbhr7kw1nsfrs0q9c4bq5g9c10qp";
    libName = "utf8";
  };
  features_.utf_8."0.7.5" = deps: f: updateFeatures f (rec {
    utf_8."0.7.5".default = (f.utf_8."0.7.5".default or true);
  }) [];


# end
# uuid-0.7.4

  crates.uuid."0.7.4" = deps: { features?(features_.uuid."0.7.4" deps {}) }: buildRustCrate {
    crateName = "uuid";
    version = "0.7.4";
    description = "A library to generate and parse UUIDs.";
    authors = [ "Ashley Mannix<ashleymannix@live.com.au>" "Christopher Armstrong" "Dylan DPC<dylan.dpc@gmail.com>" "Hunar Roop Kahlon<hunar.roop@gmail.com>" ];
    sha256 = "1kzjah6i8vf51hrla6qnplymaqx2fadhhlnbvgivgld311lqyz9m";
    dependencies = mapFeatures features ([
    ]
      ++ (if features.uuid."0.7.4".rand or false then [ (crates.rand."${deps."uuid"."0.7.4".rand}" deps) ] else []))
      ++ (if kernel == "windows" then mapFeatures features ([
]) else []);
    features = mkFeatures (features."uuid"."0.7.4" or {});
  };
  features_.uuid."0.7.4" = deps: f: updateFeatures f (rec {
    rand = fold recursiveUpdate {} [
      { "${deps.uuid."0.7.4".rand}"."stdweb" =
        (f.rand."${deps.uuid."0.7.4".rand}"."stdweb" or false) ||
        (uuid."0.7.4"."stdweb" or false) ||
        (f."uuid"."0.7.4"."stdweb" or false); }
      { "${deps.uuid."0.7.4".rand}"."wasm-bindgen" =
        (f.rand."${deps.uuid."0.7.4".rand}"."wasm-bindgen" or false) ||
        (uuid."0.7.4"."wasm-bindgen" or false) ||
        (f."uuid"."0.7.4"."wasm-bindgen" or false); }
      { "${deps.uuid."0.7.4".rand}".default = true; }
    ];
    uuid = fold recursiveUpdate {} [
      { "0.7.4"."byteorder" =
        (f.uuid."0.7.4"."byteorder" or false) ||
        (f.uuid."0.7.4".u128 or false) ||
        (uuid."0.7.4"."u128" or false); }
      { "0.7.4"."md5" =
        (f.uuid."0.7.4"."md5" or false) ||
        (f.uuid."0.7.4".v3 or false) ||
        (uuid."0.7.4"."v3" or false); }
      { "0.7.4"."nightly" =
        (f.uuid."0.7.4"."nightly" or false) ||
        (f.uuid."0.7.4".const_fn or false) ||
        (uuid."0.7.4"."const_fn" or false); }
      { "0.7.4"."rand" =
        (f.uuid."0.7.4"."rand" or false) ||
        (f.uuid."0.7.4".v4 or false) ||
        (uuid."0.7.4"."v4" or false); }
      { "0.7.4"."sha1" =
        (f.uuid."0.7.4"."sha1" or false) ||
        (f.uuid."0.7.4".v5 or false) ||
        (uuid."0.7.4"."v5" or false); }
      { "0.7.4"."std" =
        (f.uuid."0.7.4"."std" or false) ||
        (f.uuid."0.7.4".default or false) ||
        (uuid."0.7.4"."default" or false); }
      { "0.7.4"."winapi" =
        (f.uuid."0.7.4"."winapi" or false) ||
        (f.uuid."0.7.4".guid or false) ||
        (uuid."0.7.4"."guid" or false); }
      { "0.7.4".default = (f.uuid."0.7.4".default or true); }
    ];
  }) [
    (features_.rand."${deps."uuid"."0.7.4"."rand"}" deps)
  ];


# end
# vcpkg-0.2.7

  crates.vcpkg."0.2.7" = deps: { features?(features_.vcpkg."0.2.7" deps {}) }: buildRustCrate {
    crateName = "vcpkg";
    version = "0.2.7";
    description = "A library to find native dependencies in a vcpkg tree at build\ntime in order to be used in Cargo build scripts.\n";
    authors = [ "Jim McGrath <jimmc2@gmail.com>" ];
    sha256 = "1lwykbbscbdy4nhrfidgg3rk2xw9cvx5672sx1c97wm8y3vjpcd9";
  };
  features_.vcpkg."0.2.7" = deps: f: updateFeatures f (rec {
    vcpkg."0.2.7".default = (f.vcpkg."0.2.7".default or true);
  }) [];


# end
# vec_map-0.8.1

  crates.vec_map."0.8.1" = deps: { features?(features_.vec_map."0.8.1" deps {}) }: buildRustCrate {
    crateName = "vec_map";
    version = "0.8.1";
    description = "A simple map based on a vector for small integer keys";
    authors = [ "Alex Crichton <alex@alexcrichton.com>" "Jorge Aparicio <japaricious@gmail.com>" "Alexis Beingessner <a.beingessner@gmail.com>" "Brian Anderson <>" "tbu- <>" "Manish Goregaokar <>" "Aaron Turon <aturon@mozilla.com>" "Adolfo Ochagavía <>" "Niko Matsakis <>" "Steven Fackler <>" "Chase Southwood <csouth3@illinois.edu>" "Eduard Burtescu <>" "Florian Wilkens <>" "Félix Raimundo <>" "Tibor Benke <>" "Markus Siemens <markus@m-siemens.de>" "Josh Branchaud <jbranchaud@gmail.com>" "Huon Wilson <dbau.pp@gmail.com>" "Corey Farwell <coref@rwell.org>" "Aaron Liblong <>" "Nick Cameron <nrc@ncameron.org>" "Patrick Walton <pcwalton@mimiga.net>" "Felix S Klock II <>" "Andrew Paseltiner <apaseltiner@gmail.com>" "Sean McArthur <sean.monstar@gmail.com>" "Vadim Petrochenkov <>" ];
    sha256 = "1jj2nrg8h3l53d43rwkpkikq5a5x15ms4rf1rw92hp5lrqhi8mpi";
    dependencies = mapFeatures features ([
]);
    features = mkFeatures (features."vec_map"."0.8.1" or {});
  };
  features_.vec_map."0.8.1" = deps: f: updateFeatures f (rec {
    vec_map = fold recursiveUpdate {} [
      { "0.8.1"."serde" =
        (f.vec_map."0.8.1"."serde" or false) ||
        (f.vec_map."0.8.1".eders or false) ||
        (vec_map."0.8.1"."eders" or false); }
      { "0.8.1".default = (f.vec_map."0.8.1".default or true); }
    ];
  }) [];


# end
# version_check-0.1.5

  crates.version_check."0.1.5" = deps: { features?(features_.version_check."0.1.5" deps {}) }: buildRustCrate {
    crateName = "version_check";
    version = "0.1.5";
    description = "Tiny crate to check the version of the installed/running rustc.";
    authors = [ "Sergio Benitez <sb@sergio.bz>" ];
    sha256 = "1yrx9xblmwbafw2firxyqbj8f771kkzfd24n3q7xgwiqyhi0y8qd";
  };
  features_.version_check."0.1.5" = deps: f: updateFeatures f (rec {
    version_check."0.1.5".default = (f.version_check."0.1.5".default or true);
  }) [];


# end
# want-0.2.0

  crates.want."0.2.0" = deps: { features?(features_.want."0.2.0" deps {}) }: buildRustCrate {
    crateName = "want";
    version = "0.2.0";
    description = "Detect when another Future wants a result.";
    authors = [ "Sean McArthur <sean@seanmonstar.com>" ];
    sha256 = "1qyd7cixai7f58zfbz8v3lg52q7p6805b9vw7vblw1pysg6vnrxb";
    dependencies = mapFeatures features ([
      (crates."futures"."${deps."want"."0.2.0"."futures"}" deps)
      (crates."log"."${deps."want"."0.2.0"."log"}" deps)
      (crates."try_lock"."${deps."want"."0.2.0"."try_lock"}" deps)
    ]);
  };
  features_.want."0.2.0" = deps: f: updateFeatures f (rec {
    futures."${deps.want."0.2.0".futures}".default = true;
    log."${deps.want."0.2.0".log}".default = true;
    try_lock."${deps.want."0.2.0".try_lock}".default = true;
    want."0.2.0".default = (f.want."0.2.0".default or true);
  }) [
    (features_.futures."${deps."want"."0.2.0"."futures"}" deps)
    (features_.log."${deps."want"."0.2.0"."log"}" deps)
    (features_.try_lock."${deps."want"."0.2.0"."try_lock"}" deps)
  ];


# end
# wasi-0.7.0

  crates.wasi."0.7.0" = deps: { features?(features_.wasi."0.7.0" deps {}) }: buildRustCrate {
    crateName = "wasi";
    version = "0.7.0";
    description = "Experimental WASI API bindings for Rust";
    authors = [ "The Cranelift Project Developers" ];
    edition = "2018";
    sha256 = "1lqknxy8x9mrsy0pna6xlwzypbhli73nbai9gmin5f4z1ghlng25";
    dependencies = mapFeatures features ([
]);
    features = mkFeatures (features."wasi"."0.7.0" or {});
  };
  features_.wasi."0.7.0" = deps: f: updateFeatures f (rec {
    wasi = fold recursiveUpdate {} [
      { "0.7.0"."alloc" =
        (f.wasi."0.7.0"."alloc" or false) ||
        (f.wasi."0.7.0".default or false) ||
        (wasi."0.7.0"."default" or false); }
      { "0.7.0"."compiler_builtins" =
        (f.wasi."0.7.0"."compiler_builtins" or false) ||
        (f.wasi."0.7.0".rustc-dep-of-std or false) ||
        (wasi."0.7.0"."rustc-dep-of-std" or false); }
      { "0.7.0"."core" =
        (f.wasi."0.7.0"."core" or false) ||
        (f.wasi."0.7.0".rustc-dep-of-std or false) ||
        (wasi."0.7.0"."rustc-dep-of-std" or false); }
      { "0.7.0"."rustc-std-workspace-alloc" =
        (f.wasi."0.7.0"."rustc-std-workspace-alloc" or false) ||
        (f.wasi."0.7.0".rustc-dep-of-std or false) ||
        (wasi."0.7.0"."rustc-dep-of-std" or false); }
      { "0.7.0".default = (f.wasi."0.7.0".default or true); }
    ];
  }) [];


# end
# winapi-0.2.8

  crates.winapi."0.2.8" = deps: { features?(features_.winapi."0.2.8" deps {}) }: buildRustCrate {
    crateName = "winapi";
    version = "0.2.8";
    description = "Types and constants for WinAPI bindings. See README for list of crates providing function bindings.";
    authors = [ "Peter Atashian <retep998@gmail.com>" ];
    sha256 = "0a45b58ywf12vb7gvj6h3j264nydynmzyqz8d8rqxsj6icqv82as";
  };
  features_.winapi."0.2.8" = deps: f: updateFeatures f (rec {
    winapi."0.2.8".default = (f.winapi."0.2.8".default or true);
  }) [];


# end
# winapi-0.3.8

  crates.winapi."0.3.8" = deps: { features?(features_.winapi."0.3.8" deps {}) }: buildRustCrate {
    crateName = "winapi";
    version = "0.3.8";
    description = "Raw FFI bindings for all of Windows API.";
    authors = [ "Peter Atashian <retep998@gmail.com>" ];
    sha256 = "084ialbgww1vxry341fmkg5crgpvab3w52ahx1wa54yqjgym0vxs";
    build = "build.rs";
    dependencies = (if kernel == "i686-pc-windows-gnu" then mapFeatures features ([
      (crates."winapi_i686_pc_windows_gnu"."${deps."winapi"."0.3.8"."winapi_i686_pc_windows_gnu"}" deps)
    ]) else [])
      ++ (if kernel == "x86_64-pc-windows-gnu" then mapFeatures features ([
      (crates."winapi_x86_64_pc_windows_gnu"."${deps."winapi"."0.3.8"."winapi_x86_64_pc_windows_gnu"}" deps)
    ]) else []);
    features = mkFeatures (features."winapi"."0.3.8" or {});
  };
  features_.winapi."0.3.8" = deps: f: updateFeatures f (rec {
    winapi = fold recursiveUpdate {} [
      { "0.3.8"."impl-debug" =
        (f.winapi."0.3.8"."impl-debug" or false) ||
        (f.winapi."0.3.8".debug or false) ||
        (winapi."0.3.8"."debug" or false); }
      { "0.3.8".default = (f.winapi."0.3.8".default or true); }
    ];
    winapi_i686_pc_windows_gnu."${deps.winapi."0.3.8".winapi_i686_pc_windows_gnu}".default = true;
    winapi_x86_64_pc_windows_gnu."${deps.winapi."0.3.8".winapi_x86_64_pc_windows_gnu}".default = true;
  }) [
    (features_.winapi_i686_pc_windows_gnu."${deps."winapi"."0.3.8"."winapi_i686_pc_windows_gnu"}" deps)
    (features_.winapi_x86_64_pc_windows_gnu."${deps."winapi"."0.3.8"."winapi_x86_64_pc_windows_gnu"}" deps)
  ];


# end
# winapi-build-0.1.1

  crates.winapi_build."0.1.1" = deps: { features?(features_.winapi_build."0.1.1" deps {}) }: buildRustCrate {
    crateName = "winapi-build";
    version = "0.1.1";
    description = "Common code for build.rs in WinAPI -sys crates.";
    authors = [ "Peter Atashian <retep998@gmail.com>" ];
    sha256 = "1lxlpi87rkhxcwp2ykf1ldw3p108hwm24nywf3jfrvmff4rjhqga";
    libName = "build";
  };
  features_.winapi_build."0.1.1" = deps: f: updateFeatures f (rec {
    winapi_build."0.1.1".default = (f.winapi_build."0.1.1".default or true);
  }) [];


# end
# winapi-i686-pc-windows-gnu-0.4.0

  crates.winapi_i686_pc_windows_gnu."0.4.0" = deps: { features?(features_.winapi_i686_pc_windows_gnu."0.4.0" deps {}) }: buildRustCrate {
    crateName = "winapi-i686-pc-windows-gnu";
    version = "0.4.0";
    description = "Import libraries for the i686-pc-windows-gnu target. Please don't use this crate directly, depend on winapi instead.";
    authors = [ "Peter Atashian <retep998@gmail.com>" ];
    sha256 = "05ihkij18r4gamjpxj4gra24514can762imjzlmak5wlzidplzrp";
    build = "build.rs";
  };
  features_.winapi_i686_pc_windows_gnu."0.4.0" = deps: f: updateFeatures f (rec {
    winapi_i686_pc_windows_gnu."0.4.0".default = (f.winapi_i686_pc_windows_gnu."0.4.0".default or true);
  }) [];


# end
# winapi-x86_64-pc-windows-gnu-0.4.0

  crates.winapi_x86_64_pc_windows_gnu."0.4.0" = deps: { features?(features_.winapi_x86_64_pc_windows_gnu."0.4.0" deps {}) }: buildRustCrate {
    crateName = "winapi-x86_64-pc-windows-gnu";
    version = "0.4.0";
    description = "Import libraries for the x86_64-pc-windows-gnu target. Please don't use this crate directly, depend on winapi instead.";
    authors = [ "Peter Atashian <retep998@gmail.com>" ];
    sha256 = "0n1ylmlsb8yg1v583i4xy0qmqg42275flvbc51hdqjjfjcl9vlbj";
    build = "build.rs";
  };
  features_.winapi_x86_64_pc_windows_gnu."0.4.0" = deps: f: updateFeatures f (rec {
    winapi_x86_64_pc_windows_gnu."0.4.0".default = (f.winapi_x86_64_pc_windows_gnu."0.4.0".default or true);
  }) [];


# end
# winreg-0.6.2

  crates.winreg."0.6.2" = deps: { features?(features_.winreg."0.6.2" deps {}) }: buildRustCrate {
    crateName = "winreg";
    version = "0.6.2";
    description = "Rust bindings to MS Windows Registry API";
    authors = [ "Igor Shaula <gentoo90@gmail.com>" ];
    sha256 = "0yxz0sph88wsj7cy94kfy17c5jaj0665m3qqll5saqind1fnfb90";
    dependencies = mapFeatures features ([
      (crates."winapi"."${deps."winreg"."0.6.2"."winapi"}" deps)
    ]);
    features = mkFeatures (features."winreg"."0.6.2" or {});
  };
  features_.winreg."0.6.2" = deps: f: updateFeatures f (rec {
    winapi = fold recursiveUpdate {} [
      { "${deps.winreg."0.6.2".winapi}"."handleapi" = true; }
      { "${deps.winreg."0.6.2".winapi}"."impl-debug" = true; }
      { "${deps.winreg."0.6.2".winapi}"."impl-default" = true; }
      { "${deps.winreg."0.6.2".winapi}"."ktmw32" =
        (f.winapi."${deps.winreg."0.6.2".winapi}"."ktmw32" or false) ||
        (winreg."0.6.2"."transactions" or false) ||
        (f."winreg"."0.6.2"."transactions" or false); }
      { "${deps.winreg."0.6.2".winapi}"."minwinbase" = true; }
      { "${deps.winreg."0.6.2".winapi}"."minwindef" = true; }
      { "${deps.winreg."0.6.2".winapi}"."timezoneapi" = true; }
      { "${deps.winreg."0.6.2".winapi}"."winerror" = true; }
      { "${deps.winreg."0.6.2".winapi}"."winnt" = true; }
      { "${deps.winreg."0.6.2".winapi}"."winreg" = true; }
      { "${deps.winreg."0.6.2".winapi}".default = true; }
    ];
    winreg = fold recursiveUpdate {} [
      { "0.6.2"."serde" =
        (f.winreg."0.6.2"."serde" or false) ||
        (f.winreg."0.6.2".serialization-serde or false) ||
        (winreg."0.6.2"."serialization-serde" or false); }
      { "0.6.2"."transactions" =
        (f.winreg."0.6.2"."transactions" or false) ||
        (f.winreg."0.6.2".serialization-serde or false) ||
        (winreg."0.6.2"."serialization-serde" or false); }
      { "0.6.2".default = (f.winreg."0.6.2".default or true); }
    ];
  }) [
    (features_.winapi."${deps."winreg"."0.6.2"."winapi"}" deps)
  ];


# end
# ws2_32-sys-0.2.1

  crates.ws2_32_sys."0.2.1" = deps: { features?(features_.ws2_32_sys."0.2.1" deps {}) }: buildRustCrate {
    crateName = "ws2_32-sys";
    version = "0.2.1";
    description = "Contains function definitions for the Windows API library ws2_32. See winapi for types and constants.";
    authors = [ "Peter Atashian <retep998@gmail.com>" ];
    sha256 = "1zpy9d9wk11sj17fczfngcj28w4xxjs3b4n036yzpy38dxp4f7kc";
    libName = "ws2_32";
    build = "build.rs";
    dependencies = mapFeatures features ([
      (crates."winapi"."${deps."ws2_32_sys"."0.2.1"."winapi"}" deps)
    ]);

    buildDependencies = mapFeatures features ([
      (crates."winapi_build"."${deps."ws2_32_sys"."0.2.1"."winapi_build"}" deps)
    ]);
  };
  features_.ws2_32_sys."0.2.1" = deps: f: updateFeatures f (rec {
    winapi."${deps.ws2_32_sys."0.2.1".winapi}".default = true;
    winapi_build."${deps.ws2_32_sys."0.2.1".winapi_build}".default = true;
    ws2_32_sys."0.2.1".default = (f.ws2_32_sys."0.2.1".default or true);
  }) [
    (features_.winapi."${deps."ws2_32_sys"."0.2.1"."winapi"}" deps)
    (features_.winapi_build."${deps."ws2_32_sys"."0.2.1"."winapi_build"}" deps)
  ];


# end
}
