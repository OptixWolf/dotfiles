{ ... }:
{
  networking.hostName = "NixOS-Arbeitsrechner";

  services.xserver.videoDrivers = [ "modesetting" ];
}