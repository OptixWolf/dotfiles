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
      hash = "sha256-mO1AVrnXNdg3Rftj0cQWef/RrBgSDy5kaMHagwKywEo=";
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
      runHook preInstall

      theme=$out/share/aurorae/themes/WillowDarkAlt
      mkdir -p $theme

      # Dekoration + Buttons (Alt-Variante) + rc/metadata
      cp -a aurorae-themes/src/dark/opaque/*    $theme/
      cp -a aurorae-themes/src/dark/icons-alt/* $theme/
      cp -a aurorae-themes/WillowDarkAlt/*      $theme/

      # Backup-Dateien aus dem Repo aussortieren
      rm -f $theme/*.bak $theme/*.LEFTbak

      # Plasma 6 braucht metadata.json
      cat > $theme/metadata.json <<'EOF'
      {
        "KPlugin": {
          "Authors": [ { "Name": "doncsugar" } ],
          "EnabledByDefault": true,
          "Id": "willow-dark-alt-aurorae",
          "License": "GPLv3",
          "Name": "Willow Dark Alt",
          "Version": "0.1"
        }
      }
      EOF

      runHook postInstall
    '';
  };

  wallpaper = "${pkgs.kdePackages.plasma-workspace-wallpapers}/share/wallpapers/MilkyWay/contents/images/5120x2880.png";

  sddm-theme = pkgs.sddm-astronaut.override {
    embeddedTheme = "hyprland_kath";
    themeConfig = {
      Background            = wallpaper;
      BackgroundPlaceholder = wallpaper;
      CropBackground        = "true";
      FullBlur              = "false";
      PartialBlur           = "true";
      Blur                  = "2.0";
      BlurMax               = "48";
      DimBackground         = "0.25";

      BackgroundColor     = "#0b1026";
      DimBackgroundColor  = "#05070f";
      FormBackgroundColor = "#131a33";

      HeaderTextColor = "#e6e9f5";
      DateTextColor   = "#e6e9f5";
      TimeTextColor   = "#e6e9f5";

      LoginFieldBackgroundColor    = "#1b2444";
      PasswordFieldBackgroundColor = "#1b2444";
      LoginFieldTextColor          = "#e6e9f5";
      PasswordFieldTextColor       = "#e6e9f5";
      PlaceholderTextColor         = "#8b93b5";

      UserIconColor          = "#9db4ff";
      PasswordIconColor      = "#9db4ff";
      HoverUserIconColor     = "#c9a7ff";
      HoverPasswordIconColor = "#c9a7ff";

      LoginButtonBackgroundColor = "#7aa2f7";
      LoginButtonTextColor       = "#0b1026";

      SystemButtonsIconsColor             = "#c8cfe8";
      HoverSystemButtonsIconsColor        = "#c9a7ff";
      SessionButtonTextColor              = "#c8cfe8";
      HoverSessionButtonTextColor         = "#c9a7ff";
      VirtualKeyboardButtonTextColor      = "#c8cfe8";
      HoverVirtualKeyboardButtonTextColor = "#c9a7ff";

      DropdownBackgroundColor         = "#131a33";
      DropdownTextColor               = "#e6e9f5";
      DropdownSelectedBackgroundColor = "#2a3563";

      HighlightBackgroundColor = "#7aa2f7";
      HighlightTextColor       = "#0b1026";
      HighlightBorderColor     = "#c9a7ff";

      WarningColor = "#f7768e";
    };
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
    enable = true;
    theme = "sddm-astronaut-theme";
    extraPackages = [ sddm-theme ];
  };

  environment.systemPackages = with pkgs; [
    sddm-theme
    catwalk
    papirus-dark
    orchis-plasma-style
    we10xos-colors
    willow-aurorae
    kdePackages.aurorae
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
