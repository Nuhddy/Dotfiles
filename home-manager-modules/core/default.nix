{
  pkgs,
  secrets,
  ...
}: {
  home.username = "nuhddy";
  home.homeDirectory = "/home/nuhddy";

  home.packages = with pkgs; [
    wget
    git-crypt
  ];

  programs.git = {
    enable = true;
    userEmail = secrets.email;
    userName = "Nuhddy";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfreePredicate = _: true;
}
