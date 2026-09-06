{ config, lib, pkgs, ... }:
let
  home = config.home.homeDirectory;
  nc   = "${home}/Nextcloud";
in
{
  imports = [
    ./shell
    ./apps.nix
    ./dev.nix
    ./gaming.nix
    ./git.nix
    ./theme.nix
    ./wallpaper.nix
  ];

  programs.home-manager.enable = true;

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  xdg.userDirs = {
    enable = true;
    createDirectories = false;

    desktop     = "${home}/Schreibtisch";
    documents   = "${home}/Dokumente";
    download    = "${home}/Downloads";
    music       = "${home}/Musik";
    pictures    = "${home}/Bilder";
    publicShare = "${home}/Öffentlich";
    templates   = "${home}/Vorlagen";
    videos      = "${home}/Videos";
  };

  home.file = {
    "Bilder".source       = config.lib.file.mkOutOfStoreSymlink "${nc}/Bilder";
    "Dokumente".source    = config.lib.file.mkOutOfStoreSymlink "${nc}/Dokumente";
    "Videos".source       = config.lib.file.mkOutOfStoreSymlink "${nc}/Videos";
    "Schreibtisch".source = config.lib.file.mkOutOfStoreSymlink "${nc}/Desktop";
  };

  home.packages = with pkgs; [
    curl
    nano
    fastfetch
    testdisk
    unrar
  ];

  # Version der Erstinstallation, wird nicht hochgezogen.
  home.stateVersion = "26.05";
}
