{
  pkgs,
  inputs,
  system,
  ...
}: {
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        devices = ["nodev"];
        efiSupport = true;
        useOSProber = true;
        default = "saved"; # default to entry used at last boot
      };
    };
    kernelPackages = pkgs.linuxPackages_zen;
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.displayManager = {
    enable = true;
    sddm = {
      enable = true;
      wayland.enable = true;
      package = pkgs.kdePackages.sddm;
    };
  };

  programs.hyprland = let
    hyprland = inputs.hyprland.packages.${system};
  in {
    enable = true;
    package = hyprland.hyprland;
    portalPackage = hyprland.xdg-desktop-portal-hyprland;
  };
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
  };
  programs.gamemode.enable = true;

  environment.systemPackages = with pkgs; [
    catppuccin-sddm
  ];

  boot.kernelParams = [
    "vt.default_red=30,243,166,249,137,245,148,186,88,243,166,249,137,245,148,166"
    "vt.default_grn=30,139,227,226,180,194,226,194,91,139,227,226,180,194,226,173"
    "vt.default_blu=46,168,161,175,250,231,213,222,112,168,161,175,250,231,213,200"
  ];

  services.displayManager.sddm.theme = "catppuccin-mocha";

  services.gnome.gnome-keyring.enable = true;

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Copenhagen";
  console.useXkbConfig = true;
  services.xserver.xkb = {
    layout = "us";
    options = "caps:swapescape";
  };

  users.users.nuhddy.extraGroups = [
    "networkmanager"
  ];
}
