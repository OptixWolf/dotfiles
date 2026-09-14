{ lib, ... }:
{
  options.local.wallpaper = {
    enable = lib.mkEnableOption "linux-wallpaperengine in der Benutzersitzung";

    screens = lib.mkOption {
      default = [ ];
      description = ''
        Ein Eintrag pro Monitor. Ist die Liste leer, wird der Benutzerdienst
        gar nicht erst erzeugt.
      '';
      example = [
        {
          output = "MON-1";
          id = "1234567890";
        }
      ];
      type = lib.types.listOf (lib.types.submodule {
        options = {
          output = lib.mkOption {
            type = lib.types.str;
            example = "MON-1";
            description = "Name des Ausgangs, so wie ihn der Compositor ausgibt.";
          };

          id = lib.mkOption {
            type = lib.types.str;
            example = "1234567890";
            description = "Workshop-ID des Wallpapers.";
          };

          scaling = lib.mkOption {
            type = lib.types.str;
            default = "fill";
            description = "Skalierungsmodus, wird als --scaling uebergeben.";
          };
        };
      });
    };

    fps = lib.mkOption {
      type = lib.types.ints.positive;
      default = 60;
      description = "Bildrate, wird als --fps uebergeben.";
    };

    environment = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      example = [ "VARIABLE=0" ];
      description = "Umgebungsvariablen, z.B. für Workarounds.";
    };
  };
}