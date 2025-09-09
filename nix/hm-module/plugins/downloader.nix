{ lib }:
let
  inherit (lib) mkOption mkEnableOption types;
in
{
  enable = mkEnableOption "Downloader plugin";
  downloadFolder = mkOption {
    default = null;
    type = types.nullOr types.str;
  };
  downloadOnFinish = {
    enable = mkOption { default = false; };
    seconds = mkOption { default = 20; };
    percent = mkOption { default = 10; };
    mode = mkOption {
      type = types.enum [
        "percent"
        "seconds"
      ];
      default = "seconds";
    };
    folder = mkOption {
      default = null;
      type = types.nullOr types.str;
    };
  };
  selectedPreset = mkOption {
    default = "mp3 (256kbps)";
    type = types.enum [
      "mp3 (256kbps)"
      "Custom"
      "Source"
    ];
  };
  customPresetSetting = {
    extension = mkOption {
      default = "mp3";
      type = types.nullOr types.str;
    };
    ffmpegArgs = mkOption {
      default = [
        "-b:a"
        "256k"
      ];
      type = types.listOf types.str;
    };
  };
  skipExisting = mkOption { default = false; };
  playlistMaxItems = mkOption {
    default = null;
    type = types.nullOr types.float;
  };
}
