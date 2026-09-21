{ pkgs, lib, osConfig ? null, ... }:
let
  osCfg = if osConfig == null then { } else osConfig;

  cfg = osCfg.local.wallpaper or {
      enable = false;
      screens = [ ];
      fps = 60;
      environment = [ ];
    };

  screenArgs = lib.concatMap (s: [
    "--scaling"
    s.scaling
    "--screen-root"
    s.output
    "--bg"
    s.id
  ]) cfg.screens;

  execStart = lib.escapeShellArgs (
    [
      "${pkgs.linux-wallpaperengine}/bin/linux-wallpaperengine"
      "--silent"
      "--fps"
      (toString cfg.fps)
    ]
    ++ screenArgs
  );
in
{
  systemd.user.services.wallpaperengine = lib.mkIf (cfg.enable && cfg.screens != [ ]) {
    Unit = {
      Description = "Wallpaper Engine";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = execStart;
      Restart = "on-failure";
      RestartSec = 5;

      Environment = cfg.environment;

      TimeoutStopSec = "2s";
      KillSignal = "SIGKILL";
    };

    Install.WantedBy = [ "graphical-session.target" ];
  };
}