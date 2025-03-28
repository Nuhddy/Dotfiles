{config, pkgs, ...}: {
  home.packages = with pkgs; [
    wl-clipboard
    wev
    mako
    rofi-wayland
    wlsunset
    nwg-look
    river-filtile
    swww
    lswt
    wlr-randr
  ];
  wayland.windowManager.river = {
    enable = true;
    settings = let
      lshift = a:
        if a == 1
        then 1
        else 2 * lshift (a - 1);

      tagStr = a: lshift a |> toString;

      filtile = "${pkgs.river-filtile}/bin/filtile";
      jamesdsp = "${pkgs.jamesdsp}/bin/jamesdsp";
      playerctl = "~/.bin/playerctl-specific-player.sh";
      wlsunset = "~/.bin/wlsunset.sh";
    in {
      map = {
        normal = {
          # Apps
          "Super Return" = "spawn '${pkgs.kitty}/bin/kitty -1'";
          "Super Space" = "spawn '${pkgs.rofi-wayland}/bin/rofi -show drun'";
          "Super E" = "spawn ${pkgs.xfce.thunar}/bin/thunar";
          "Alt End" = "spawn '${wlsunset} toggle'";

          # Client
          "Super+Shift Q" = "close";
          "Super S" = "toggle-float";
          "Super F" = "toggle-fullscreen";
          "Super H" = "focus-view left";
          "Super J" = "focus-view down";
          "Super K" = "focus-view up";
          "Super L" = "focus-view right";
          "Alt Tab" = "focus-view next";
          "Alt+Shift Tab" = "focus-view previous";
          "Super+Shift H" = "swap left";
          "Super+Shift J" = "swap down";
          "Super+Shift K" = "swap up";
          "Super+Shift L" = "swap right";

          # River
          "Super+Control+Shift E" = "exit";

          # Layout
          "Super Left" = "send-layout-cmd filtile 'move-split-left 5'";
          "Super Right" = "send-layout-cmd filtile 'move-split-right 5'";
          "Super Tab" = "send-layout-cmd filtile monocle";
          "Super+Shift Tab" = "send-layout-cmd filtile flip";

          # Tags
          "Super 1" = "set-focused-tags ${tagStr 1}";
          "Super 2" = "set-focused-tags ${tagStr 2}";
          "Super 3" = "set-focused-tags ${tagStr 3}";
          "Super 4" = "set-focused-tags ${tagStr 4}";
          "Super 5" = "set-focused-tags ${tagStr 5}";
          "Super+Shift 1" = "set-view-tags ${tagStr 1}";
          "Super+Shift 2" = "set-view-tags ${tagStr 2}";
          "Super+Shift 3" = "set-view-tags ${tagStr 3}";
          "Super+Shift 4" = "set-view-tags ${tagStr 4}";
          "Super+Shift 5" = "set-view-tags ${tagStr 5}";

          # Media
          "Super End" = "spawn '${playerctl} play-pause'";
          "Super Delete" = "spawn '${playerctl} previous'";
          "Super Next" = "spawn '${playerctl} next'";
          "Super bracketleft" = "spawn '${jamesdsp} --load-preset Flat'";
          "Super bracketright" = "spawn '${jamesdsp} --load-preset Headphones'";
        };
        locked = {
          # Media
          "Super End" = "spawn '${playerctl} play-pause'";
          "Super Delete" = "spawn '${playerctl} previous'";
          "Super Next" = "spawn '${playerctl} next'";
          "Super bracketleft" = "spawn '${jamesdsp} --load-preset Flat'";
          "Super bracketright" = "spawn '${jamesdsp} --load-preset Headphones'";
        };
      };
      input = {"'*'" = {accel-profile = "flat";};};
      keyboard-layout = "-options 'caps:swapescape' us";
      set-repeat = "50 300";
      spawn = [
        "'${pkgs.wlr-randr}/bin/wlr-randr --output DP-2 --mode 1920x1080@144.001007Hz --adaptive-sync disabled'"
        ("'${filtile} "
          + "main-location right"
          + ", main-ratio 60"
          + ", --tags ${tagStr 4} monocle on"
          + ", --tags ${tagStr 5} monocle on"
          + "'")
        "'${pkgs.swww}/bin/swww-daemon'"
        "'${pkgs.waybar}/bin/waybar'"
        "'${pkgs.mako}/bin/mako'"
        "'${wlsunset} on'"
        "'${pkgs.jamesdsp}/bin/jamesdsp -t'"
        "'${pkgs.bitwarden}/bin/bitwarden'"
        "'${pkgs.nextcloud-client}/bin/nextcloud'"
        "'${pkgs.networkmanagerapplet}/bin/nm-applet'"
      ];
      rule-add = {
        "-app-id" = {
          "'*'" = "ssd";
          "discord" = {tags = "${tagStr 4}";};
          "tidal-hifi" = {tags = "${tagStr 5}";};
        };
      };
      border-width = 2;
      border-color-focused = "0x89b4fa";
      border-color-unfocused = "0x1e1e2e";
      border-color-urgent = "0xf38ba8";
      xcursor-theme = config.home.pointerCursor.name;
      default-layout = "filtile";
      default-attach-mode = "bottom";
    };
  };
}
