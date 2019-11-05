with {
  moz_overlay = import (builtins.fetchTarball https://github.com/mozilla/nixpkgs-mozilla/archive/master.tar.gz);
  cargoWatchPkgs =
    let rev = "a692029726e85656dec6e350b9c4a90cfa0c43b8";
        sha256 = "0ainy1akw2iisz73c6ykpxi5ffk4nrr9y9jz65msmi5l8zhw4016";
    in import (builtins.fetchTarball {
        url = "https://github.com/NixOS/nixpkgs/archive/${rev}.tar.gz";
        inherit sha256;
      }) { config = {}; overlays = []; };
};

with rec {
  rev = "658eed76bbf836cdb72e554fee85233fed27f2a8";
  sha256 = "0dq8ckm1z3824ib9wb7lrg53sjdnbqbj49m12jzrb3qq7717d3ic";

  config = {
    allowUnfree = true;
    allowBroken = true;
  };

  overlays = [
    moz_overlay
    (self: super: {
      cargo-watch = cargoWatchPkgs.cargo-watch;
    })
  ];
};

import (builtins.fetchTarball {
  url = "https://github.com/NixOS/nixpkgs-channels/archive/${rev}.tar.gz";
  inherit sha256;
}) { inherit config overlays; }

