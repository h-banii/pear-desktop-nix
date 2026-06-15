{ lib, ... }:
let
  inherit (lib) mkOption mkEnableOption types;
in
{
  enable = mkEnableOption "Equalizer plugin";
  filters = mkOption {
    default = [ ];
    type =
      with types;
      listOf (submodule {
        options = {
          type = mkOption {
            description = "BiquadFilterType";
            example = "lowshelf";
            type = str;
          };
          frequency = mkOption {
            type = int;
          };
          Q = mkOption { type = int; };
          gain = mkOption { type = float; };
        };
      });
  };
  presets = {
    bass-booster = mkEnableOption "Equalizer's bass-booster preset";
  };
}
