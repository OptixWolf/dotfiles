{ config, lib, pkgs, ... }:
{
  programs.caelestia = {
    enable = true;

    systemd.enable = false;

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
