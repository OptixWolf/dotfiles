{ pkgs, lib, ... }:
let
  src = pkgs.fetchFromGitHub {
    owner = "tkashkin";
    repo = "Adwaita-for-Steam";
    rev = "1e92107a51f6ed53c59c38646444c9eb3a52b030";
    hash = "sha256-wH0z2LZ94j5ErRI40f9IRBJXJ6yuL+NLgjmj9G8odxU=";
  };

  adwaita-for-steam = pkgs.writeShellScript "adwaita-for-steam" ''
    [ -f "$HOME/.steam/steam/steamui/css/library.css" ] || exit 0
    work=$(mktemp -d)
    trap 'rm -rf "$work"' EXIT
    cp -r ${src}/. "$work/"
    chmod -R u+w "$work"
    cd "$work"
    ${pkgs.python3}/bin/python3 ./install.py -c adwaita-gray -e login/hover-qr
  '';
in
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

  home.pointerCursor = {
    enable = true;
    name = "breeze_cursors";
    package = pkgs.kdePackages.breeze;
    size = 24;
    x11.enable = true;
    gtk.enable = true;
  };

  home.activation.adwaita-for-steam = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    run ${adwaita-for-steam}
  '';
}
