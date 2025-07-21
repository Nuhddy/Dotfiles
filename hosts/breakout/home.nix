{pkgs, ...}: {
  imports = [
    ../../home-manager-modules/core
    ../../home-manager-modules/common

    ../../home-manager-modules/desktop-environment
    ../../home-manager-modules/neovim
  ];

  home.packages = with pkgs; [
    parted
  ];

  home.stateVersion = "25.05";
}
