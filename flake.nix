{
  description = "A simple NixOS flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvf.url = "github:notashelf/nvf";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    chromexup.url = "github:crabdancing/chromexup-flake";
  };
  outputs = inputs @ {
    self,
    nvf,
    home-manager,
    nixpkgs,
    chaotic,
    ...
  }: let
    system = "x86_64-linux";
    hostname = "nixos";
    username = "ivan";
    name = "Ivan Blackburn";
    wm = "niri";
    editor = "hx";
    browser = "firefox";
    term = "kitty";
    font = "Departure Mono Nerd Font";
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit hostname;
        inherit name;
        inherit inputs;
      };
      modules = [
        ./host
        nvf.nixosModules.default
        home-manager.nixosModules.home-manager
        chaotic.nixosModules.nyx-cache
        chaotic.nixosModules.nyx-overlay
        chaotic.nixosModules.nyx-registry
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.${username} = {
              imports = [
                ./home_modules
                inputs.chromexup.homeManagerModules.default
              ];
            };
            extraSpecialArgs = {
              inherit inputs;
            };
          };
        }
      ];
    };
  };
}
