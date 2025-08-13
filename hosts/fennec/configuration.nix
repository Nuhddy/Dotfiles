{
  inputs,
  system,
  ...
}: {
  imports = [
    inputs.nixos-wsl.nixosModules.default
    ../../nixos-modules/core.nix

    ../../nixos-modules/workstation.nix
  ];

  networking.hostName = "fennec";
  system.stateVersion = "24.11";

  nixpkgs.hostPlatform = system;

  wsl = {
    enable = true;
    defaultUser = "nuhddy";
    docker-desktop.enable = true;
  };
}
