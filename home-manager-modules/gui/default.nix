{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    ./browsers.nix
    ./terminals.nix
    ./discord.nix
  ];

  home.packages = with pkgs; [
    # Network
    networkmanagerapplet
    protonvpn-gui

    # File management
    bitwarden-desktop
    nextcloud-client
    xfce.thunar
    zotero
    calibre
    obsidian
    libreoffice

    # Media
    tidal-hifi
    vlc
    streamlink
    pwvucontrol
    musescore

    (lib.mkIf config.hostSpec.latex.enable texliveFull)
    teams-for-linux
  ];

  programs.thunderbird = {
    enable = true;
    profiles.${config.home.username}.isDefault = true;
  };

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
  };

  programs.pandoc.enable = true;

  # Doc reader
  programs.zathura = {
    enable = true;
    options = {
      selection-clipboard = "clipboard";
      guioptions = "";
    };
  };
  home.sessionVariables.READER = "zathura";
}
