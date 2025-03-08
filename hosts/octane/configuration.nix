{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ../../nixos-modules/core
    ../../nixos-modules/common
    ../../nixos-modules/desktop-environment
  ];
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        devices = ["nodev"];
        efiSupport = true;
        useOSProber = true;
        default = "saved"; # default to entry used at last boot
        gfxmodeEfi = "1920x1080";
      };
    };
    kernelPackages = pkgs.linuxPackages_zen;
    kernelParams = [
      "vt.default_red=30,243,166,249,137,245,148,186,88,243,166,249,137,245,148,166"
      "vt.default_grn=30,139,227,226,180,194,226,194,91,139,227,226,180,194,226,173"
      "vt.default_blu=46,168,161,175,250,231,213,222,112,168,161,175,250,231,213,200"
    ];
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  security.rtkit.enable = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia.open = false;

  services.gnome.gnome-keyring.enable = true;

  time.timeZone = "Europe/Copenhagen";

  console.useXkbConfig = true;
  services.xserver.xkb = {
    layout = "us";
    options = "caps:swapescape";
  };

  networking.networkmanager.enable = true;
  users.users.nuhddy.extraGroups = [
    "networkmanager"
  ];

  networking.hostName = "octane";

  system.stateVersion = "24.11";
}
