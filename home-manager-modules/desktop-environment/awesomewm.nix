{pkgs, ...}: {
  xsession.windowManager.awesome = {
    enable = true;
    package = pkgs.awesome-luajit-git;
  };

  home.packages = with pkgs; [
    xclip
  ];

  services.picom = {
    enable = true;
    backend = "glx";
    vSync = true;
  };

  services.redshift = {
    enable = true;
    temperature = {
      day = 6500;
      night = 3400;
    };
    latitude = 55.7;
    longitude = 11.7;
    tray = true;
  };

  services.dunst = {
    enable = true;
  };

  programs.rofi = {
    enable = true;
    extraConfig = {
      modi = "drun,run";
    };
  };

  services.polybar = {
    enable = true;
    script = "polybar bar &amp;";
    settings = {
      "bar/bar" = {
        enable-ipc = true;
        width = "100%";
        font-0 = "Roboto:size=11";
        modules-left = "workspaces";
        modules-right = "tray clock";
      };

      "module/workspaces" = {
        type = "internal/xworkspaces";
      };

      "module/clock" = {
        type = "internal/date";
        time = "%H:%M";
        label = "%time%";
        format = "<label>";
      };

      "module/tray" = {
        type = "internal/tray";
      };
    };
  };
}
