{
  pkgs,
  system,
  modulesPath,
  ...
}: {
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
    ../../nixos-modules/core.nix
  ];

  environment.systemPackages = with pkgs; [
    git-crypt
    bitwarden-cli
    nix-output-monitor
  ];

  programs.git.enable = true;
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  nixpkgs.hostPlatform = system;
}
