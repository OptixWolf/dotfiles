{ pkgs, ... }:
let
  andromeda-launcher = pkgs.stdenvNoCC.mkDerivation {
    pname = "andromeda-launcher";
    version = "unstable";
    src = pkgs.fetchFromGitHub {
      owner = "EliverLara";
      repo = "AndromedaLauncher";
      rev = "6bd0ac49b60888dd502169b0eacf5ca5146b1ec1";
      hash = "sha256-MSYD8eH6m4vWfvoAfHkqMed+ZGjFE0Ln75cqIZYq9Eg=";
    };
    installPhase = ''
      mkdir -p $out/share/plasma/plasmoids/AndromedaLauncher
      cp -r contents metadata.json $out/share/plasma/plasmoids/AndromedaLauncher/
    '';
  };
in
{
  home.packages = with pkgs; [
    kara
    plasmusic-toolbar
    kurve
    cava
    andromeda-launcher
    kdePackages.dragon
    kdePackages.elisa
  ];
}
