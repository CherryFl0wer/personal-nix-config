 { config, pkgs, ... }: {
  home.packages = with pkgs; [
  	# base 
	ripgrep
	bottom 
	tree
	bat
  gum

	# env
	vscode

	# go 
	go

	# rust 
	cargo
	rustc

	# lib
	pkg-config
    dbus
    openssl_3
    glib
    gtk3
    libsoup
    webkitgtk
    appimagekit
  ];

  home.sessionVariables = {
    LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [
      pkgs.webkitgtk
      pkgs.gtk3
      pkgs.cairo
      pkgs.gdk-pixbuf
      pkgs.glib
      pkgs.dbus
      pkgs.openssl_3
    ];
  };
 

  home.sessionVariables = {
    EDITOR = "nvim";
  };

}
