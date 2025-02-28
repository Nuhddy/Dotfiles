{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    home-manager
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];

  nixpkgs.config.allowUnfree = true;
}
