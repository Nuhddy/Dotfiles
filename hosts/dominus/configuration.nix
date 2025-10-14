{...}: {
  imports = [
    ./hardware-configuration.nix
    ../../nixos-modules/core.nix

    ../../nixos-modules/hardware.nix
    ../../nixos-modules/workstation.nix
    ../../nixos-modules/desktop-environment.nix
    ../../nixos-modules/gaming.nix
  ];

  networking.hostName = "dominus";
  system.stateVersion = "25.05";
}
