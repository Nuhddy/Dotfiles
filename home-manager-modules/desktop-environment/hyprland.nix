{...}: {
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
}
