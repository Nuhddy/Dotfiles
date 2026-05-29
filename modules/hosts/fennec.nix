{
  inputs,
  lib,
  config,
  ...
}: let
  host = "fennec";
in {
  flake.nixosConfigurations.${host} = (import ../../lib/mk-configuration.nix {inherit inputs lib config;}) {
    inherit host;
    nixosStateVersion = "25.11";
    homeManagerStateVersion = "25.11";
    nixosConfig = {
      config,
      modulesPath,
      ...
    }: {
      imports = [
        (modulesPath + "/installer/scan/not-detected.nix")
      ];

      boot.initrd.availableKernelModules = ["nvme" "xhci_pci" "ahci" "usbhid" "sd_mod"];
      boot.initrd.kernelModules = [];
      boot.kernelModules = ["kvm-amd"];
      boot.extraModulePackages = [];

      fileSystems."/" = {
        device = "/dev/disk/by-uuid/9e408f75-29a1-4f22-a388-cb15b1e2a9f5";
        fsType = "ext4";
      };

      fileSystems."/boot" = {
        device = "/dev/disk/by-uuid/DEA1-011E";
        fsType = "vfat";
        options = ["fmask=0077" "dmask=0077"];
      };

      swapDevices = [
        {device = "/dev/disk/by-uuid/5f1f8e40-22b4-4ea4-89f4-83bebf0737d5";}
      ];

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

      services.xserver.videoDrivers = ["nvidia"];
      hardware.nvidia.open = false;
    };
    aspects = [
      "base"
      "workstation"
      "neovim"
      "hardware"
      "desktopEnvironment"
      "niri"
      "gaming"
      "gui"
    ];
  };
}
