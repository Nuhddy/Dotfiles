{
  description = "Nuhddy's NixOS & home-manager configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-wsl.url = "github:/nix-community/NixOS-WSL/main";

    # zen-browser.url = "github:0xc000022070/zen-browser-flake";
    # nixcord.url = "github:kaylorben/nixcord";
    catppuccin.url = "github:catppuccin/nix";
    # niri.url = "github:sodiboo/niri-flake";
  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake {inherit inputs;} (inputs.import-tree ./modules);
  /*
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
          {nixpkgs.overlays = overlays;}
          ./global-modules
          ./hosts/${host}/host-spec.nix
          ./hosts/${host}/configuration.nix
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
          {nixpkgs.overlays = overlays;}
          ./global-modules
          ./hosts/${host}/host-spec.nix
          ./hosts/${host}/home.nix
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
  */
}
