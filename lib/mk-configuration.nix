{
  inputs,
  lib,
  config,
}: {
  system ? "x86_64-linux",
  host,
  user ? "nuhddy",
  nixosStateVersion,
  homeManagerStateVersion,
  aspects ? [],
  genericConfig ? {},
  nixosConfig ? {},
  homeManagerConfig ? {},
}: let
  genericOptions = config.flake.modules.generic.options;

  selectedAspects = (import ./select-aspects.nix {inherit lib;}) {
    inherit aspects;
    nixosRegistry = config.flake.modules.nixos;
    homeManagerRegistry = config.flake.modules.homeManager;
  };

  secrets = fromTOML (builtins.readFile ../secrets/secrets.toml);

  combinedSpecialArgs = {
    inherit
      inputs
      secrets
      ;
  };
in
  inputs.nixpkgs.lib.nixosSystem {
    inherit system;

    specialArgs = combinedSpecialArgs;

    modules =
      # NixOS
      selectedAspects.nixos
      ++ [
        genericOptions
        genericConfig
        {
          networking.hostName = host;
          system.stateVersion = nixosStateVersion;
          nixpkgs.hostPlatform = system;
        }
        nixosConfig

        # Home Manager
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager = {
            extraSpecialArgs = combinedSpecialArgs;

            useGlobalPkgs = true;
            useUserPackages = true;
            users.${user}.imports =
              [
                genericOptions
                genericConfig
                {
                  home = {
                    username = user;
                    homeDirectory = "/home/${user}";
                    stateVersion = homeManagerStateVersion;
                  };
                  programs.home-manager.enable = true;
                }
                homeManagerConfig
              ]
              ++ selectedAspects.homeManager;
          };
        }
      ];
  }
