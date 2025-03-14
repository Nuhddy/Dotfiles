{pkgs, ...}: {
  nix.settings = {
    substituters = ["https://fortuneteller2k.cachix.org"];
    trusted-public-keys = ["fortuneteller2k.cachix.org-1:kXXNkMV5yheEQwT0I4XYh1MaCSz+qg72k8XAi2PthJI="];
  };

  services.xserver = {
    enable = true;
    windowManager.awesome = {
      enable = true;
      package = pkgs.awesome-luajit-git;
    };
  };
}
