{ config, pkgs, lib, ... }:
{
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.legacy_580;
    open = false;

    moduleParams.nvidia.NVreg_TemporaryFilePath = "/var/tmp";
  };

  boot.blacklistedKernelModules = [
    "nouveau"
  ];

  hardware.graphics.extraPackages = [
    pkgs.nvidia-vaapi-driver
  ];

  systemd.services = lib.genAttrs [
    "systemd-suspend"
    "systemd-hibernate"
    "systemd-hybrid-sleep"
    "systemd-suspend-then-hibernate"
  ] (_: {
    environment.SYSTEMD_SLEEP_FREEZE_USER_SESSIONS = "false";
  });
}