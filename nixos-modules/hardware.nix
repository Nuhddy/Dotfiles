{
  config,
  pkgs,
  ...
}: {
  # Bootloader
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        devices = ["nodev"];
        efiSupport = true;
        useOSProber = true;
        default = "saved"; # default to entry used at last boot
        gfxmodeEfi = config.hostSpec.display.resolution;
      };
    };
    kernelPackages = pkgs.linuxPackages_zen;
  };

  # Backlight
  programs.light = {
    enable = true;
    brightnessKeys = {
      enable = true;
      minBrightness = 0;
      step = 5;
    };
  };

  # Audio
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  security.rtkit.enable = true;

  # Networking
  networking.networkmanager.enable = true;
  users.users.nuhddy.extraGroups = ["networkmanager"];

  # Keyring
  services.gnome.gnome-keyring.enable = true;
}
