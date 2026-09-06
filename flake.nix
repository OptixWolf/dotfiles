{
  description = "OptixWolfs NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-gsr-ui.url = "github:js6pak/nixpkgs/gpu-screen-recorder-ui/init";

    distro-grub-themes = {
      url = "github:AdisonCavani/distro-grub-themes";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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

      desktopModules = [
        ./hosts/nixos/plasma.nix
        ./hosts/nixos/hyprland.nix
      ];

      combinedHomeModules = [
        ./home
        ./home/plasma-apps.nix
        plasma-manager.homeModules.plasma-manager
        ./home/plasma.nix
        caelestia-shell.homeManagerModules.default
        ./home/caelestia.nix
      ];

      mkConfiguration = { gpuModule }:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs username; };
          modules = [
            ./hosts/nixos
            gpuModule
            aagl.nixosModules.default
            home-manager.nixosModules.home-manager
          ]
          ++ desktopModules
          ++ [
            ({ pkgs, ... }: {
              nix.settings = aagl.nixConfig;
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                backupCommand = "${pkgs.coreutils}/bin/mv -f";
                extraSpecialArgs = { inherit inputs username; };
                users.${username} = {
                  imports = combinedHomeModules;
                };
              };
            })
          ];
        };
    in {
      nixosConfigurations = {
        nvidia = mkConfiguration {
          gpuModule = ./hosts/nixos/gpu-nvidia.nix;
        };

        amd = mkConfiguration {
          gpuModule = ./hosts/nixos/gpu-amd.nix;
        };

        intel = mkConfiguration {
          gpuModule = ./hosts/nixos/gpu-intel.nix;
        };
      };
    };
}
