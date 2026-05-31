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
      colors = {
        mPrimary = "#89b4fa";
        mOnPrimary = "#11111b";
        mSecondary = "#74c7ec";
        mOnSecondary = "#11111b";
        mTertiary = "#89dceb";
        mOnTertiary = "#11111b";
        mError = "#f38ba8";
        mOnError = "#11111b";
        mSurface = "#181825";
        mOnSurface = "#cdd6f4";
        mSurfaceVariant = "#313244";
        mOnSurfaceVariant = "#a3b4eb";
        mOutline = "#4c4f69";
        mShadow = "#11111b";
        mHover = "#89dceb";
        mOnHover = "#11111b";
      };
    };
  };
}

