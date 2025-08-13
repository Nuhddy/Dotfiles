{
  lib,
  config,
  pkgs,
  ...
}: {
  options.hostSpec.latex = {
    enable = lib.mkEnableOption "Enable texliveFull";
  };

  # config = lib.mkIf config.hostSpec.latex.enable {
  #   home.packages = with pkgs; [texliveFull];
  # };
}
