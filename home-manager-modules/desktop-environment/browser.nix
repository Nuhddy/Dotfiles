{
  inputs,
  system,
  ...
}: {
  home.packages = [
    inputs.zen-browser.packages.${system}.default
  ];

  xdg.mimeApps = {
    enable = true;
    defaultApplications = let
      browser = "zen.desktop";
    in {
      "x-scheme-handler/http" = browser;
      "x-scheme-handler/https" = browser;
      "x-scheme-handler/about" = browser;
      "x-scheme-handler/unknown" = browser;
    };
  };
  home.sessionVariables.BROWSER = "zen";
}
