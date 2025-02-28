{...}: {
  imports = [
    ./hardware-configuration.nix
    ../../nixos-modules/core
    ../../nixos-modules/common
    ../../nixos-modules/common/physical.nix
  ];

  boot.loader.grub.gfxmodeEfi = "1920x1080";

  networking.hostName = "octane";

  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia.open = false;

  system.stateVersion = "24.11";
}
