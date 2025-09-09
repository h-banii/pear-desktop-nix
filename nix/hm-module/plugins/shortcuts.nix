{ lib }:
let
  inherit (lib) mkEnableOption mkOption types;
  shortcutMappingType = types.submodule {
    options = {
      previous = mkOption {
        default = "";
      };
      playPause = mkOption {
        default = "";
      };
      next = mkOption {
        default = "";
      };
    };
  };
in
{
  enable = mkEnableOption "Shortcuts plugin";
  overrideMediaKeys = mkOption {
    default = false;
  };
  global = mkOption {
    default = { };
    type = shortcutMappingType;
  };
  local = mkOption {
    default = { };
    type = shortcutMappingType;
  };
}
