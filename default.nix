{ pkgs ? import ./nix/nixpkgs.nix }:

with pkgs;
with buildRustCrateHelpers;

rec {
  inherit pkgs;

  creepy = ((import ./nix/Cargo.nix).creepy {}).override {
    crateOverrides = defaultCrateOverrides // {
      creepy = attrs: {

        buildInputs = [
          openssl
        ];

        nativeBuildInputs = [
          latest.rustChannels.nightly.rust
          cargo-watch
          pkg-config
        ];

      };
    };
  };
}
