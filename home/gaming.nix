{ pkgs, ... }:
{
  home.packages = with pkgs; [
    lutris
    heroic
    itch
    (pkgs.prismlauncher.override {
      jdks = with pkgs; [
        jdk8
        jdk17
        jdk21
        jdk25
      ];
    })
    (bottles.override { removeWarningPopup = true; })
    protonplus
    wine
    alvr
    sidequest
    ns-usbloader
  ];
}
