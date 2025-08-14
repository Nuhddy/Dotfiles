{
  config,
  pkgs,
  ...
}: let
  playerctl-specific-player = pkgs.writeShellApplication {
    name = "playerctl-specific-player";
    runtimeInputs = [pkgs.playerctl];
    text = ''
      if [ $# -eq 0 ]; then
          playerctl
          exit 1
      fi

      COMMAND=$*
      PLAYER=tidal-hifi

      players=$(playerctl -l)

      for i in "''${players[@]}"; do
          if [ "$i" = $PLAYER ]; then
              playerctl "$COMMAND" -p $PLAYER
              exit 0
          fi
      done

      playerctl "$COMMAND"
    '';
  };

  wlsunset-plus = pkgs.writeShellApplication {
    name = "wlsunset-plus";
    runtimeInputs = [pkgs.wlsunset];
    text = ''
      if [ $# -eq 0 ]; then
          echo "Error: expected 1 arg"
          exit 1
      fi

      TEMP_DAY=6500
      TEMP_NIGHT=3400
      LAT=55.7
      LON=11.7

      function on {
          wlsunset -T $TEMP_DAY -t $TEMP_NIGHT -l $LAT -L $LON &
      }

      case $1 in
          on)
              if pgrep wlsunset; then
                  pkill wlsunset
              fi
              on
              ;;
          off)
              if pgrep wlsunset; then
                  pkill wlsunset
              fi
              ;;
          toggle)
              if pgrep wlsunset; then
                  pkill wlsunset
              else
                  on
              fi
              ;;
          *)
              echo "Error: invalid arg: expected on|off|toggle"
              exit 1
              ;;
      esac
    '';
  };
in {
  home.packages = with pkgs; [
    wl-clipboard
    wev
    mako
    rofi-wayland
    nwg-look
    river-filtile
    swww
    lswt
    wlr-randr
    wlsunset
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
      playerctl = playerctl-specific-player;
      wlsunset = wlsunset-plus;
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
      map-pointer.normal = {
        "Super BTN_LEFT" = "move-view";
        "Super BTN_RIGHT" = "resize-view";
      };
      input = {"'*'" = {accel-profile = "flat";};};
      keyboard-layout = "-options 'caps:swapescape' us";
      set-repeat = "50 300";
      spawn = [
        "'${pkgs.wlr-randr}/bin/wlr-randr --output ${config.hostSpec.display.name} --mode ${config.hostSpec.display.resolution}@${config.hostSpec.display.refreshRate}Hz --adaptive-sync disabled'"
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
