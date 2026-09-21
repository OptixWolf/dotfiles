{ pkgs, ... }:
{
  boot.kernelPackages = pkgs.linuxPackages_latest;
  networking.hostName = "NixOS-Arbeitsrechner";

  services.xserver.videoDrivers = [ "modesetting" ];

  boot.initrd.availableKernelModules = [ "vmd" ];
  boot.kernelModules = [ "kvm-intel" ];
  hardware.cpu.intel.updateMicrocode = true;

  local.wallpaper = {
    enable = true;
    screens = [
      {
        output = "eDP-1";
        id = "1345100339";
      }
    ];
  };
}
