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
    (mysql-workbench.overrideAttrs (old: {
      postPatch = (old.postPatch or "") + ''
      sed -i '1i #include <boost/static_assert.hpp>' \
      library/base/base/string_utilities.h
    '';
    }))
    termius
    docker-compose
  ];
}
