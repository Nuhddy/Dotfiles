{...}: {
  home.username = "nuhddy";
  home.homeDirectory = "/home/nuhddy";

  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfreePredicate = _: true;
}
