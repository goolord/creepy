with (import ./default.nix {});

pkgs.lib.overrideDerivation creepy (drv: {
  shellHook = ''
    watch() {
      cargo-watch -x check
    }

    test-runner() {
      cargo-watch -x check -x tests
    }
  '';
})
