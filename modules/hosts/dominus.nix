{
  inputs,
  lib,
  config,
  ...
}: let
  host = "dominus";
  user = "nuhddy";
in {
  flake.nixosConfigurations.${host} = (import ../../lib/mk-configuration.nix {inherit inputs lib config;}) {
    inherit host user;
    nixosStateVersion = "25.05";
    homeManagerStateVersion = "25.05";
    nixosConfig = {
      config,
      modulesPath,
      ...
    }: {
      imports = [
        (modulesPath + "/installer/scan/not-detected.nix")
      ];

      boot.initrd.availableKernelModules = ["xhci_pci" "nvme"];
      boot.initrd.kernelModules = [];
      boot.kernelModules = ["kvm-intel"];
      boot.extraModulePackages = [];

      fileSystems."/" = {
        device = "/dev/disk/by-uuid/8a95df7d-e9d9-4224-b6d1-9639eed40418";
        fsType = "ext4";
      };

      fileSystems."/boot" = {
        device = "/dev/disk/by-uuid/60D9-D98E";
        fsType = "vfat";
        options = ["fmask=0077" "dmask=0077"];
      };

      swapDevices = [
        {device = "/dev/disk/by-uuid/5f3ab4e3-6698-4aad-bcb6-a53e1e802284";}
      ];

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    };
    homeManagerConfig = {
    };
    aspects = [
      "base"
      "workstation"
      "neovim"
      "hardware"
      "desktopEnvironment"
      "quickshell"
      "niri"
      "gaming"
      "gui"
    ];
  };
}
