{
  # config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    waybar
  ];
  programs.waybar = {
    enable = false;
    # settings.mainBar = {
    #   layer = "top";
    #   position = "top";
    #   height = 30;
    #   output = [config.hostSpec.display.name];
    #   modules-left = [
    #     "river/tags"
    #     "river/layout"
    #   ];
    #   modules-right = [
    #     "tray"
    #     "backlight"
    #     "pulseaudio"
    #     "network"
    #     "battery"
    #     "clock"
    #   ];
    #   "river/tags" = {
    #     "num-tags" = 5;
    #   };
    #   "river/layout" = {};
    #   tray.spacing = 10;
    #   pulseaudio = {
    #     format = "{icon}";
    #     format-icons.default = ["" "" ""];
    #     format-muted = "";
    #     scroll-step = 5.0;
    #     on-click = "${pkgs.pw-volume}/bin/pw-volume mute toggle";
    #     on-click-right = "${pkgs.pwvucontrol}/bin/pwvucontrol";
    #     ignored-sinks = ["JamesDSP Sink"];
    #   };
    #   network = {
    #     format = "{icon}";
    #     format-wifi = "";
    #     format-ethernet = "󰌘";
    #     format-disconnected = "󰌙";
    #     tooltip-format-wifi = "{essid}: {signalStrength}% strength";
    #     tooltip-format-ethernet = "{ipaddr}";
    #     tooltip-format-disconnect = "No internet connection";
    #   };
    #   battery = {
    #     format = "{icon}";
    #     format-icons = ["" "" "" "" ""];
    #     tooltip-format = "{capacity}% capacity\n{timeTo}";
    #   };
    #   backlight = {
    #     format = "{icon}";
    #     format-icons = ["󰃞" "󰃟" "󰃠"];
    #     tooltip-format = "{percent}% brightness";
    #   };
    #   clock.tooltip = false;
    # };
    # style = ''
    #   * {
    #     padding: 0 8px;
    #     background-color: @base;
    #     color: @text;
    #   }
    # '';
  };
}
