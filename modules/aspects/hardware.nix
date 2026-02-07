{
  flake.modules.nixos.hardware = {
    config,
    lib,
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
          default = "saved";
          # gfxmodeEfi = "${toString config.hostSpec.display.width}x${toString config.hostSpec.display.height}";
          gfxmodeEfi = "1920x1080";
        };
      };
      kernelPackages = pkgs.linuxPackages_zen;
    };

    # Power management
    services.auto-cpufreq = lib.mkIf (config.networking.hostName == "dominus") {
      enable = true;
      settings = {
        battery = {
          governor = "powersave";
          turbo = "auto";
        };
        charger = {
          governor = "performance";
          turbo = "always";
        };
      };
    };

    # Power buttons
    services.logind.settings.Login = {
      HandleLidSwitch = lib.mkIf (config.networking.hostName == "dominus") "suspend";
      HandlePowerKey = "suspend";
      HandleSuspendKey = "suspend";
    };

    # Backlight
    programs.light = lib.mkIf (config.networking.hostName == "dominus") {
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

    # Bluetooth
    hardware.bluetooth.enable = true;
    services.blueman.enable = true;

    # Networking
    networking.networkmanager.enable = true;
    users.users.nuhddy.extraGroups = ["networkmanager"];

    # Keyring
    services.gnome.gnome-keyring.enable = true;
  };

  flake.modules.homeManager.hardware = {
    config,
    pkgs,
    ...
  }: {
    home.packages = with pkgs; [
      pw-volume
      jamesdsp
      playerctl
    ];

    xdg.configFile."jamesdsp/presets".source = (import ../../lib/symlink-config.nix {inherit config;}) "jamesdsp/presets";
  };
}
