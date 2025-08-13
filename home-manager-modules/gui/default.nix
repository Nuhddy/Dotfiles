{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    ./browsers.nix
    ./terminals.nix
    # ./discord.nix
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

    # Media
    vlc
    streamlink
    pwvucontrol
    musescore

    (lib.mkIf config.hostSpec.latex.enable texliveFull)
  ];

  programs.thunderbird = {
    enable = true;
    profiles."nuhddy".isDefault = true;
  };

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
  };

  programs.pandoc.enable = true;

  # Doc reader
  programs.zathura.enable = true;
  home.sessionVariables.READER = "zathura";
}
