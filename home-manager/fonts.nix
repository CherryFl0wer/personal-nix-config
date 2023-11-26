{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
      terminus_font
      fira-code
      dejavu_fonts
      (nerdfonts.override {fonts = ["FiraCode"];})
  ];

  fonts.fontconfig.enable = true;
}
