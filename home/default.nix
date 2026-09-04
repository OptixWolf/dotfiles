{ config, pkgs, ... }:
{
  imports = [
    ./shell
    ./apps.nix
    ./dev.nix
    ./gaming.nix
    ./git.nix
    ./theme.nix
  ];

  programs.home-manager.enable = true;

  home.file = {
    "Bilder".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Nextcloud/Bilder";
    "Desktop".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Nextcloud/Desktop";
    "Dokumente".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Nextcloud/Dokumente";
    "Videos".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Nextcloud/Videos";
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
