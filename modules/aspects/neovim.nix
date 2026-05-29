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
      withPython3 = false;
      withRuby = false;
      extraPackages = with pkgs; [
        tree-sitter
        gcc
        lua-language-server
        stylua
        nixd
        alejandra
        black
        fantomas
        typstyle
      ];
    };

    # TODO: look into config wrapper
    # xdg.configFile.nvim.source = (import ../../lib/symlink-config.nix {inherit config;}) "nvim";
  };
}
