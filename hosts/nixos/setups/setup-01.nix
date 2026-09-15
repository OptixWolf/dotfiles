{ config, pkgs, lib, ... }:
{
  networking.hostName = "NixOS-01";

  local.wallpaper = {
    enable = true;
    screens = [
      {
        output = "DP-2";
        id = "3478544779";
      }
      {
        output = "DP-1";
        id = "1345100339";
      }
    ];
    environment = [ "__GL_THREADED_OPTIMIZATIONS=0" ];
  };

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

  fileSystems."/mnt/linuxgames" = {
    device = "/dev/sda1";
    fsType = "ext4";
    options = [ "nofail" ];
  };
}