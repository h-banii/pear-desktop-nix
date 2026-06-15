{ lib, ... }:
let
  inherit (lib) mkEnableOption mkOption types;
in
{
  enable = mkEnableOption "Synced Lyrics plugin";
  preciseTiming = mkOption {
    default = true;
  };
  showLyricsEvenIfInexact = mkOption {
    default = true;
  };
  showTimeCodes = mkOption {
    default = false;
  };
  defaultTextString = mkOption {
    default = "♪";
  };
  lineEffect = mkOption {
    default = "fancy";
    type = types.enum [
      "fancy"
      "scale"
      "offset"
      "focus"
    ];
  };
  romanization = mkEnableOption "romanized lyrics" // {
    default = true;
  };
}
