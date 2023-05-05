{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "cherryflower";
  home.homeDirectory = "/home/cherryflower";
  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "22.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  nixpkgs.config.allowUnfreePredicate = (pkg: true);
  
  # targets.genericLinux.enable = true;
  # xsession.enable = true; 
  
  # Add application to the launcher 
  home.activation = {
    linkDesktopApplications = {
      after = [ "writeBoundary" "createXdgUserDirectories" ];
      before = [ ];
      data = ''
        rm -rf ${config.xdg.dataHome}/"applications/home-manager"
        mkdir -p ${config.xdg.dataHome}/"applications/home-manager"
        cp -Lr ${config.home.homeDirectory}/.nix-profile/share/applications/* ${config.xdg.dataHome}/"applications/home-manager/"
      '';
    };
  };
  
  # Application
  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "RobotoMono" ]; })
    # tooling
    kubernetes 
    vim
    htop
    git
    tpacpi-bat
    jq 
    graphviz
    httpie
    bat
    ripgrep
    rustup
    go  
    python3
    nodejs
    direnv
    docker-compose
    # Apps
    spotify
    docker-client
    brave
    jetbrains.idea-community
    jetbrains.goland
  ];
  
  home.shellAliases = { 
    g = "git"; 
    c = "bat";
    dev = "cd ~/dev";
  };

  
  home.sessionVariables = {
    EDITOR = "vim";
  };
  
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  # Zsh configuration 
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    oh-my-zsh.enable = true;
    dotDir = ".config/zsh";
    plugins = [
      {
        name = "pi-theme";
        file = "pi.zsh-theme";
        src = pkgs.fetchFromGitHub {
          owner = "tobyjamesthomas";
          repo = "pi";
          rev = "96778f903b79212ac87f706cfc345dd07ea8dc85";
          sha256 = "0zjj1pihql5cydj1fiyjlm3163s9zdc63rzypkzmidv88c2kjr1z";
        };
      }
    ];
  };
  # Git configuration
  programs.git = {
    enable = true;
    userName = "CherryFl0wer";
    userEmail = "corentinredon@gmail.com";
    aliases = {
      st = "status";
      lg = "log --graph --format='%Cred%h%Creset  %<|(15) %C(white)%s %<|(35) %Creset %Cgreen(%cr)%<|(55)  %C(blue)<%an>%Creset%C(yellow)%d%Creset'";
    };
  };
  
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
  };
 
}
