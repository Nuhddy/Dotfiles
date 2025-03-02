{
  inputs,
  lib,
  system,
  ...
}: {
  imports = [
    inputs.nixos-wsl.nixosModules.default
    ../../nixos-modules/core
    ../../nixos-modules/common
  ];

  networking.hostName = "fennec";

  nixpkgs.hostPlatform = lib.mkDefault system;

  wsl = {
    enable = true;
    defaultUser = "nuhddy";
    docker-desktop.enable = true;
  };

  system.stateVersion = "24.11";
}
