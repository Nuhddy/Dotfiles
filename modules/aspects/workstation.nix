{inputs, ...}: {
  flake.modules.nixos.workstation = {pkgs, ...}: {
    imports = [
      inputs.catppuccin.nixosModules.catppuccin
    ];

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
      extraGroups = ["wheel"];
    };

    programs.nh = {
      enable = true;
      flake = "/home/nuhddy/.config/nixos";
    };

    catppuccin = {
      enable = true;
      accent = "blue";
      cache.enable = true;
    };
  };

  flake.modules.homeManager.workstation = {
    config,
    pkgs,
    secrets,
    ...
  }: {
    imports = [inputs.catppuccin.homeModules.catppuccin];

    home.packages = with pkgs; [
      tree
      p7zip
      unzip
      wget
      curl
      nix-output-monitor
      nurl
      speedtest-cli
      just
      python3
      devenv

      # Git
      git-crypt
    ];

    # Cachix for devenv
    # nix.settings = {
    #   substituters = "https://devenv.cachix.org";
    #   trusted-public-keys = [
    #     "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
    #     "nixpkgs-python.cachix.org-1:hxjI7pFxTyuTHn2NkvWCrAUcNZLNS3ZAvfYNuYifcEU="
    #   ];
    # };

    catppuccin = {
      enable = true;
      accent = "blue";
      nvim.enable = false;
    };
    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;
      matchBlocks = {
        "*" = {
          forwardAgent = false;
          addKeysToAgent = "no";
          compression = false;
          serverAliveInterval = 0;
          serverAliveCountMax = 3;
          hashKnownHosts = false;
          userKnownHostsFile = "~/.ssh/known_hosts";
          controlMaster = "no";
          controlPath = "~/.ssh/master-%r@%n:%p";
          controlPersist = "no";
        };
        dirac = {
          hostname = "dirac.ruc.dk";
          user = secrets.studUsername;
        };
        "i42 i43 bead50 bead67" = {
          user = secrets.studUsername;
          proxyJump = "dirac";
        };
      };
    };
    programs.tmux.enable = true;
    programs.fastfetch.enable = true;
    programs.btop.enable = true;
    programs.bat.enable = true;
    programs.jq.enable = true;
    programs.ripgrep.enable = true;

    # Git
    programs.git = {
      enable = true;
      lfs.enable = true;
      settings = {
        user = {
          email = secrets.email;
          name = "Nuhddy";
        };
        init.defaultBranch = "main";
      };
    };
    programs.gh = {
      enable = true;
      settings.git_protocol = "ssh";
    };

    # Shell
    programs.zsh = {
      enable = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      defaultKeymap = "viins";
      dotDir = "${config.xdg.configHome}/zsh";
    };
    home.shellAliases = {
      sudo = "sudo ";
      sv = "systemctl";
      cat = "bat";

      ls = "eza";
      la = "eza -la";
      ls1 = "eza -1";
      la1 = "eza -1a";
    };

    # File management
    programs.eza = {
      enable = true;
      git = true;
      icons = "auto";
      extraOptions = [
        "--group-directories-first"
        "--header"
      ];
    };
    programs.ranger.enable = true;
    programs.dircolors.enable = true;
    xdg = {
      enable = true;
      userDirs = {
        enable = true;
        createDirectories = true;
        documents = "${config.home.homeDirectory}/Nextcloud/Documents";
        pictures = "${config.home.homeDirectory}/Nextcloud/Pictures";
        templates = "${config.home.homeDirectory}/Nextcloud/Templates";
        music = "${config.home.homeDirectory}/Nextcloud/Music";
      };
    };
  };
}
