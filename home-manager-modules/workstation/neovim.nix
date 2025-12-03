{
  config,
  pkgs,
  ...
}: let
  helpers = import ../../lib {inherit config;};
in {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    extraPackages = with pkgs; [
      tree-sitter
      gcc
      lua-language-server
      stylua
      nixd
      alejandra
      black
    ];
  };
  xdg.configFile.nvim.source = helpers.configSymlink "nvim";
}
