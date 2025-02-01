{
  description = "NixOS & home-manager configurations";

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
    secrets = with inputs; builtins.fromJSON (builtins.readFile "${self}/secrets/secrets.json");
    system = "x86_64-linux";
  in {
    nixosConfigurations."octane" = inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs system;};
      modules = [./configuration.nix];
    };
    homeConfigurations."nuhddy@octane" = inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = inputs.nixpkgs.legacyPackages.${system};
      extraSpecialArgs = {inherit inputs system secrets;};
      modules = [./home.nix];
    };
  };
}
