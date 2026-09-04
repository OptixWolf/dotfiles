{ ... }:
{
  programs.plasma = {
    enable = true;

    workspace = {
      theme = "Orchis-dark";
      colorScheme = "We10XOSDark";
      iconTheme = "Papirus-Dark";

      windowDecorations = {
        library = "org.kde.kwin.aurorae.v2";
        theme = "__aurorae__svg__WillowDarkAlt";
      };
    };

    panels = [
      {
        location = "bottom";
        screen = 0;
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
            config.General.launchers = "preferred://filemanager,applications:org.kde.konsole.desktop,applications:termius-app.desktop,preferred://browser,applications:vesktop.desktop,applications:steam.desktop,applications:p3x-onenote.desktop,applications:teams-for-linux.desktop,applications:code.desktop,applications:jetbrains-rider-cb74fc67-d8d4-4cc4-908f-42399c6b59c0.desktop,applications:feishin.desktop";
          }
          "org.kde.plasma.marginsseparator"
        ];
      }
      {
        location = "bottom";
        screen = 1;
        widgets = [
          "org.kde.plasma.digitalclock"
          "org.kde.plasma.systemtray"
          "org.kde.plasma.colorpicker"
          "org.kde.plasma.panelspacer"
          "org.kde.plasma.panelspacer"
          "org.kde.plasma.catwalk"
          "plasmusic-toolbar"
          "org.kde.plasma.appmenu"
          "luisbocanegra.audio.visualizer"
          "org.kde.plasma.userswitcher"
          "org.dhruv8sh.kara"
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
        apply.opacity.active = {
          value = 2;
          apply = "force";
        };
      }
    ];

    powerdevil = {
      AC = {
        autoSuspend.action = "nothing";
        turnOffDisplay.idleTimeout = "never";
      };
      battery = {
        autoSuspend.action = "nothing";
        turnOffDisplay.idleTimeout = "never";
      };
      lowBattery = {
        autoSuspend.action = "nothing";
        turnOffDisplay.idleTimeout = "never";
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
