{ config, pkgs, ... } : {
    imports = [
        ./firefox.nix
    ];

    home.packages = with pkgs; [
        firefox
        spotify
        spotify-tui
        feh
        wluma
        audacity
    ];
}