{ pkgs, ... }:
{
  programs.firefox = {
    enable = true;
    languagePacks = [ "de" ];
  };

  home.packages = with pkgs; [
    # Browser
    brave
    librewolf
    ungoogled-chromium
    pear-desktop
    p3x-onenote

    # Kommunikation
    discord-canary
    vesktop
    element-desktop
    telegram-desktop
    teams-for-linux
    zoom-us
    zapzap

    # Buero
    onlyoffice-desktopeditors
    obsidian
    geogebra6

    # Medien
    gimp
    obs-studio
    feishin
    easyeffects

    # Netzwerk und Remote
    filezilla
    remmina
    moonlight-qt
    parsec-bin
    nextcloud-client
    proton-vpn

    # Geraete und Werkzeuge
    android-tools
    scrcpy
    fusee-nano
    ruffle
    xclicker
    yubioath-flutter
    veracrypt
    gparted
    linux-wallpaperengine
    clamtk
  ];
}
