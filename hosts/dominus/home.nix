{...}: {
  imports = [
    ../../home-manager-modules/core.nix

    ../../home-manager-modules/hardware.nix
    ../../home-manager-modules/workstation
    ../../home-manager-modules/desktop-environment
    ../../home-manager-modules/gui
  ];

  home.stateVersion = "25.05";
}
