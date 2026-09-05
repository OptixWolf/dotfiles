{ pkgs, ... }:
{
  programs.plasma.configFile.kxkbrc.Layout = {
    LayoutList = "de";
    Use = true;
  };

  programs.plasma.workspace.windowDecorations = {
    library = "org.kde.kwin.aurorae";
    theme = "__aurorae__svg__WillowDarkAlt";
  };

  programs.plasma = {
    enable = true;

    input.mice = [
    {
      name = "Logitech G502 HERO Gaming Mouse";
      vendorId = "046d";
      productId = "c08b";
      accelerationProfile = "none";
    }
  ];

    kwin = {
      edgeBarrier = 0;
    };

    kwin.virtualDesktops = {
      number = 2;
      rows = 1;
    };

    workspace = {
      theme = "Orchis-dark";
      colorScheme = "We10XOSDark";
      iconTheme = "Papirus-Dark";
      cursor.cursorFeedback = "None";
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
            config.General.launchers = "preferred://filemanager,applications:org.kde.konsole.desktop,applications:termius-app.desktop,applications:librewolf.desktop,applications:firefox.desktop,applications:vesktop.desktop,applications:steam.desktop,applications:p3x-onenote.desktop,applications:teams-for-linux.desktop,applications:codium.desktop,applications:rider.desktop,applications:feishin.desktop";
          }
          "org.kde.plasma.marginsseparator"
        ];
      }
      {
        location = "top";
        height = 36;
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
                "org.kde.plasma.mediacontroller"
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

      appearance.wallpaper = "${pkgs.kdePackages.plasma-workspace-wallpapers}/share/wallpapers/Nexus/contents/images_dark/5120x2880.png";
    };

    shortcuts = {
      plasmashell."activate application launcher" = [ "Meta" "Alt+F1" ];
    };
  };

    programs.konsole = {
    enable = true;
    defaultProfile = "Default";

    # "Weiß auf Schwarz" mit #1e1e1e Hintergrund
    customColorSchemes.WhiteOnBlack1e1e1e = {
      General = {
        Description = "White on Black (#1e1e1e)";
        Opacity = 1;
      };

      Background.Color        = "30,30,30";
      BackgroundIntense.Color = "30,30,30";
      BackgroundFaint.Color   = "30,30,30";

      Foreground.Color      = "255,255,255";
      ForegroundFaint.Color = "255,255,255";
      ForegroundIntense = {
        Color = "255,255,255";
        Bold  = true;
      };

      Color0.Color = "0,0,0";        Color0Intense.Color = "104,104,104";  Color0Faint.Color = "24,24,24";
      Color1.Color = "178,24,24";    Color1Intense.Color = "255,84,84";    Color1Faint.Color = "101,0,0";
      Color2.Color = "24,178,24";    Color2Intense.Color = "84,255,84";    Color2Faint.Color = "0,101,0";
      Color3.Color = "178,104,24";   Color3Intense.Color = "255,255,84";   Color3Faint.Color = "101,74,0";
      Color4.Color = "24,24,178";    Color4Intense.Color = "84,84,255";    Color4Faint.Color = "0,0,101";
      Color5.Color = "178,24,178";   Color5Intense.Color = "255,84,255";   Color5Faint.Color = "95,5,95";
      Color6.Color = "24,178,178";   Color6Intense.Color = "84,255,255";   Color6Faint.Color = "24,178,178";
      Color7.Color = "178,178,178";  Color7Intense.Color = "255,255,255";  Color7Faint.Color = "101,101,101";
    };

    profiles.Default = {
      name = "Default";
      colorScheme = "WhiteOnBlack1e1e1e";
      font = {
        name = "Hack";
        size = 10;
      };
    };
  };
}
