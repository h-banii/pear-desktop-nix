{ lib }:
let
  inherit (lib) mkEnableOption mkOption;
in
{
  enable = mkEnableOption "'Disable Autoplay' plugin";
  applyOnce = mkOption { default = false; };
}
