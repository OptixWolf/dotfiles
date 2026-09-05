{ pkgs, lib, ... }:
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

    # Kommunikation
    discord-canary
    element-desktop
    telegram-desktop
    vesktop
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

  services.easyeffects = {
    enable = true;
    settings.Window.showTrayIcon = false;
  };
  
  xdg.autostart = {
  enable = true;
  entries = [
    "${pkgs.zapzap}/share/applications/zapzap.desktop"
  ];
};
}
