{
  flake.modules.nixos.gaming = {
    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;
    };
    programs.gamemode.enable = true;
  };

  flake.modules.homeManager.gaming = {pkgs, ...}: {
    home.packages = with pkgs; [
      # TODO: openldap error on build
      # lutris
      prismlauncher
    ];
  };
}
