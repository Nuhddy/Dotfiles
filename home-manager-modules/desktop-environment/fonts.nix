{pkgs, ...}: {
  home.packages = with pkgs; [
    nerd-fonts.fira-code
    roboto
    libertinus
    noto-fonts-color-emoji
  ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = ["FiraCode Nerd Font Mono"];
      sansSerif = ["Roboto"];
      serif = ["Libertinus Serif"];
      emoji = ["Noto Color Emoji"];
    };
  };
}
