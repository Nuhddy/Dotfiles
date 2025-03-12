{pkgs, ...}: {
  imports = [
    ./hyprland.nix
    ./waybar.nix
    ./awesomewm.nix
    ./terminal.nix
    ./discord.nix
    ./browser.nix
    ./stylix.nix
  ];

  home.packages = with pkgs; [
    # Video
    vlc
    streamlink

    # Audio
    pwvucontrol
    tidal-hifi

    # Network
    networkmanagerapplet
    protonvpn-gui

    # Apps
    calibre
    obsidian
    lutris
    musescore
    zotero
    bitwarden-desktop
    nextcloud-client
    xfce.thunar
  ];

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
  };

  programs.zathura.enable = true;
  home.sessionVariables.READER = "zathura";

  programs.thunderbird = {
    enable = true;
    profiles."nuhddy".isDefault = true;
  };
}
