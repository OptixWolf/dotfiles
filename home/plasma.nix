{ ... }:
{
  programs.plasma.configFile.kxkbrc.Layout = {
    LayoutList = "de";
    Use = true;
  };

  programs.plasma = {
    enable = true;

    kwin.virtualDesktops = {
      number = 2;
      rows = 1;
    };

    workspace = {
      theme = "Orchis-dark";
      colorScheme = "We10XOSDark";
      iconTheme = "Papirus-Dark";

      windowDecorations = {
        library = "org.kde.kwin.aurorae";
        theme = "__aurorae__svg__WillowDarkAlt";
      };
    };

    panels = [
      {
        location = "bottom";
        screen = 0;
        floating = true;
        lengthMode = "fit";
        hiding = "dodgewindows";
        widgets = [
          {
            name = "AndromedaLauncher";
            config.General = {
              activationIndicator = false;
              customButtonImage = "distributor-logo-archlinux";
              customGreeting = "Wer das liest, muss ein Croissant essen!";
              floating = true;
              launcherPosition = 1;
              showRecentApps = false;
              showRecentDocs = false;
              useCustomButtonImage = true;
              useSystemFontSettings = true;
            };
          }
          {
            name = "org.kde.plasma.icontasks";
            config.General.launchers = "preferred://filemanager,applications:org.kde.konsole.desktop,applications:termius-app.desktop,applications:librewolf.desktop,applications:firefox.desktop,applications:vesktop.desktop,applications:steam.desktop,applications:p3x-onenote.desktop,applications:teams-for-linux.desktop,applications:code.desktop,applications:rider.desktop,applications:feishin.desktop";
          }
          "org.kde.plasma.marginsseparator"
        ];
      }
      {
        location = "top";
        screen = 0;
        widgets = [
          {
            name = "org.dhruv8sh.kara";
            config.General = {
              type = 0;
              t1activeWidth = 30;
            };
          }
          {
            name = "org.kde.plasma.appmenu";
            config.General.compactView = true;
          }
          "plasmusic-toolbar"
          "org.kde.plasma.panelspacer"
          {
            name = "luisbocanegra.audio.visualizer";
            config.General = {
              visualizerStyle = 0;
              barColors = ''{"enabled":false,"lightness":0.5,"saturation":0.5,"alpha":1,"systemColor":"highlightColor","systemColorSet":"Window","custom":"#dedede","list":["#ED8796","#A6DA95","#EED49F","#8AADF4","#F5BDE6","#8BD5CA","#f5a97f"],"reverseList":false,"followColor":0,"saturationEnabled":false,"lightnessEnabled":false,"sourceType":0,"smoothGradient":true,"colorsOrientation":0,"image":{"source":"","fillMode":2},"hueStart":0,"hueEnd":360}'';
            };
          }
          "org.kde.plasma.panelspacer"
          "org.kde.plasma.catwalk"
          "org.kde.plasma.colorpicker"
          {
            systemTray.items = {
              shown = [
                "org.kde.plasma.volume"
                "org.kde.plasma.networkmanagement"
                "org.kde.plasma.clipboard"
              ];
              hidden = [
                "org.kde.kdeconnect"
                "org.kde.plasma.devicenotifier"
                "org.kde.plasma.cameraindicator"
              ];
            };
          }
          {
            name = "org.kde.plasma.digitalclock";
            config.Appearance = {
              autoFontAndSize = false;
              fontFamily = "Noto Sans";
              fontSize = 20;
              fontWeight = 400;
              showDate = false;
              showSeconds = "Always";
            };
          }
          {
            name = "org.kde.plasma.userswitcher";
            config.General = {
              showFace = true;
              showName = false;
            };
          }
        ];
      }
    ];

    window-rules = [
      {
        description = "Wallpaper Engine Linux - Keep Below";
        match.window-class = {
          value = "linux-wallpaperengine linux-wallpaperengine";
          match-whole = true;
        };
        apply = {
          below = { value = true; apply = "force"; };
          fullscreen = { value = true; apply = "force"; };
          screen = { value = 1; apply = "force"; };
          skip-pager = { value = true; apply = "force"; };
          skip-switcher = { value = true; apply = "force"; };
          skip-taskbar = { value = true; apply = "force"; };
        };
      }
      {
        description = "WuWa Transparency";
        match.window-class = {
          value = "steam_app_3513350";
          match-whole = true;
        };
        apply.opacity = {
          value = 2;
          apply = "force";
        };
      }
    ];

    powerdevil = {
      AC = {
        autoSuspend.action = "nothing";
        turnOffDisplay.idleTimeout = "never";
        dimDisplay.enable = false;
      };
      battery = {
        autoSuspend.action = "nothing";
        turnOffDisplay.idleTimeout = "never";
        dimDisplay.enable = false;
      };
      lowBattery = {
        autoSuspend.action = "nothing";
        turnOffDisplay.idleTimeout = "never";
        dimDisplay.enable = false;
      };
    };

    kscreenlocker = {
      autoLock = false;
      lockOnResume = false;
    };

    shortcuts = {
      plasmashell."activate application launcher" = [ "Meta" "Alt+F1" ];
    };
  };
}
