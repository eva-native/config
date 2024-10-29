{
  description = "Home Manager configuration of uzxenvy";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixgl = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    apple-fonts.url = "github:Lyndeno/apple-fonts.nix";
  };

  outputs = { nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      allowUnfree = true;

      pkgs = nixpkgs.legacyPackages.${system};
      nixgl = inputs.nixgl;
      apple-fonts = inputs.apple-fonts.packages.${system};
    in {
      homeConfigurations."uzxenvy" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home.nix ];

        extraSpecialArgs = {
          inherit apple-fonts nixgl;
        };
      };
    };
}
