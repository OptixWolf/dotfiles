{ pkgs, username, ... }:
let
  omnircm-bin = pkgs.fetchurl {
    url = "https://github.com/DefenderOfHyrule/OmniRCM/releases/download/v1.1.1/OmniRCM-linux-x64";
    hash = "sha256-voNweYkWf5StYdxVwnWXIhPI8N/mObXyNmH1EXVaIYY=";
    executable = true;
  };

  omnircm = pkgs.buildFHSEnv {
    name = "omnircm";
    targetPkgs = p: with p; [
      libusb1
      stdenv.cc.cc.lib
      fontconfig freetype
      libx11 libice libsm libxi
      libxcursor libxext libxrandr libxrender
      libGL
      gtk3 glib
      openssl zlib icu krb5
    ];
    runScript = "${omnircm-bin}";
    extraInstallCommands = ''
      mkdir -p $out/share/applications
      cat > $out/share/applications/omnircm.desktop <<EOF
      [Desktop Entry]
      Type=Application
      Name=OmniRCM
      Comment=Nintendo Switch RCM payload injector
      Exec=omnircm
      Terminal=false
      Categories=Utility;
      EOF
    '';
  };

  sysdvr-flatpak = pkgs.fetchurl {
    url = "https://github.com/exelix11/SysDVR/releases/download/v6.3/SysDVR-Client-Linux-x64.flatpak";
    hash = "sha256-Y5m0q+TV6tzQTRSzas1zXMLYJRjxGcXc816FGCPLvr4=";
  };

  sysdvr-desktop = pkgs.makeDesktopItem {
    name = "sysdvr";
    desktopName = "SysDVR";
    comment = "Nintendo Switch auf den PC streamen";
    exec = "flatpak run com.github.exelix11.sysdvr";
    icon = "com.github.exelix11.sysdvr";
    categories = [ "AudioVideo" "Utility" ];
  };
in
{
  environment.systemPackages = [
    omnircm
    sysdvr-desktop
  ];

  services.flatpak.enable = true;

  systemd.services.flatpak-setup = {
    description = "Flathub einrichten und SysDVR installieren";
    wantedBy = [ "multi-user.target" ];
    wants = [ "network-online.target" ];
    after = [ "network-online.target" ];
    path = [ pkgs.flatpak ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      StateDirectory = "flatpak-setup";
    };
    script = ''
      flatpak remote-add --system --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

      # Nur neu installieren, wenn sich das Bundle geaendert hat
      marker=/var/lib/flatpak-setup/sysdvr
      if [ "$(cat "$marker" 2>/dev/null)" != "${sysdvr-flatpak}" ]; then
        flatpak install --system --noninteractive --reinstall --bundle ${sysdvr-flatpak}
        echo "${sysdvr-flatpak}" > "$marker"
      fi
    '';
  };

  services.udev.packages = [
    (pkgs.writeTextFile {
      name = "nintendo-switch-udev-rules";
      destination = "/etc/udev/rules.d/70-nintendo-switch.rules";
      text = ''
        SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ATTR{idVendor}=="0955", ATTR{idProduct}=="7321", MODE="0660", GROUP="nintendo_switch", TAG+="uaccess"
        SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ATTR{idVendor}=="057e", ATTR{idProduct}=="3000", MODE="0660", GROUP="nintendo_switch", TAG+="uaccess"
        SUBSYSTEM=="usb", ATTRS{idVendor}=="18d1", ATTRS{idProduct}=="4ee0", MODE="0660", GROUP="nintendo_switch", TAG+="uaccess"
      '';
    })
  ];

  users.groups.nintendo_switch = { };
  users.users.${username}.extraGroups = [ "nintendo_switch" ];
}