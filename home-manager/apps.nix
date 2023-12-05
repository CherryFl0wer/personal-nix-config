{ config, pkgs, ... } : {
    imports = [
        ./firefox.nix
    ];

    home.packages = with pkgs; [
        spotify
        spotify-tui
        feh
    ];
}