{
  config,
  pkgs,
  inputs,
  secrets,
  ...
}: let
  helpers = import ../../util/helpers.nix {inherit config;};
in {
  home.username = "nuhddy";
  home.homeDirectory = "/home/nuhddy";

  imports = [
    inputs.stylix.homeManagerModules.stylix
    inputs.nixcord.homeManagerModules.nixcord
    ../../home-manager-modules/neovim.nix
  ];

  home.packages = with pkgs; [
    # Programs
    inputs.zen-browser.packages.${system}.default
    calibre
    obsidian
    # discord
    lutris
    musescore
    zotero
    bitwarden-desktop
    nextcloud-client

    # CLI
    wget
    curl
    tree
    wl-clipboard
    nix-output-monitor
    p7zip
    nurl
    unzip
    wev
    parted
    git-crypt

    # DE
    mako
    rofi-wayland
    wlsunset
    # way-displays
    xfce.thunar
    nwg-look

    # Network
    networkmanagerapplet
    speedtest-cli
    protonvpn-gui

    # Audio
    pw-volume
    pwvucontrol
    jamesdsp
    playerctl
    tidal-hifi

    # Video
    vlc
    streamlink

    # Other
    texliveFull
    python3
  ];
  programs.alacritty.enable = true;
  programs.fastfetch.enable = true;
  programs.btop.enable = true;
  programs.bat.enable = true;
  programs.gh = {
    enable = true;
    settings.git_protocol = "ssh";
  };
  programs.jq.enable = true;
  programs.pandoc.enable = true;
  programs.zathura.enable = true;
  programs.eza = {
    enable = true;
    git = true;
    icons = "auto";
    extraOptions = [
      "--group-directories-first"
      "--header"
    ];
  };
  programs.ripgrep.enable = true;
  programs.dircolors.enable = true;
  programs.ranger.enable = true;
  programs.tmux.enable = true;
  programs.ssh.enable = true;
  programs.waybar = {
    enable = true;
    settings.mainBar = {
      layer = "top";
      position = "top";
      height = 30;
      output = ["DP-2"];
      modules-left = ["hyprland/workspaces"];
      modules-right = [
        "tray"
        "pulseaudio"
        "network"
        "clock"
      ];
      "hyprland/workspaces" = {
        persistent-workspaces = {"*" = 5;};
      };
      tray.spacing = 10;
      pulseaudio = {
        format = "{icon}";
        format-icons.default = ["" "" ""];
        format-muted = "";
        scroll-step = 5.0;
        on-click = "pw-volume mute toggle";
        on-click-right = "pwvucontrol";
        ignored-sinks = ["JamesDSP Sink"];
      };
      network = {
        format = "{icon}";
        format-wifi = "";
        format-ethernet = "󰌘";
        format-disconnected = "󰌙";
        tooltip-format-wifi = "{essid}: {signalStrength}";
        tooltip-format-ethernet = "{ipaddr}";
        tooltip-format-disconnect = "No internet connection";
      };
      clock.tooltip = false;
    };
  };
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
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    defaultKeymap = "viins";
    dotDir = ".config/zsh";
  };
  programs.thunderbird = {
    enable = true;
    profiles."nuhddy".isDefault = true;
  };
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
  };
  programs.git = {
    enable = true;
    userEmail = secrets.email;
    userName = "Nuhddy";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
    };
    mimeApps = {
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
  };

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = ", highrr, auto, auto";
      exec-once = [
        "mako"
        "hyprctl setcursor capitaine-cursors 24"
        "waybar"
        "~/.bin/wlsunset.sh on"
        "jamesdsp -t"
        "bitwarden"
        "nextcloud"
        "nm-applet"
      ];
      general = {
        gaps_in = 3;
        gaps_out = 6;
        border_size = 1;
        layout = "master";
      };
      decoration = {
        rounding = 6;
        shadow.enabled = false;
        blur.enabled = false;
      };
      animations = {
        enabled = false;
        first_launch_animation = false;
      };
      input = {
        kb_layout = "us";
        kb_options = "caps:swapescape";
        follow_mouse = 2;
        accel_profile = "flat";
      };
      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        font_family = "Roboto";
        enable_swallow = true;
        swallow_regex = "^(kitty)$";
        swallow_exception_regex = "^(wev)$";
      };
      cursor = {
        no_warps = true;
        inactive_timeout = 10;
        enable_hyprcursor = false;
      };
      master = {
        mfact = 0.6;
        orientation = "right";
      };
      bind = [
        "SUPER, 1, workspace, 1"
        "SUPER, 2, workspace, 2"
        "SUPER, 3, workspace, 3"
        "SUPER, 4, workspace, 4"
        "SUPER, 5, workspace, 5"

        "SUPER SHIFT, 1, movetoworkspacesilent, 1"
        "SUPER SHIFT, 2, movetoworkspacesilent, 2"
        "SUPER SHIFT, 3, movetoworkspacesilent, 3"
        "SUPER SHIFT, 4, movetoworkspacesilent, 4"
        "SUPER SHIFT, 5, movetoworkspacesilent, 5"

        "SUPER, h, movefocus, l"
        "SUPER, j, movefocus, d"
        "SUPER, k, movefocus, u"
        "SUPER, l, movefocus, r"

        "SUPER SHIFT, h, movewindow, l"
        "SUPER SHIFT, j, movewindow, d"
        "SUPER SHIFT, k, movewindow, u"
        "SUPER SHIFT, l, movewindow, r"

        "SUPER, Left, resizeactive, -96 0"
        "SUPER, Right, resizeactive, 96 0"
        "SUPER, Up, resizeactive, 0 -105"
        "SUPER, Down, resizeactive, 0 105"

        "SUPER, s, togglefloating"
        "SUPER, Tab, fullscreen, 1"

        "SUPER SHIFT, q, killactive"

        "SUPER SHIFT, e, exit"

        "SUPER, Return, exec, kitty -1"
        "SUPER, space, exec, rofi -show drun"
        "SUPER, e, exec, thunar"
      ];
      bindl = [
        "SUPER, Delete, exec, ~/.bin/playerctl-specific-player.sh previous"
        "SUPER, End, exec, ~/.bin/playerctl-specific-player.sh play-pause"
        "SUPER, Next, exec, ~/.bin/playerctl-specific-player.sh next"

        "SUPER, bracketleft, exec, jamesdsp --load-preset Flat"
        "SUPER, bracketright, exec, jamesdsp --load-preset Headphones"

        "ALT, End, exec, ~/.bin/wlsunset.sh toggle"
      ];
      bindm = [
        "SUPER, mouse:272, movewindow"
        "SUPER, mouse:273, resizewindow"
      ];
      windowrule = [
        "workspace 4, ^(discord)$"
        "workspace 5, ^(tidal-hifi)$"
      ];
    };
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

  xdg.configFile."jamesdsp/presets".source = helpers.configSymlink "jamesdsp/presets";

  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "zen";
    READER = "zathura";
  };
  home.shellAliases = {
    sudo = "sudo ";
    sv = "systemctl";
    cat = "bat";

    ls = "eza";
    la = "eza -la";
    ls1 = "eza -1";
    la1 = "eza -1a";
  };

  # Home Manager stuff
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfreePredicate = _: true;

  home.stateVersion = "24.11";
}
