{
  config,
  pkgs,
  inputs,
  ...
}: let
  helpers = import ../../lib {inherit config;};
in {
  imports = [
    inputs.catppuccin.homeModules.catppuccin
  ];

  home.packages = with pkgs; [
    curl
    tree
    nix-output-monitor
    p7zip
    nurl
    unzip
    speedtest-cli
    just
    pw-volume
    jamesdsp
    playerctl
    texliveFull
    python3
  ];
  xdg.configFile."jamesdsp/presets".source = helpers.configSymlink "jamesdsp/presets";

  programs.pandoc.enable = true;
  programs.fastfetch.enable = true;
  programs.btop.enable = true;
  programs.bat.enable = true;
  programs.gh = {
    enable = true;
    settings.git_protocol = "ssh";
  };
  programs.jq.enable = true;
  programs.eza = {
    enable = true;
    git = true;
    icons = "auto";
    extraOptions = [
      "--group-directories-first"
      "--header"
    ];
  };
  programs.ripgrep.enable = true;
  programs.dircolors.enable = true;
  programs.ranger.enable = true;
  programs.tmux.enable = true;
  programs.ssh.enable = true;
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    defaultKeymap = "viins";
    dotDir = ".config/zsh";
  };

  xdg.enable = true;
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

  home.shellAliases = {
    sudo = "sudo ";
    sv = "systemctl";
    cat = "bat";

    ls = "eza";
    la = "eza -la";
    ls1 = "eza -1";
    la1 = "eza -1a";
  };

  catppuccin = {
    enable = true;
    accent = "blue";
    nvim.enable = false;
  };
}
