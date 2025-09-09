{ lib }:
let
  inherit (lib) mkEnableOption mkOption types;
in
{
  enable = mkEnableOption "Picture-in-picture plugin";
  alwaysOnTop = mkOption {
    default = true;
  };
  savePosition = mkOption {
    default = true;
  };
  saveSize = mkOption {
    default = false;
  };
  hotkey = mkOption {
    default = "P";
    type = types.str;
  };
  pip-position =
    with types;
    mkOption {
      default = [
        10
        10
      ];
      description = "[x y]";
      type = listOf int;
    };
  pip-size =
    with types;
    mkOption {
      default = [
        450
        275
      ];
      description = "[width height]";
      type = listOf int;
    };
  isInPiP = mkOption {
    default = false;
  };
  useNativePiP = mkOption {
    default = true;
  };
}
