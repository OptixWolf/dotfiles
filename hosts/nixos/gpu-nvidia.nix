{ config, pkgs, ... }:
{
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.legacy_580;
    open = false;
  };

  hardware.graphics.extraPackages = [
    pkgs.nvidia-vaapi-driver
  ];
}