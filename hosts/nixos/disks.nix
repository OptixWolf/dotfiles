{ ... }:
{
  boot.initrd.luks.devices = {
    cryptroot.device = "/dev/nvme0n1p2";
    cryptswap.device = "/dev/nvme0n1p3";
  };

  boot.initrd.systemd.enable = true;

  fileSystems."/" = {
    device = "/dev/mapper/cryptroot";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/nvme0n1p1";
    fsType = "vfat";
    options = [ "fmask=0077" "dmask=0077" ];
  };

  swapDevices = [ { device = "/dev/mapper/cryptswap"; } ];

  fileSystems."/mnt/linuxgames" = {
    device = "/dev/sda1";
    fsType = "ext4";
    options = [ "nofail" ];
  };
}
