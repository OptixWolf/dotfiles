{
  description = "OptixWolfs NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    caelestia-shell = {
      url = "github:caelestia-dots/shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    aagl.url = "github:ezKEa/aagl-gtk-on-nix";
    aagl.inputs.nixpkgs.follows = "nixpkgs";

    plasma-manager.url = "github:nix-community/plasma-manager";
    plasma-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, home-manager, caelestia-shell, aagl, plasma-manager, ... }@inputs:
  let
    system = "x86_64-linux";
    username = "optixwolf";
    mkConfiguration = { gpuModule, desktopModule, desktopHomeModules }:
      nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs username; };
        modules = [
          ./hosts/nixos
          gpuModule
          desktopModule
          aagl.nixosModules.default
          home-manager.nixosModules.home-manager
          {
            nix.settings = aagl.nixConfig;
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "bak";
              extraSpecialArgs = { inherit inputs username; };
              users.${username} = {
                imports = desktopHomeModules;
              };
            };
          }
        ];
      };

    plasmaHomeModules = [
      ./home
      ./home/plasma-apps.nix
      plasma-manager.homeModules.plasma-manager
      ./home/plasma.nix
    ];
    hyprlandHomeModules = [
      ./home
      caelestia-shell.homeManagerModules.default
      ./home/caelestia.nix
    ];
  in {
    nixosConfigurations = {

      nvidia-plasma = mkConfiguration {
        gpuModule = ./hosts/nixos/gpu-nvidia.nix;
        desktopModule = ./hosts/nixos/plasma.nix;
        desktopHomeModules = plasmaHomeModules;
      };

      nvidia-hyprland = mkConfiguration {
        gpuModule = ./hosts/nixos/gpu-nvidia.nix;
        desktopModule = ./hosts/nixos/hyprland.nix;
        desktopHomeModules = hyprlandHomeModules;
      };

      amd-plasma = mkConfiguration {
        gpuModule = ./hosts/nixos/gpu-amd.nix;
        desktopModule = ./hosts/nixos/plasma.nix;
        desktopHomeModules = plasmaHomeModules;
      };

      amd-hyprland = mkConfiguration {
        gpuModule = ./hosts/nixos/gpu-amd.nix;
        desktopModule = ./hosts/nixos/hyprland.nix;
        desktopHomeModules = hyprlandHomeModules;
      };

      intel-plasma = mkConfiguration {
        gpuModule = ./hosts/nixos/gpu-intel.nix;
        desktopModule = ./hosts/nixos/plasma.nix;
        desktopHomeModules = plasmaHomeModules;
      };

      intel-hyprland = mkConfiguration {
        gpuModule = ./hosts/nixos/gpu-intel.nix;
        desktopModule = ./hosts/nixos/hyprland.nix;
        desktopHomeModules = hyprlandHomeModules;
      };
    };
  };
}
