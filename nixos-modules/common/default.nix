{pkgs, ...}: {
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  security.sudo = {
    enable = true;
    package = pkgs.sudo.override {withInsults = true;};
    extraConfig = "Defaults pwfeedback";
  };

  services.openssh.enable = true;

  i18n.defaultLocale = "en_US.UTF-8";

  users.users.nuhddy = {
    description = "Nuhddy";
    isNormalUser = true;
    extraGroups = [
      "wheel"
    ];
  };

  programs.nh = {
    enable = true;
    flake = "/home/nuhddy/.config/nixos";
  };
}
