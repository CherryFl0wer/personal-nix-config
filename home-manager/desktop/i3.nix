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
        size = 21.0;
      };
      
      terminal = "alacritty";
      menu = "${pkgs.rofi}/bin/rofi -show drun -show-icons";

      keybindings = lib.mkOptionDefault {
        "${mod}+Return" = "exec ${pkgs.alacritty}/bin/alacritty";
        "${mod}+p" = "exec ${pkgs.dmenu}/bin/dmenu_run";
        "${mod}+x" = "exec sh -c '${pkgs.maim}/bin/maim -s | xclip -selection clipboard -t image/png'";
        "${mod}+Shift+x" = "exec xflock4";
        "${mod}+w" = "exec ${pkgs.rofi}/bin/rofi -show window -show-icons";
        "${mod}+s" = "exec ${pkgs.rofi}/bin/rofi -show ssh -show-icons";

        # Focus
        "${mod}+j" = "focus left";
        "${mod}+k" = "focus down";
        "${mod}+i" = "focus up";
        "${mod}+l" = "focus right";

        # Move
        "${mod}+Shift+j" = "move left";
        "${mod}+Shift+k" = "move down";
        "${mod}+Shift+i" = "move up";
        "${mod}+Shift+l" = "move right";

        # Resize
        "${mod}+Control+Left" = "resize shrink width 10 px or 10 ppt";
        "${mod}+Control+Right" = "resize grow width 10 px or 10 ppt";
        "${mod}+Control+Down" = "resize shrink height 10 px or 10 ppt";
        "${mod}+Control+Up" = "resize grow height 10 px or 10 ppt";

        # My multi monitor setup
        #"${mod}+m" = "move workspace to output DP-2";
        #"${mod}+Shift+m" = "move workspace to output DP-5";

        "XF86AudioLowerVolume" =
          "exec --no-startup-id pactl -- set-sink-volume 0 -30%"; # decrease sound volume

        "XF86AudioRaiseVolume" = 
          "exec --no-startup-id pactl -- set-sink-volume 0 +30%";
          
        "XF86AudioMute" =
          "exec --no-startup-id pactl -- set-sink-mute 0 toggle"; # mute sound

        "XF86AudioNext" = "exec playerctl next";

        "XF86AudioPlay" = "exec playerctl play-pause";

        "XF86AudioPrev" = "exec playerctl previous";

        "XF86AudioStop" = "exec playerctl stop";

        "XF86MonBrightnessDown" =
          "exec xbacklight -dec 20"; # decrease screen brightness

        "XF86MonBrightnessUp" =
          "exec xbacklight -inc 20"; # increase screen brightness
      };

      focus = {
        followMouse = true;
        wrapping = "yes";
      };

      startup = [
        {
          command =
            "${pkgs.feh}/bin/feh --bg-fill /home/cherryflower/.config/home-manager/wallpapers/4k-snow-trees.jpg";
          always = true;
          notification = false;
        }
        {
          command = "xfce4-volumed-pulse &";
          always = false;
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
            size = 16.0;
          };
        }
      ];
    };
  };
}
