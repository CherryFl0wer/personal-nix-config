{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
      terminus_font
      fira-code
      (nerdfonts.override {fonts = ["FiraCode" "Noto"];})
  ];

  fonts.fontconfig.enable = true;
}
