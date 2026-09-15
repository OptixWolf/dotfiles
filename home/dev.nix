{ pkgs, ... }:
{
  programs.vscodium = {
    enable = true;
  };

  home.packages = with pkgs; [
    jetbrains.rider
    jetbrains.pycharm
    jetbrains.idea
    android-studio
    unityhub
    mongodb-compass
    mysql-workbench
    termius
    docker-compose
  ];
}
