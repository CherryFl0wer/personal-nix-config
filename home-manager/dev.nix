 { config, pkgs, ... }: {
  home.packages = with pkgs; [
  	# base 
    ripgrep
    bottom 
    tree
    bat
    gum
    gcc

    # env
    vscode
    jetbrains.rust-rover
    
    # go 
    go

    # rust 
    rustup

    # lib
    pkg-config
    dbus
    openssl
    glib
    gtk3
    libiconv
    libsoup
    webkitgtk
    appimagekit
  ];

  home.sessionVariables = {
    LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [
      pkgs.libiconv
      pkgs.webkitgtk
      pkgs.gtk3
      pkgs.cairo
      pkgs.gdk-pixbuf
      pkgs.glib
      pkgs.dbus
      pkgs.openssl
    ];

    EDITOR = "nvim";
    OPENSSL_DEV=pkgs.openssl.dev;
    PKG_CONFIG_PATH="${pkgs.openssl.dev}/lib/pkgconfig";
  };

}
