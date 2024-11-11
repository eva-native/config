{ config, pkgs, nixgl, ... }@inputs:
let
  nixGLPkgs = nixgl.packages.${pkgs.system};
  nixGLWrap = pkg: config.lib.nixGL.wrap pkg;
in
{
  nixpkgs.config = {
    allowUnfree = true;
  };

  nixGL = {
    packages = nixGLPkgs;
  };

  home = {
    username = "uzxenvy";
    homeDirectory = "/home/uzxenvy";
    stateVersion = "24.05";

    packages = (with pkgs; [
      neovim neofetch nnn unzip zip xz htop tmux
      eza bat fzf ripgrep fd nmap wget
      wl-clipboard cmakeCurses extra-cmake-modules
      gcc gdb nodejs_22 python3 python312Packages.pip
      black isort llvmPackages_19.clang-tools gotools stylua
      # nodePackages.prettier broken package
      noto-fonts-cjk-sans
    ]) ++ (with inputs.apple-fonts; [
      sf-pro-nerd sf-mono-nerd ny-nerd
    ]) ++ (builtins.map (pkg: nixGLWrap pkg) (with pkgs; [
      alacritty nekoray
    ]));

    shellAliases =
    let
      ezaDefaultArgs = "--long --colour=auto --icons=auto --classify=auto --binary --header --group";
    in {
      v  = "nvim";
      diff = "nvim -d";

      ls = "eza";
      ll = "eza ${ezaDefaultArgs}";
      l  = "eza ${ezaDefaultArgs}";
      la = "eza ${ezaDefaultArgs} --all";
      "l." = "eza ${ezaDefaultArgs} --list-dirs .*";

      tns = "tmux new-session -As $USER";
    };

    sessionVariables = {
      EDITOR = "nvim";
      CPM_SOURCE_CACHE = "${config.xdg.cacheHome}/CPM";
    };

    sessionPath = [
      "$HOME/.local/bin"
    ];
  };

  xdg = {
    configFile = {
      nvim = { recursive = true; source = ./nvim; };
      tmux = { recursive = true; source = ./tmux; };
      alacritty = { recursive = true; source = ./alacritty; };
    };
  };

  programs = {
    zsh = {
      enable = true;
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

    direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableZshIntegration = true;
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

    home-manager.enable = true;
  };

  fonts.fontconfig = {
    enable = true;
    # defaultFonts = {
    #   sansSerif = ["SFProDisplay Nerd Font"];
    #   monospace = ["SFMono Nerd Font"];
    #   serif = ["NewYork Nerd Font"];
    # };
  };
}
