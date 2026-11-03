{
  flake.modules.nixos.hyprland = {
    programs.hyprland.enable = true;
    environment.sessionVariables.NIXOS_OZONE_WL = "1";
  };
  flake.modules.homeManager.hyprland = {
    config,
    lib,
    secrets,
    ...
  }: {
    xdg.configFile."hypr/hyprland.lua".source = (import ../../lib/symlink-config.nix {inherit config;}) "hypr/hyprland.lua";
    xdg.configFile."hypr/.stylua.toml".source = (import ../../lib/symlink-config.nix {inherit config;}) "hypr/.stylua.toml";
    xdg.configFile."hypr/.luarc.json".source = (import ../../lib/symlink-config.nix {inherit config;}) "hypr/.luarc.json";
    xdg.configFile."hypr/nix.lua".text =
      "return "
      + lib.generators.toLua {} {
        display = config.my.display;
        cc_token = secrets.coolerControlToken;
      };
  };
}
