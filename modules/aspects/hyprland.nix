{
  flake.modules.nixos.hyprland = {
    programs.hyprland.enable = true;
    environment.sessionVariables.NIXOS_OZONE_WL = "1";
  };
  flake.modules.homeManager.hyprland = {config, ...}: {
    xdg.configFile.hypr.source = (import ../../lib/symlink-config.nix {inherit config;}) "hypr";
  };
}
