{ config, pkgs, ... }:

{
  home = {
    username = "uzxenvy";
    homeDirectory = "/home/uzxenvy";
    stateVersion = "24.05";
    packages = with pkgs; [
      nnn unzip zip xz
      gcc gdb nodejs_22 python3
      python312Packages.pip
      black isort llvmPackages_19.clang-tools gotools stylua
      # nodePackages.prettier needed package update
      nmap wget
      hashcat hashcat-utils hcxtools
      nekoray telegram-desktop
      libreoffice-qt6
      wl-clipboard
    ];
    sessionVariables = {
      CPM_SOURCE_CACHE = "${config.xdg.cacheHome}/CPM";
    };
  };

  xdg.configFile = {
    nvim = { recursive = true; source = ./nvim; };
    tmux = { recursive = true; source = ./tmux; };
    alacritty = { recursive = true; source = ./alacritty; };
  };

  programs = {
    home-manager.enable = true;

    zsh = {
      enable = true;
      sessionVariables = {
        CPM_SOURCE_CACHE = "${config.xdg.cacheHome}/CPM";
      };
      zplug = {
        enable = true;
        plugins = [
          { name = "zsh-users/zsh-autosuggestions"; }
          { name = "romkatv/powerlevel10k"; tags = [ "as:theme" "depth:1" ]; }
        ];
      };
      initExtra = ''
        . ~/.p10k.zsh
      '';
      envExtra = ''
      [[ -f /etc/profiles/per-user/user/etc/profile.d/hm-session-vars.sh ]] && . /etc/profiles/per-user/user/etc/profile.d/hm-session-vars.sh
      [[ -f ~/.nix-profile/etc/profile.d/hm-session-vars.sh ]] && . ~/.nix-profile/etc/profile.d/hm-session-vars.sh
      '';
    };

    git = {
      enable = true;
      userName = "Eva Dunmire";
      userEmail = "evadunmire@gmail.com";
    };

    go = {
      enable = true;

      goPath = ".local/go";
      goBin = ".local/bin";
    };

    alacritty.enable = true;
  };
}
