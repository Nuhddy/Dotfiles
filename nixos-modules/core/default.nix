{...}: {
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
    "pipe-operators"
    "ca-derivations"
  ];

  nixpkgs.config.allowUnfree = true;
}
