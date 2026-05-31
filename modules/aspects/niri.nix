{
  self,
  inputs,
  ...
}: {
  flake.modules.nixos.niri = {
    pkgs,
    lib,
    ...
  }: {
    programs.niri = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri;
    };
  };

  flake.modules.homeManager.niri = {
    pkgs,
    ...
  }: {
    home.packages = with pkgs; [
      self.packages.${pkgs.stdenv.hostPlatform.system}.myNoctalia
      wl-clipboard
      wev
      lswt
      nwg-look
    ];
  };

  perSystem = {
    pkgs,
    lib,
    self',
    ...
  }: {
    packages.myNiri = inputs.wrappers.wrappers.niri.wrap {
      inherit pkgs;

      settings = {
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
            tap = _: {};
            dwt = _: {};
            drag = true;
            natural-scroll = _: {};
            accel-profile = "flat";
            scroll-method = "two-finger";
            click-method = "clickfinger";
            disabled-on-external-mouse = _: {};
          };
          mouse.accel-profile = "flat";
          disable-power-key-handling = _: {};
          mod-key = "Super";
        };

        cursor.hide-after-inactive-ms = 10000;

        gestures.hot-corners.off = _: {};

        outputs."DP-2" = {
          mode = "1920x1080@144.001";
          variable-refresh-rate = _: {};
          # scale = 1.25;
        };

        xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

        layout = {
          gaps = 8;
          background-color = "transparent";
          border = {
            width = 2;
            active-color = "#89b4fa";
            inactive-color = "#585b70";
            urgent-color = "#f38ba8";
          };
          focus-ring.off = _: {};
          tab-indicator = {
            position = "top";
            length = _: {total-proportion = 0.4;};
            width = 8;
            gap = 8;
            corner-radius = 4;
            place-within-column = true;
            gaps-between-tabs = 16;
          };
          default-column-width.proportion = 0.5;
        };

        overview = {
          zoom = 0.65;
          workspace-shadow.off = _: {};
        };

        prefer-no-csd = _: {};

        layer-rules = [
          {
            matches = [{namespace = "^noctalia-wallpaper*";}];
            place-within-backdrop = true;
          }
        ];

        window-rules = [
          {
            geometry-corner-radius = 10.0;
            clip-to-geometry = true;
          }
        ];

        spawn-at-startup = [
          (lib.getExe self'.packages.myNoctalia)
          [(lib.getExe pkgs.jamesdsp) "-t"]
          (lib.getExe pkgs.bitwarden-desktop)
          (lib.getExe pkgs.nextcloud-client)
        ];

        hotkey-overlay.skip-at-startup = _: {};

        binds = let
          noctalia-call = x: [(lib.getExe self'.packages.myNoctalia) "ipc" "call"] ++ x;

          eq-notify = {name, icon}: ''
            ${lib.getExe pkgs.jamesdsp} --load-preset ${name}; \
            ${lib.getExe self'.packages.myNoctalia} ipc call toast send \
            '${
	      builtins.toJSON {
                title = "Equalizer";
                body = "EQ preset changed to ${name}";
	        inherit icon;
              }
	    }'
          '';
        in {
          "Mod+Return".spawn = [(lib.getExe pkgs.kitty) "-1"];
          "Mod+Space".spawn = noctalia-call ["launcher" "toggle"];
          "Mod+E".spawn = lib.getExe pkgs.thunar;

          "Mod+Shift+Q".close-window = _: {};
          "Mod+S".toggle-window-floating = _: {};
          "Mod+F".fullscreen-window = _: {};

          "Alt+Tab".focus-window-previous = _: {};
          "Mod+H".focus-column-left = _: {};
          "Mod+L".focus-column-right = _: {};
          "Mod+J".focus-window-down = _: {};
          "Mod+K".focus-window-up = _: {};

          "Mod+Shift+H".move-column-left = _: {};
          "Mod+Shift+L".move-column-right = _: {};
          "Mod+Shift+J".move-window-down = _: {};
          "Mod+Shift+K".move-window-up = _: {};

          "Mod+Ctrl+H".consume-or-expel-window-left = _: {};
          "Mod+Ctrl+L".consume-or-expel-window-right = _: {};

          "Mod+Ctrl+J".move-window-to-workspace-down = _: {};
          "Mod+Ctrl+K".move-window-to-workspace-up = _: {};

          "Mod+Minus".set-column-width = "-5%";
          "Mod+Equal".set-column-width = "+5%";

          "Mod+Tab".maximize-column = _: {};
          "Mod+Shift+Tab".toggle-overview = _: {};

          "Mod+Delete".spawn = noctalia-call ["media" "previous"];
          "Mod+End".spawn = noctalia-call ["media" "playPause"];
          "Mod+Next".spawn = noctalia-call ["media" "next"];
          "Mod+Bracketleft".spawn-sh = eq-notify {name = "Flat"; icon = "device-speaker";};
          "Mod+Bracketright".spawn-sh = eq-notify {name = "Headphones"; icon = "headphones";};

          "Mod+F1".show-hotkey-overlay = _: {};
          "Mod+Ctrl+Shift+E".spawn = noctalia-call ["sessionMenu" "toggle"];
        };
      };
    };
  };
}
