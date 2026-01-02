{
  inputs,
  lib,
  config,
  ...
}: let
  host = "fennec";
  user = "nuhddy";
in {
  flake.nixosConfigurations.${host} = (import ../../lib/mk-configuration.nix {inherit inputs lib config;}) {
    inherit host user;
    nixosStateVersion = "25.05";
    homeManagerStateVersion = "25.05";
    nixosConfig = {
      imports = [inputs.nixos-wsl.nixosModules.default];
      wsl = {
        enable = true;
        defaultUser = user;
        docker-desktop.enable = true;
      };
    };
    homeManagerConfig = {pkgs, ...}: {
      home.packages = [pkgs.wslu];
    };
    aspects = [
      "base"
      "workstation"
      "neovim"
    ];
  };
}
