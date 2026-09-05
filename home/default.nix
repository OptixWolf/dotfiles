{ config, pkgs, ... }:
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
    pictures  = "${config.home.homeDirectory}/Nextcloud/Bilder";
    documents = "${config.home.homeDirectory}/Nextcloud/Dokumente";
    videos    = "${config.home.homeDirectory}/Nextcloud/Videos";
    desktop   = "${config.home.homeDirectory}/Nextcloud/Desktop";
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
