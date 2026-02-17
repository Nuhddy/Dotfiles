{inputs, ...}: {
  flake.modules.nixos.quickshell = {
    services.upower.enable = true;
  };
  flake.modules.homeManager.quickshell = {
    pkgs,
    config,
    ...
  }: {
    home.packages = [
      inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
    xdg.configFile.quickshell.source = (import ../../lib/symlink-config.nix {inherit config;}) "quickshell";
  };
}
