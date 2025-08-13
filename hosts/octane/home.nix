{...}: {
  imports = [
    ../../home-manager-modules/core.nix

    ../../home-manager-modules/hardware.nix
    ../../home-manager-modules/workstation
    ../../home-manager-modules/desktop-environment
    ../../home-manager-modules/gui
    ../../home-manager-modules/gaming.nix
  ];

  home.stateVersion = "24.11";
}
