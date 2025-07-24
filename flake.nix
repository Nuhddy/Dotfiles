{
  description = "Nuhddy's NixOS & home-manager configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-wsl.url = "github:/nix-community/NixOS-WSL/main";

    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    nixcord.url = "github:kaylorben/nixcord";
    catppuccin.url = "github:catppuccin/nix";
  };

  outputs = {...} @ inputs: let
    inherit (inputs.nixpkgs) lib;

    hosts = builtins.attrNames (builtins.readDir ./hosts);
    secrets = builtins.fromTOML (builtins.readFile ./secrets/secrets.toml);
    user = "nuhddy";
    system = "x86_64-linux";
    overlays = [];

    mkNixos = host: {
      ${host} = lib.nixosSystem {
        modules = [
          ./hosts/${host}/configuration.nix
          {nixpkgs.overlays = overlays;}
        ];
        specialArgs = {
          inherit
            inputs
            system
            ;
        };
      };
    };
    mkHome = host: {
      "${user}@${host}" = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = inputs.nixpkgs.legacyPackages.${system};
        modules = [
          ./hosts/${host}/home.nix
          {nixpkgs.overlays = overlays;}
        ];
        extraSpecialArgs = {
          inherit
            inputs
            system
            secrets
            ;
        };
      };
    };
    mkConfigurations = configType: lib.foldl (a: b: a // b) {} (builtins.map (host: configType host) hosts);
  in {
    nixosConfigurations = mkConfigurations mkNixos;
    homeConfigurations = mkConfigurations mkHome;
  };
}
