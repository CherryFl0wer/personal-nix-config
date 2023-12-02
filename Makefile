build-nix:
	sudo nixos-rebuild switch --flake .#nixos

build-hm:
	sudo nix-channel --update
	home-manager switch --flake .#cherryflower@nixos --verbose
