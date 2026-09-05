{ pkgs, ... }:
{
  home.packages = [ pkgs.kdePackages.qtstyleplugin-kvantum ];

  gtk = {
    enable = true;
    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };
}
