{
  flake.modules.nixos.desktopEnvironment = {pkgs, ...}: {
    services.displayManager = {
      enable = true;
      sddm = {
        enable = true;
        wayland.enable = true; # this doesn't disable X11 support
        package = pkgs.kdePackages.sddm;
      };
    };

    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };
  };

  flake.modules.homeManager.desktopEnvironment = {pkgs, ...}: {
    # Cursor
    home.pointerCursor = {
      enable = true;
      package = pkgs.capitaine-cursors;
      name = "capitaine-cursors";
      size = 24;
    };

    # Fonts
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

    # Screenlock
    programs.swaylock = {
      enable = true;
      settings = {
        image = ../../assets/wallpaper.png;
        scaling = "fill";
        show-keyboard-layout = false;
      };
    };
  };
}
