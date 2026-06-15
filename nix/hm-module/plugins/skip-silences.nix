{ lib, ... }:
let
  inherit (lib) mkEnableOption mkOption;
in
{
  enable = mkEnableOption "Skip Silences plugin";
  onlySkipBeginning = mkOption {
    default = false;
  };
}
