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
    layout = "us,dk";
    options = "caps:swapescape,grp:ctrl_space_toggle";
  };

  time.timeZone = "Europe/Copenhagen";
}
