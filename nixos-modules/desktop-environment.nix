{pkgs, ...}: {
  services.displayManager = {
    enable = true;
    sddm = {
      enable = true;
      wayland.enable = true; # this doesn't disable X11 support
      package = pkgs.kdePackages.sddm;
    };
  };

  programs.river.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
}
