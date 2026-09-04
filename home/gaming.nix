{ pkgs, ... }:
{
  home.packages = with pkgs; [
    lutris
    heroic
    prismlauncher
    bottles
    protonplus
    wine
    alvr
    sidequest
  ];
}
