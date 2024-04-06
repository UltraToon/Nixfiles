{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    prismlauncher.url = "github:PrismLauncher/PrismLauncher";
  };

  outputs = {nixpkgs, home-manager, hyprland, ...}@inputs:
  let
    system = "x86_64-linux";
    username = "ivan";
  in {
    nixosConfigurations = {
      nix = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = inputs;
        modules = [
          ./hosts/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              userUserPackages = true;
              useGlobalPkgs = true;
              extraSpecialArgs = {inherit inputs};
              users.${username} = import ./home
            }
          }
        ];
      };
    };
    isoImage = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ./hosts/iso.nix
      ];
    }
  };
}
