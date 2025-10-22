{
  config,
  pkgs,
  inputs,
  secrets,
  ...
}: {
  imports = [
    inputs.catppuccin.homeModules.catppuccin
    ./neovim.nix
  ];

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
      i42 = {
        hostname = "i42";
        user = secrets.studUsername;
        proxyJump = "dirac";
      };
      bead50 = {
        hostname = "bead50";
        user = secrets.studUsername;
        proxyJump = "dirac";
      };
      bead67 = {
        hostname = "bead67";
        user = secrets.studUsername;
        proxyJump = "bead50";
        localForwards = [
          {
            bind.port = 50000;
            host.address = "localhost";
            host.port = 50000;
          }
        ];
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
    userEmail = secrets.email;
    userName = "Nuhddy";
    extraConfig = {
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
}
