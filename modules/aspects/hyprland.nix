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
    xdg.configFile = let
      linkedFiles = lib.listToAttrs (map (f: {
          name = "hypr/${f}";
          value.source = (import ../../lib/symlink-config.nix {inherit config;}) "hypr/${f}";
        }) [
          "hyprland.lua"
          ".stylua.toml"
          ".luarc.json"
        ]);
    in
      linkedFiles
      // {
        "hypr/nix.lua".text =
          "return "
          + lib.generators.toLua {} {
            display = config.my.display;
            cc_token = secrets.coolerControlToken;
          };
      };
  };
}
