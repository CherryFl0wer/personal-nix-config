{ config, lib, pkgs, ... } : 

let 
  mod = "Mod4";
in {
  xsession.windowManager.i3 = {
    enable = true;

    package = pkgs.i3-gaps;

    config = {

      modifier = mod;

      fonts = {
        names = [
          "FiraCode"
          "Terminus"
          "DejaVu Sans"
          "DejaVu Serif"
        ];
        size = 16.0;
      };
      
      terminal = "alacritty";
      menu = "${pkgs.rofi}/bin/rofi -show drun -show-icons";

      keybindings = lib.mkOptionDefault {
        "${mod}+Return" = "exec ${pkgs.alacritty}/bin/alacritty";
        "${mod}+p" = "exec ${pkgs.dmenu}/bin/dmenu_run";
        "${mod}+x" = "exec sh -c '${pkgs.maim}/bin/maim -s | xclip -selection clipboard -t image/png'";
        "${mod}+Shift+x" = "exec sh -c '${pkgs.i3lock}/bin/i3lock -c 222222 & sleep 5 && xset dpms force of'";
        "${mod}+w" = "exec ${pkgs.rofi}/bin/rofi -show window -show-icons";
        "${mod}+s" = "exec ${pkgs.rofi}/bin/rofi -show ssh -show-icons";

        # Focus
        "${mod}+j" = "focus left";
        "${mod}+k" = "focus down";
        "${mod}+l" = "focus up";
        "${mod}+semicolon" = "focus right";

        # Move
        "${mod}+Shift+j" = "move left";
        "${mod}+Shift+k" = "move down";
        "${mod}+Shift+l" = "move up";
        "${mod}+Shift+semicolon" = "move right";

        # My multi monitor setup
        "${mod}+m" = "move workspace to output DP-2";
        "${mod}+Shift+m" = "move workspace to output DP-5";
      };

      focus = {
        followMouse = true;
        wrapping = "yes";
      };

      startup = [
        {
          command =
            "${pkgs.feh}/bin/feh --bg-fill ./wallpapers/4k-forest-01.jpg";
          always = true;
          notification = false;
        }
      ];

      gaps = {
        inner = 10;
        outer = 5;
      };

      bars = [
        {
          position = "bottom";
          statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ${./i3status-rust.toml}";

          fonts = {
            names = ["FiraCode"];
            size = 18.0;
          };
        }
      ];
    };
  };
}
