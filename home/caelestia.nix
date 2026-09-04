{ config, lib, pkgs, ... }:
{
  programs.caelestia = {
    enable = true;

    settings = {
      # theme = "dark";
      # bar.enabled = true;
    };

    # extraConfig = ''
    #   { "some": "value" }
    # '';

    cli = {
      enable = true;
      # settings = { };
      # extraConfig = "";
    };
  };
}
