{ ... }:
{
  networking.hostName = "NixOS-Arbeitsrechner";

  services.xserver.videoDrivers = [ "modesetting" ];

  boot.initrd.availableKernelModules = [ "vmd" ];
  boot.kernelModules = [ "kvm-intel" ];
  hardware.cpu.intel.updateMicrocode = true;
}
