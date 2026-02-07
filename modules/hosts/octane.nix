{
  inputs,
  lib,
  config,
  ...
}: let
  host = "octane";
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
        device = "/dev/disk/by-uuid/da827ee2-369f-4d55-a15d-f1bc90c595f7";
        fsType = "ext4";
      };

      fileSystems."/boot" = {
        device = "/dev/disk/by-uuid/4246-06A1";
        fsType = "vfat";
        options = ["fmask=0077" "dmask=0077"];
      };

      swapDevices = [
        {device = "/dev/disk/by-uuid/3f223b40-70ee-4b03-9b5f-31a47ef6365e";}
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
