{ lib, ... }:
let
  inherit (lib) mkEnableOption mkOption;
in
{
  enable = mkEnableOption "In-App Menu plugin";
  hideDOMWindowControls = mkOption { default = false; };
}
