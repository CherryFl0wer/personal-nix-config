build-nix:
	sudo nixos-rebuild switch --flake .#nixos

build-hm:
	home-manager switch --flake .#cherryflower@nixos --verbose
