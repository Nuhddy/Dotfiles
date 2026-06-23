{
  self,
  inputs,
  ...
}: {
  perSystem = {pkgs, ...}: {
    packages.myNeovim = inputs.wrappers.wrappers.neovim.wrap {
      inherit pkgs;

      settings.config_directory = ../../configs/nvim;

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
  };
  flake.modules.homeManager.neovim = {pkgs, ...}: {
    home.packages = [self.packages.${pkgs.stdenv.hostPlatform.system}.myNeovim];
  };
  # flake.modules.homeManager.neovim = {
  #   config,
  #   pkgs,
  #   ...
  # }: {
  #   programs.neovim = {
  #     enable = true;
  #     defaultEditor = true;
  #     viAlias = true;
  #     vimAlias = true;
  #     vimdiffAlias = true;
  #     withPython3 = false;
  #     withRuby = false;
  #     extraPackages = with pkgs; [
  #       tree-sitter
  #       gcc
  #       lua-language-server
  #       stylua
  #       nixd
  #       alejandra
  #       black
  #       fantomas
  #       typstyle
  #     ];
  #   };
  #
  #   # TODO: look into config wrapper
  #   # xdg.configFile.nvim.source = (import ../../lib/symlink-config.nix {inherit config;}) "nvim";
  # };
}
