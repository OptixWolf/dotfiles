{ pkgs, ... }:
{
  home.packages = with pkgs; [
    lutris
    heroic
    itch
    prismlauncher
    bottles
    protonplus
    wine
    alvr
    sidequest
  ];
}
