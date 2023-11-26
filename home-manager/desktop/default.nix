{ pkgs, ... } : {
    
    home.packages = with pkgs; [
        i3status-rust
    ];


    imports = [
        ./i3.nix
        ./xdg.nix
    ];

}