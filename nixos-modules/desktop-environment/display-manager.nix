{pkgs, ...}: {
  services.displayManager = {
    enable = true;
    sddm = {
      enable = true;
      wayland.enable = true; # this doesn't disable X11 support
      package = pkgs.kdePackages.sddm;
    };
  };
}
