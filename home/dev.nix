{ pkgs, ... }:
{
  programs.vscode.enable = true;

  home.packages = with pkgs; [
    jetbrains-toolbox
    unityhub
    mongodb-compass
    mysql-workbench
    termius
    docker-compose
  ];
}
