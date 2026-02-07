{
  flake.modules.homeManager.scripts = {pkgs, ...}: {
    playerctl-specific-player = pkgs.writeShellApplication {
      name = "playerctl-specific-player";
      runtimeInputs = with pkgs; [playerctl];
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
      runtimeInputs = with pkgs; [wlsunset];
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
  };
}
