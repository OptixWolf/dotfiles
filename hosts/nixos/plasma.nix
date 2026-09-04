{ pkgs, ... }:
let
  papirus-dark = pkgs.papirus-icon-theme;

  orchis-plasma-style = pkgs.stdenvNoCC.mkDerivation {
    pname = "orchis-plasma-style";
    version = "unstable";
    src = pkgs.fetchFromGitHub {
      owner = "vinceliuice";
      repo = "Orchis-kde";
      rev = "b2a96919eee40264e79db402b915f926436100ad";
      hash = "sha256-m01AVrnXNdg3Rftj0cQWef/RrBgSDy5kaMHagwKywEo=";
    };
    installPhase = ''
      mkdir -p $out/share/plasma/desktoptheme
      cp -r plasma/desktoptheme/Orchis-dark $out/share/plasma/desktoptheme/
    '';
  };

  we10xos-colors = pkgs.stdenvNoCC.mkDerivation {
    pname = "we10xos-colors";
    version = "unstable";
    src = pkgs.fetchFromGitHub {
      owner = "yeyushengfan258";
      repo = "We10XOS-kde";
      rev = "270f0d7d3c1f0d5540109e6116d2fa891664f24b";
      hash = "sha256-EXhFazRo76BVcAEigsB5GIMOsNe27ztBDUcHv8JWXS0=";
    };
    installPhase = ''
      mkdir -p $out/share/color-schemes
      cp color-schemes/We10XOSDark.colors $out/share/color-schemes/
    '';
  };

  willow-aurorae = pkgs.stdenvNoCC.mkDerivation {
   pname = "willow-aurorae";
   version = "unstable-plasma6";
   src = pkgs.fetchFromGitHub {
     owner = "doncsugar";
     repo = "willow-theme";
     rev = "59b4e62ec63a6948e0f2fbc78a5d951b36a7f584";
     hash = "sha256-NPf9uCnIdvRna1X3hvbFZCQYDvcLeMWWd2xjHbDGmA4=";
   };
   installPhase = ''
     mkdir -p $out/share/aurorae/themes
     cp -r aurorae-themes/WillowDarkAlt $out/share/aurorae/themes/
   '';
  };

  sugar-candy = pkgs.stdenvNoCC.mkDerivation {
    pname = "sddm-sugar-candy";
    version = "unstable";
    src = pkgs.fetchFromGitLab {
      domain = "framagit.org";
      owner = "MarianArlt";
      repo = "sddm-sugar-candy";
      rev = "2b72ef6c6f720fe0ffde5ea5c7c48152e02f6c4f";
      hash = "sha256-XggFVsEXLYklrfy1ElkIp9fkTw4wuXbyVkaVC2q4ZLU=";
    };

    installPhase = ''
      mkdir -p $out/share/sddm/themes/Sugar-Candy
      cp -r ./* $out/share/sddm/themes/Sugar-Candy/
      substituteInPlace $out/share/sddm/themes/Sugar-Candy/theme.conf \
        --replace-fail 'Background="Backgrounds/Mountain.jpg"' \
        'Background="${pkgs.kdePackages.plasma-workspace-wallpapers}/share/wallpapers/Milkyway/contents/images/1920x1080.png"'
    '';
  };

  catwalk = pkgs.stdenvNoCC.mkDerivation {
    pname = "plasma-catwalk";
    version = "unstable";
    src = ./extras/org.kde.plasma.catwalk;

    dontConfigure = true;
    dontBuild = true;

    installPhase = ''
      mkdir -p $out/share/plasma/plasmoids/org.kde.plasma.catwalk
      cp -r . $out/share/plasma/plasmoids/org.kde.plasma.catwalk/
    '';
  };
in
{
  services.desktopManager.plasma6.enable = true;

  services.displayManager.sddm = {
    theme = "Sugar-Candy";
  };

  environment.systemPackages = with pkgs; [
    sugar-candy
    catwalk
    papirus-dark
    orchis-plasma-style
    we10xos-colors
    willow-aurorae
    kdePackages.plasma-workspace-wallpapers
    kdePackages.okular
    kdePackages.kolourpaint
    kdePackages.ktorrent
    kdePackages.konsole
    kdePackages.kate
    kdePackages.kcalc
    kdePackages.kcolorchooser
    kdePackages.filelight
    kdePackages.krdc
    kdePackages.krdp
    kdePackages.krfb
    kdePackages.partitionmanager
    kdePackages.kio-extras
    kdePackages.kio-admin
    kdePackages.kio-gdrive
  ];
}
