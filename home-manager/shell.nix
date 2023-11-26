{ config, pkgs, lib, ... } : {
   
    home.packages = with pkgs; [
        zsh
        alacritty
        starship
    ];

    programs.zsh = {
          enable = true;
          enableAutosuggestions = true;
          enableCompletion = true;
          enableVteIntegration = pkgs.stdenv.isLinux;
          autocd = true;
          dotDir = ".config/zsh";
          history = {
              expireDuplicatesFirst = true;
              extended = true;
              ignoreDups = true;
              ignoreSpace = true;
              #path = "${config.users.users.username.home}/zsh/history";
              save = 10000;
              share = true;
          };
          historySubstringSearch.enable = true;
          shellAliases = {
              gs = "git status";
          };
    };
    
    
    programs.alacritty = {
      enable = true;
      settings = {
        font.size = 7.0;
        font.normal.family = "FiraCode";
        
        env = {
          TERM = "xterm-256color";
        };

        padding = { y = 10; x = 10; };
        dimensions = {
          lines = 80;
          columns = 100;
        };

        shell.program = "${pkgs.zsh}/bin/zsh";

        live_config_reload = true;

        # NixOS 22.05
        window = {
          opacity = 0.75;
        };
      };
    };

    
    programs.starship = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        character = {
          success_symbol = "[𝝺](green)";
          error_symbol = "[𝝺](red)";
        };
        format = lib.concatStrings [
          "$hostname"
          "$directory"
          "$git_branch"
          "$git_commit"
          "$git_state"
          "$git_metrics"
          "$git_status"
          "$character"
        ];
      };
    };


  programs.rofi = {
    enable = true;
    plugins = [
      pkgs.rofi-emoji
    ];
    terminal = "${pkgs.alacritty}/bin/alacritty";
    location = "center";
    font = "DejaVu Sans";
    extraConfig = {
        modi = "drun,ssh,window";
        display-drun = "Applications";
        drun-display-format = "{name}";
    };
  };

}