{ config, lib, pkgs, username, inputs, ... }:
let
  virusEvent = pkgs.writeShellScript "clamav-virus-event" ''
    export PATH=${lib.makeBinPath [ pkgs.coreutils pkgs.libnotify ]}
    ALERT="Signature detected by clamav: $CLAM_VIRUSEVENT_VIRUSNAME in $CLAM_VIRUSEVENT_FILENAME"

    for ADDRESS in /run/user/*; do
      USERID=''${ADDRESS#/run/user/}
      case "$USERID" in *[!0-9]*|"") continue ;; esac
      [ "$USERID" -ge 1000 ] || continue

      /run/wrappers/bin/sudo -u "#$USERID" \
        DBUS_SESSION_BUS_ADDRESS="unix:path=$ADDRESS/bus" \
        ${pkgs.libnotify}/bin/notify-send -u critical -i dialog-warning \
          "Virus found!" "$ALERT" || true
    done
  '';
in
{
  imports = [
    ./hardware-configuration.nix
    ./disks.nix
  ];

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    device = "nodev";
    theme = inputs.distro-grub-themes.packages.${pkgs.stdenv.hostPlatform.system}.nixos-grub-theme;
    gfxmodeEfi = "1920x1080";
    splashImage = null;
    configurationLimit = 20;
  };
  boot.loader.efi.canTouchEfiVariables = true;

  boot.plymouth.enable = true;

  boot.kernelParams = [
    "quiet"
    "splash"
    "udev.log_level=3"
    "rd.systemd.show_status=false"
    "fbcon=nodefer"
  ];
  boot.consoleLogLevel = 0;
  boot.initrd.verbose = false;

  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.supportedFilesystems = [ "ntfs" "exfat" ];

  hardware.enableRedistributableFirmware = true;
  hardware.cpu.amd.updateMicrocode = true;

  networking.hostName = "NixOS-01";
  networking.networkmanager.enable = true;

  programs.dconf.enable = true;

  environment.systemPackages = with pkgs; [
    glib
    gsettings-desktop-schemas
  ];
  
  environment.sessionVariables.XDG_DATA_DIRS = [
    "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}"
  ];

  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "de_DE.UTF-8";
  services.xserver.xkb = {
    layout = "de";
    variant = "deadacute";
  };
  console.useXkbConfig = true;

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

  hardware.bluetooth.enable = true;

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
  services.pcscd.enable = true;

  services.clamav = {
    daemon.enable = true;
    daemon.settings = {
      VirusEvent = "${virusEvent}";
      OnAccessMountPath = "/";
      OnAccessPrevention = false;
      OnAccessExcludeUname = "clamav";
      OnAccessExcludeRootUID = true;
    };

    updater = {
      enable = true;
      frequency = 12;
      interval = "hourly";
    };

    clamonacc.enable = true;
  };

  security.sudo.extraRules = [{
    users = [ "clamav" ];
    runAs = "ALL";
    commands = [{
      command = "${pkgs.libnotify}/bin/notify-send";
      options = [ "NOPASSWD" "SETENV" ];
    }];
  }];

  programs.gpu-screen-recorder = {
    enable = true;
    ui.enable = true;
  };
  
  systemd.user.services.gpu-screen-recorder-ui = {
    description = "GPU Screen Recorder UI";
    wantedBy  = [ "graphical-session.target" ];
    after     = [ "graphical-session.target" ];
    partOf    = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart = "${lib.getExe pkgs.gpu-screen-recorder-ui} launch-daemon";
      Restart = "on-failure";
      RestartSec = 3;
    };
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
    nerd-fonts.meslo-lg
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
