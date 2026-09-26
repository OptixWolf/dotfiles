{ pkgs, ... }:
{
  boot.kernelPackages = pkgs.linuxPackages_zen;
  networking.hostName = "NixOS-02";

  local.wallpaper = {
    enable = true;
    screens = [
      {
        output = "DP-1";
        id = "3478544779";
      }
      {
        output = "HDMI-A-1";
        id = "1345100339";
      }
    ];
  };

  services.xserver.videoDrivers = [ "amdgpu" ];

  services.ollama.package = pkgs.ollama-rocm;

  fileSystems."/mnt/linuxgames" = {
    device = "/dev/nvme1n1p1";
    fsType = "ext4";
    options = [ "nofail" ];
  };
}
