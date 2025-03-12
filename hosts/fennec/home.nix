{pkgs, ...}: {
  imports = [
    ../../home-manager-modules/core
    ../../home-manager-modules/common
    ../../home-manager-modules/neovim
  ];

  home.packages = with pkgs; [
    wslu
  ];

  home.stateVersion = "24.11";
}
