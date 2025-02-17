{
  config,
  pkgs,
  inputs,
  system,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  # Compositor
  programs.hyprland = let
    hyprland = inputs.hyprland.packages.${system};
  in {
    enable = true;
    package = hyprland.hyprland;
    portalPackage = hyprland.xdg-desktop-portal-hyprland;
  };
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Packages
  environment.systemPackages = with pkgs; [
    home-manager
    catppuccin-sddm
  ];

  # Shell
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # Boot
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        devices = ["nodev"];
        efiSupport = true;
        useOSProber = true;
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

  # Security
  services.gnome.gnome-keyring.enable = true;
  security.sudo = {
    enable = true;
    package = pkgs.sudo.override {withInsults = true;};
    extraConfig = "Defaults pwfeedback";
  };

  # Networking
  networking.hostName = "octane";
  networking.networkmanager.enable = true;
  services.openssh.enable = true;

  # Localization
  time.timeZone = "Europe/Copenhagen";
  i18n.defaultLocale = "en_US.UTF-8";
  console.useXkbConfig = true;
  services.xserver.xkb = {
    layout = "us";
    options = "caps:swapescape";
  };

  # Audio
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Graphics
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia.open = false;

  # Gaming
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
  };
  programs.gamemode.enable = true;

  # Display manager
  services.displayManager = {
    enable = true;
    sddm = {
      enable = true;
      wayland.enable = true;
      theme = "catppuccin-mocha";
      package = pkgs.kdePackages.sddm;
    };
  };

  # Users
  users.users.nuhddy = {
    description = "Nuhddy";
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
  };

  # Nix stuff
  programs.nh = {
    enable = true;
    flake = "/home/nuhddy/.config/nixos";
  };
  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "24.11";
}
