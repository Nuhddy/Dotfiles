{
  config,
  pkgs,
  ...
}: let
  helpers = import ../lib {inherit config;};
in {
  home.packages = with pkgs; [
    pw-volume
    jamesdsp
    playerctl
  ];

  xdg.configFile."jamesdsp/presets".source = helpers.configSymlink "jamesdsp/presets";
}
