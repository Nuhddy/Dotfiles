{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    home-manager
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
    "pipe-operators"
  ];

  nixpkgs.config.allowUnfree = true;
}
