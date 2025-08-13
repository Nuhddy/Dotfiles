{...}: {
  imports = [
    ./hardware-configuration.nix
    ../../nixos-modules/core.nix

    ../../nixos-modules/hardware.nix
    ../../nixos-modules/workstation.nix
    ../../nixos-modules/desktop-environment.nix
    ../../nixos-modules/gaming.nix
  ];

  networking.hostName = "octane";
  system.stateVersion = "24.11";

  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia.open = false;
}
