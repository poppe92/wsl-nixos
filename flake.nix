{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixos-wsl, ... }@inputs: {

    nixosConfigurations = {
      default = nixpkgs.lib.nixosSystem rec {
        specialArgs = {inherit inputs;};
        system = "x86_64-linux";
        modules = [
          ./hosts/default/configuration.nix
          nixos-wsl.nixosModules.wsl
          inputs.home-manager.nixosModules.default
        ];
      };

      nixos = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        system = "x86_64-linux";
        modules = [
          ./hosts/nixOS/configuration.nix
          nixos-wsl.nixosModules.wsl
          inputs.home-manager.nixosModules.default
        ];
      };
      macOS = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        system = "x86_64-linux";
        modules = [
          ./hosts/macOS/configuration.nix
          nixos-wsl.nixosModules.wsl
          inputs.home-manager.nixosModules.default
        ];
      };
    };
  };
}
