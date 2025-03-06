{
  config,
  pkgs,
  inputs,
  system,
  ...
}: let
  helpers = import ../../lib {inherit config;};
in {
  imports = [
    inputs.stylix.homeManagerModules.stylix
    inputs.nixcord.homeManagerModules.nixcord
  ];

  home.packages = with pkgs; [
    pw-volume
    pwvucontrol
    jamesdsp
    playerctl
    tidal-hifi

    texliveFull
    python3

    inputs.zen-browser.packages.${system}.default
    calibre
    obsidian
    lutris
    musescore
    zotero
    bitwarden-desktop
    nextcloud-client
    xfce.thunar
    networkmanagerapplet
    protonvpn-gui
    vlc
    streamlink

    wl-clipboard
    wev
    mako
    rofi-wayland
    wlsunset
    # way-displays
    nwg-look
  ];

  xdg.configFile."jamesdsp/presets".source = helpers.configSymlink "jamesdsp/presets";

  programs.kitty = {
    enable = true;
    themeFile = "Catppuccin-Mocha";
    settings = {
      kitty_mod = "ctrl+shift";

      font_family = "FiraCode Nerd Font Mono";
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";

      disable_ligatures = "cursor";

      cursor_shape = "block";
      cursor_blink_interval = 0;

      scrollback_lines = 10000;

      url_style = "curly";
      url_prefixes = "http https file ftp";

      clipboard_control = "write-clipboard write-primary read-clipboard read-primary";
      copy_on_select = "yes";

      strip_trailing_spaces = "smart";

      enable_audio_bell = "no";

      confirm_os_window_close = 0;

      window_margin_width = 0;
      window_border_width = "1.0";
      window_padding_width = 0;
      hide_window_decorations = "yes";
    };
    keybindings = {
      "kitty_mod+0" = "change_font_size all 0";
      "kitty_mod+equal" = "change_font_size all +1";
      "kitty_mod+minus" = "change_font_size all -1";
      "page_up" = "scroll_page_up";
      "page_down" = "scroll_page_down";
    };
  };
  programs.alacritty.enable = true;

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

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
  };

  programs.pandoc.enable = true;

  programs.zathura.enable = true;
  programs.thunderbird = {
    enable = true;
    profiles."nuhddy".isDefault = true;
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = let
      browser = "zen.desktop";
    in {
      "x-scheme-handler/http" = browser;
      "x-scheme-handler/https" = browser;
      "x-scheme-handler/about" = browser;
      "x-scheme-handler/unknown" = browser;
    };
  };

  home.sessionVariables = {
    BROWSER = "zen";
    READER = "zathura";
  };

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
