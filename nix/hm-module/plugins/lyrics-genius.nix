{ lib }:
let
  inherit (lib) mkEnableOption mkOption;
in
{
  enable = mkEnableOption "Lyrics Genius plugin";
  romanizedLyrics = mkOption { default = false; };
}
