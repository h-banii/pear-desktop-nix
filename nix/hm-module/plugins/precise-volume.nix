{ lib }:
let
  inherit (lib) mkEnableOption mkOption types;
in
{
  enable = mkEnableOption "Precise Volume plugin";
  steps = mkOption {
    default = 1;
    description = "Percentage of volume to change";
    type = types.int;
  };
  arrowsShortcut = mkOption {
    default = true;
    description = "ArrowUp + ArrowDown local shortcuts";
  };
  globalShortcuts = {
    volumeUp = mkOption {
      default = "";
    };
    volumeDown = mkOption {
      default = "";
    };
  };
  savedVolume = mkOption {
    default = null;
    description = "Default volume";
    type = types.nullOr types.int;
  };
}
