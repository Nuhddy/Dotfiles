{inputs, ...}: {
  flake.modules.homeManager.gui = {
    config,
    pkgs,
    ...
  }: {
    home.packages = with pkgs; [
      # Network
      networkmanagerapplet
      protonvpn-gui

      # File management
      bitwarden-desktop
      nextcloud-client
      thunar
      zotero
      # INFO: https://nixpk.gs/pr-tracker.html?pr=493988
      inputs.nixpkgs-stable.legacyPackages.${pkgs.stdenv.hostPlatform.system}.calibre
      obsidian
      libreoffice

      # Media
      tidal-hifi
      vlc
      streamlink
      pwvucontrol
      musescore

      # TODO: fix this
      # (lib.mkIf config.hostSpec.latex.enable texliveFull)
      typst
      teams-for-linux
      slack
    ];

    programs.thunderbird = {
      enable = true;
      profiles.${config.home.username}.isDefault = true;
    };

    programs.vscode = {
      enable = true;
      package = pkgs.vscodium;
    };

    programs.pandoc.enable = true;

    # Doc reader
    programs.zathura = {
      enable = true;
      options = {
        selection-clipboard = "clipboard";
        guioptions = "";
      };
    };
    programs.sioyek.enable = true;
    home.sessionVariables.READER = "sioyek";
    xdg.mimeApps.defaultApplications."application/pdf" = "sioyek.desktop";

    # Browser
    programs.firefox.enable = true;
    home.sessionVariables.BROWSER = "firefox";
    xdg.mimeApps.defaultApplications."text/html" = "firefox.desktop";
    xdg.mimeApps.defaultApplications."x-scheme-handler/http" = "firefox.desktop";
    xdg.mimeApps.defaultApplications."x-scheme-handler/https" = "firefox.desktop";
    xdg.mimeApps.defaultApplications."x-scheme-handler/about" = "firefox.desktop";
    xdg.mimeApps.defaultApplications."x-scheme-handler/unknown" = "firefox.desktop";

    # Terminals
    programs.kitty = {
      enable = true;
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

    # Discord
    imports = [inputs.nixcord.homeModules.nixcord];

    programs.nixcord = {
      enable = true;
      discord.enable = false;
      vesktop.enable = true;
      quickCss = "@import url(\"https://catppuccin.github.io/discord/dist/catppuccin-mocha.theme.css\");";
      config = {
        useQuickCss = true;
        frameless = true;
        disableMinSize = true;
        # TODO: https://github.com/KaylorBen/nixcord/blob/main/docs/plugins.md
        plugins = {
        };
      };
    };
  };
}
