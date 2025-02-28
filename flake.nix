{
  description = "Nuhddy's NixOS & home-manager configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    stylix.url = "github:danth/stylix";
    nixcord.url = "github:kaylorben/nixcord";
  };

  outputs = {...} @ inputs: let
    inherit (inputs.nixpkgs) lib;

    hosts = builtins.attrNames (builtins.readDir ./hosts);
    secrets = builtins.fromTOML (builtins.readFile ./secrets/secrets.toml);
    user = "nuhddy";
    system = "x86_64-linux";

    mkNixos = host: {
      ${host} = lib.nixosSystem {
        modules = [./hosts/${host}/configuration.nix];
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
        modules = [./hosts/${host}/home.nix];
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
