{pkgs, ...}: {
  imports = [
    ../../home-manager-modules/core.nix

    ../../home-manager-modules/workstation
  ];

  home.packages = with pkgs; [
    wslu
  ];

  home.stateVersion = "24.11";
}
