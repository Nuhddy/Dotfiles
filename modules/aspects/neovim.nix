{
  flake.modules.homeManager.neovim = {
    config,
    pkgs,
    ...
  }: {
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

    xdg.configFile.nvim.source = (import ../../lib/symlink-config.nix {inherit config;}) "nvim";
  };
}
