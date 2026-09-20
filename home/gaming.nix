{ pkgs, ... }:
{
  home.packages = with pkgs; [
    lutris
    heroic
    itch
    prismlauncher
    (bottles.override { removeWarningPopup = true; })
    protonplus
    wine
    alvr
    sidequest
    ns-usbloader
  ];
}
