{ pkgs, ... }:
{
  systemd.user.services.wallpaperengine = {
    Unit = {
      Description = "Wallpaper Engine";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.linux-wallpaperengine}/bin/linux-wallpaperengine --silent --fps 60 --scaling fill --screen-root DP-2 --bg 3478544779 --scaling fill --screen-root DP-1 --bg 1345100339";
      Restart = "on-failure";
      RestartSec = 5;

      Environment = [ "__GL_THREADED_OPTIMIZATIONS=0" ];
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };
}
