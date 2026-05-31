{inputs, ...}: {
  # flake.modules.nixos.noctalia = {
  #   nix.settings = {
  #     extra-substituters = ["https://noctalia.cachix.org"];
  #     extra-trusted-public-keys = [
  #       "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
  #     ];
  #   };
  # };
  perSystem = {pkgs, ...}: {
    packages.myNoctalia = inputs.wrappers.wrappers.noctalia-shell.wrap {
      inherit pkgs;

      settings = (builtins.fromJSON (builtins.readFile ./noctalia.json)).settings;
    };
  };
}
