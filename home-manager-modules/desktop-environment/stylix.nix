{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.stylix.homeManagerModules.stylix
  ];

  stylix = {
    enable = true;
    image = ../../assets/wallpaper.png;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    polarity = "dark";
    cursor = {
      package = pkgs.capitaine-cursors;
      name = "capitaine-cursors";
      size = 24;
    };
    fonts = with pkgs; {
      serif.package = libertinus;
      serif.name = "Libertinus Serif";
      sansSerif.package = roboto;
      sansSerif.name = "Roboto";
      monospace.package = nerd-fonts.fira-code;
      monospace.name = "FiraCode Nerd Font Mono";
      emoji.package = noto-fonts-color-emoji;
      emoji.name = "Noto Color Emoji";
    };
    targets = {
      neovim.enable = false;
      kitty.enable = false;
    };
  };
}
