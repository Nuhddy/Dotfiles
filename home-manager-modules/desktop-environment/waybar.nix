{pkgs, ...}: {
  programs.waybar = {
    enable = true;
    settings.mainBar = {
      layer = "top";
      position = "top";
      height = 30;
      output = ["DP-2"];
      modules-left = [
        "river/tags"
        "river/layout"
      ];
      modules-right = [
        "tray"
        "pulseaudio"
        "network"
        "clock"
      ];
      "river/tags" = {
        "num-tags" = 5;
      };
      "river/layout" = {};
      tray.spacing = 10;
      pulseaudio = {
        format = "{icon}";
        format-icons.default = ["" "" ""];
        format-muted = "";
        scroll-step = 5.0;
        on-click = "${pkgs.pw-volume}/bin/pw-volume mute toggle";
        on-click-right = "${pkgs.pwvucontrol}/bin/pwvucontrol";
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
}
