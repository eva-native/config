{ config, pkgs, nixgl, ... }@inputs:
let
  nixGLPkgs = nixgl.packages.${pkgs.system};
  nixGLDefault = nixGLPkgs.nixGLDefault;
  nixGLWrap = pkg: config.lib.nixGL.wrap pkg;

  packages = with pkgs; [
    neovim
    neofetch nnn unzip zip xz htop tmux
    eza bat fzf ripgrep fd
    nmap wget

    wl-clipboard
    gcc gdb nodejs_22 python3 python312Packages.pip
    black isort llvmPackages_19.clang-tools gotools stylua
    # nodePackages.prettier broken package
    noto-fonts-cjk-sans
  ];
  appleFonts = with inputs.apple-fonts; [ sf-pro-nerd sf-mono-nerd ny-nerd ];
  glPacakges = (builtins.map (pkg: nixGLWrap pkg) (with pkgs; [
    alacritty nekoray
  ]));
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

    packages = packages ++ appleFonts ++ glPacakges;

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
    };

    sessionVariables = {
      EDITOR = "nvim";
      CPM_SOURCE_CACHE = "${config.xdg.cacheHome}/CPM";
    };
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
