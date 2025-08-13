{...}: {
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
    "pipe-operators"
    "ca-derivations"
  ];

  nixpkgs.config.allowUnfree = true;

  console.useXkbConfig = true;
  services.xserver.xkb = {
    layout = "us";
    options = "caps:swapescape";
  };

  time.timeZone = "Europe/Copenhagen";
}
