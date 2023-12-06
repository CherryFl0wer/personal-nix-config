{
  description = "Cherryflower personal config for linux (nixos)";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    #nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    
    rycee-nurpkgs = {
      url = gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur.url = github:nix-community/NUR;
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
  in {

    # NixOS configuration entrypoint
    nixosConfigurations = {
      # Available through 'nixos-rebuild --flake .#nixos'
      nixos = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        # > Our main nixos configuration file <
        modules = [./nixos/configuration.nix];
      };
    };
    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager --flake .#cherryflower@nixos'
    homeConfigurations = {
      "cherryflower@nixos" = home-manager.lib.homeManagerConfiguration {
        # pkgs = nixpkgs.legacyPackages.x86_64-linux; 

        pkgs = import nixpkgs {
          system = "x86_64-linux";
          overlays = [ inputs.nur.overlay ];
        };
	      # extraSpecialArgs = {inherit inputs outputs; };
        modules = [./home-manager/home.nix];
      };
    };
  };
}
