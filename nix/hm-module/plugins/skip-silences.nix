{ lib, ... }:
let
  inherit (lib) mkEnableOption mkOption;
in
{
  enable = mkEnableOption "Skip Silences plugin";
  onlySkipBeginning = mkEnableOption "" // {
    description = "Whether to only skip beginning";
  };
}
