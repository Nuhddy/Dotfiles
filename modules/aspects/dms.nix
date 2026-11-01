{inputs, ...}: {
  flake.modules.nixos.dms = {pkgs, ...}: {
    programs.dms-shell = {
      enable = true;
      package = inputs.dms.packages.${pkgs.stdenv.hostPlatform.system}.default;
      systemd = {
        enable = true;
        restartIfChanged = true;
      };
    };
  };
}
