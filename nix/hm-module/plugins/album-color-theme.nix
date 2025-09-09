{ lib }:
let
  inherit (lib) mkEnableOption mkOption;
in
{
  enable = mkEnableOption "Album Color Theme plugin";
  ratio = mkOption { default = 0.5; };
}
