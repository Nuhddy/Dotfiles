{inputs, ...}: {
  imports = [
    inputs.nixcord.homeModules.nixcord
  ];

  programs.nixcord = {
    enable = true;
    quickCss = "@import url(\"https://catppuccin.github.io/discord/dist/catppuccin-mocha.theme.css\");";
    config = {
      useQuickCss = true;
      frameless = true;
      disableMinSize = true;
      # TODO: https://github.com/KaylorBen/nixcord/blob/main/docs/plugins.md
      plugins = {
        imageZoom.enable = true;
      };
    };
  };
}
