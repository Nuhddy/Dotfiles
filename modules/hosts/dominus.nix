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
        device = "/dev/disk/by-uuid/e129d3c5-6248-45a0-9e96-0ca34951ac8c";
        fsType = "ext4";
      };

      fileSystems."/boot" = {
        device = "/dev/disk/by-uuid/1EC8-9EC2";
        fsType = "vfat";
        options = ["fmask=0077" "dmask=0077"];
      };

      swapDevices = [
        {device = "/dev/disk/by-uuid/a00d4ccd-c801-4624-bace-b2ddbd549af9";}
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
      "niri"
      "waybar"
      "gaming"
      "gui"
    ];
  };
}
