{
  self,
  inputs,
  ...
}: {
  flake.modules.nixos.niri = {pkgs, ...}: {
    imports = [
      inputs.niri.nixosModules.niri
    ];

    programs.niri = {
      enable = true;
      package = pkgs.niri;
    };

    environment.sessionVariables.NIXOS_OZONE_WL = "1";
  };

  flake.modules.homeManager.niri = {
    config,
    pkgs,
    ...
  }: let
    apps = import ./scripts.nix {inherit pkgs;};
  in {
    imports = [self.modules.homeManager.waybar];

    home.packages = with pkgs; [
      wl-clipboard
      wev
      mako
      rofi
      nwg-look
      swww
      lswt
      wlsunset
      waybar
    ];

    services.swww = {
      enable = true;
    };

    programs.niri = {
      settings = let
        jamesdsp = "${pkgs.jamesdsp}/bin/jamesdsp";
        playerctl = apps.playerctl-specific-player;
        pw-volume = "${pkgs.pw-volume}/bin/pw-volume";
      in {
        input = {
          keyboard = {
            xkb = {
              layout = "us,dk";
              options = "caps:swapescape,grp:ctrl_space_toggle";
            };
            repeat-delay = 300;
            repeat-rate = 50;
            track-layout = "global";
          };
          touchpad = {
            tap = true;
            dwt = true;
            drag = true;
            natural-scroll = true;
            accel-profile = "flat";
            scroll-method = "two-finger";
            click-method = "clickfinger";
            disabled-on-external-mouse = true;
          };
          mouse.accel-profile = "flat";
          power-key-handling.enable = false;
          mod-key = "Super";
        };

        cursor.hide-after-inactive-ms = 10000;

        gestures.hot-corners.enable = false;

        /*
           outputs."${config.hostSpec.display.name}".mode = {
          width = config.hostSpec.display.width;
          height = config.hostSpec.display.height;
          refresh = 0.0 + config.hostSpec.display.refreshRate;
        };
        */
        outputs."eDP-1".mode = {
          width = 1920;
          height = 1080;
          refresh = 0.0 + 60;
        };

        layout = {
          gaps = 8;
          background-color = "transparent";
          border = {
            enable = true;
            width = 2;
            active = {color = "#89b4fa";};
            inactive = {color = "#585b70";};
            urgent = {color = "#f38ba8";};
          };
          focus-ring.enable = false;
          tab-indicator = {
            position = "top";
            length.total-proportion = 0.4;
            width = 8;
            gap = 8;
            corner-radius = 4;
            place-within-column = true;
            gaps-between-tabs = 16;
          };
          default-column-width = {proportion = 0.5;};
        };

        overview = {
          zoom = 0.65;
          workspace-shadow.enable = false;
        };

        prefer-no-csd = true;

        layer-rules = [
          {
            matches = [{namespace = "swww-daemon";}];
            place-within-backdrop = true;
          }
        ];

        window-rules = [
          {
            geometry-corner-radius = let
              r = 10.0;
            in {
              top-left = r;
              top-right = r;
              bottom-left = r;
              bottom-right = r;
            };
            clip-to-geometry = true;
          }
        ];

        spawn-at-startup = [
          {argv = ["${pkgs.waybar}/bin/waybar"];}
          {argv = ["${pkgs.swww}/bin/swww" "img" "../../assets/wallpaper.png"];}
          {argv = ["${pkgs.mako}/bin/mako"];}
          {argv = ["${jamesdsp}" "-t"];}
          {argv = ["${pkgs.bitwarden-desktop}/bin/bitwarden"];}
          {argv = ["${pkgs.nextcloud-client}/bin/nextcloud"];}
          {argv = ["${pkgs.networkmanager}/bin/nm-applet"];}
          {argv = ["${pkgs.wlsunset}/bin/wlsunset" "-t" "3400" "-T" "6500" "-l" "55.7" "-L" "11.7"];}
        ];

        hotkey-overlay.skip-at-startup = true;

        binds = with config.lib.niri.actions; {
          "Mod+Return" = {
            action = spawn "kitty" "-1";
            hotkey-overlay.title = "Spawn terminal";
          };
          "Mod+Space" = {
            action = spawn "rofi" "-show" "drun";
            hotkey-overlay.title = "Spawn launcher";
          };
          "Mod+E" = {
            action = spawn "thunar";
            hotkey-overlay.title = "Spawn file explorer";
          };

          "Mod+Shift+Q".action = close-window;
          "Mod+S".action = toggle-window-floating;
          "Mod+F".action = fullscreen-window;

          "Alt+Tab".action = focus-window-previous;
          "Mod+H".action = focus-column-left;
          "Mod+L".action = focus-column-right;
          "Mod+J".action = focus-window-down;
          "Mod+K".action = focus-window-up;

          "Mod+Shift+H".action = move-column-left;
          "Mod+Shift+L".action = move-column-right;
          "Mod+Shift+J".action = move-window-down;
          "Mod+Shift+K".action = move-window-up;

          "Mod+Ctrl+H".action = consume-or-expel-window-left;
          "Mod+Ctrl+L".action = consume-or-expel-window-right;

          "Mod+Ctrl+J".action = move-window-to-workspace-down;
          "Mod+Ctrl+K".action = move-window-to-workspace-up;

          "Mod+Minus".action = set-column-width "-5%";
          "Mod+Equal".action = set-column-width "+5%";

          "Win+Tab".action = maximize-column;
          "Win+Shift+Tab".action = toggle-column-tabbed-display;

          # TODO: find suitable hotkeys
          # "Volume Up" = {
          #   action = spawn "${pw-volume}" "change" "+5%";
          #   allow-when-locked = true;
          #   hotkey-overlay.title = "Raise volume";
          # };
          # "Volume Down" = {
          #   action = spawn "${pw-volume}" "change" "-5%";
          #   allow-when-locked = true;
          #   hotkey-overlay.title = "Lower volume";
          # };
          # "Volume Mute" = {
          #   action = spawn "${pw-volume}" "mute" "toggle";
          #   allow-when-locked = true;
          #   hotkey-overlay.title = "Toggle mute";
          # };
          # "Play" = {
          #   action = spawn "${playerctl}" "play-pause";
          #   allow-when-locked = true;
          #   hotkey-overlay.title = "Play/pause track";
          # };
          # "Prev" = {
          #   action = spawn "${playerctl}" "previous";
          #   allow-when-locked = true;
          #   hotkey-overlay.title = "Previous track";
          # };
          # "Next" = {
          #   action = spawn "${playerctl}" "next";
          #   allow-when-locked = true;
          #   hotkey-overlay.title = "Next track";
          # };
          "Mod+Bracketleft" = {
            action = spawn "${jamesdsp}" "--load-preset" "Flat";
            allow-when-locked = true;
            hotkey-overlay.title = "Equalizer preset: Flat";
          };
          "Mod+Bracketright" = {
            action = spawn "${jamesdsp}" "--load-preset" "Headphones";
            allow-when-locked = true;
            hotkey-overlay.title = "Equalizer preset: Headphones";
          };

          "Mod+F1".action = show-hotkey-overlay;
          "Mod+Ctrl+Shift+E".action = quit;
        };
        switch-events = with config.lib.niri.actions; {
          lid-close.action = spawn "${pkgs.swaylock}/bin/swaylock";
        };
      };
    };
  };
}
