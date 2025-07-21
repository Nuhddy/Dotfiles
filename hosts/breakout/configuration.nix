{pkgs, ...}: {
  imports = [
    # TODO: disko stuff
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

  networking.hostName = "breakout";

  system.stateVersion = "25.05";
}
