{
  flake.modules.homeManager.quickshell = {
    pkgs,
    config,
    ...
  }: {
    programs.quickshell.enable = true;
    xdg.configFile.quickshell.source = (import ../../lib/symlink-config.nix {inherit config;}) "quickshell";
  };
}
