{ pkgs, ... }:
let
  sugar-candy = pkgs.stdenvNoCC.mkDerivation {
    pname = "sddm-sugar-candy";
    version = "unstable";
    src = pkgs.fetchFromGitLab {
      domain = "framagit.org";
      owner = "MarianArlt";
      repo = "sddm-sugar-candy";
      rev = "2b72ef6c6f720fe0ffde5ea5c7c48152e02f6c4f";
      hash = "sha256-S33c7qSgTVPNA0MqZhecJnb3NG57UMDXe0cWGy0cIuI=";
    };

    installPhase = ''
      mkdir -p $out/share/sddm/themes/Sugar-Candy
      cp -r ./* $out/share/sddm/themes/Sugar-Candy/
      substituteInPlace $out/share/sddm/themes/Sugar-Candy/theme.conf \
        --replace-fail 'Background="Backgrounds/Mountain.jpg"' \
        'Background="${pkgs.kdePackages.plasma-workspace-wallpapers}/share/wallpapers/Milkyway/contents/images/1920x1080.png"'
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
