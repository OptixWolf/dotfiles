{ config, pkgs, username, ... }:
{
  imports = [ ./hardware-configuration.nix ];

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    device = "nodev";
    configurationLimit = 20;
  };
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.supportedFilesystems = [ "ntfs" "exfat" ];

  hardware.enableRedistributableFirmware = true;
  hardware.cpu.amd.updateMicrocode = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "de_DE.UTF-8";
  console.keyMap = "de";

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  security.rtkit.enable = true;
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    remotePlay.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };
  programs.gamescope.enable = true;

  virtualisation.docker.enable = true;
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
  virtualisation.virtualbox.host.enable = true;
  programs.virt-manager.enable = true;

  services.tailscale.enable = true;
  services.logmein-hamachi.enable = true;
  services.power-profiles-daemon.enable = true;
  services.hardware.openrgb.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.udisks2.enable = true;

  services.clamav = {
    daemon.enable = true;
    updater.enable = true;
  };

  services.ollama = {
    enable = true;
    package = pkgs.ollama-cuda;
  };

  programs.anime-game-launcher.enable = true;

  programs.kdeconnect.enable = true;
  programs.appimage = {
    enable = true;
    binfmt = true;
  };
  programs.zsh.enable = true;

  hardware.opentabletdriver.enable = true;

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
  ];

  users.users.${username} = {
    isNormalUser = true;
    description = "OptixWolf";
    shell = pkgs.zsh;
    extraGroups = [
      "wheel"
      "networkmanager"
      "docker"
      "libvirtd"
      "vboxusers"
      "adbusers"
    ];
  };

  # Version der Erstinstallation, wird nicht hochgezogen.
  system.stateVersion = "26.05";
}
