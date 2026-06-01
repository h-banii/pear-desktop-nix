{ lib, ... }:
let
  inherit (lib) mkOption types;
in
{
  options.programs.pear-desktop.options = {
    language = mkOption {
      default = null;
      type = types.enum [
        null
        "ar"
        "bg"
        "ca"
        "cs"
        "de"
        "el"
        "en"
        "es"
        "et"
        "fa"
        "fi"
        "fil"
        "fr"
        "he"
        "hi"
        "hr"
        "hu"
        "id"
        "is"
        "it"
        "ja"
        "ka"
        "ko"
        "lt"
        "ms"
        "nb"
        "ne"
        "nl"
        "pl"
        "pt-BR"
        "pt"
        "ro"
        "ru"
        "si"
        "sl"
        "sv"
        "th"
        "tr"
        "uk"
        "ur"
        "vi"
        "zh-CN"
        "zh-TW"
      ];
    };
    tray = mkOption {
      default = false;
    };
    appVisible = mkOption {
      default = true;
    };
    autoUpdates = mkOption {
      default = true;
    };
    alwaysOnTop = mkOption {
      default = false;
    };
    hideMenu = mkOption {
      default = false;
    };
    hideMenuWarned = mkOption {
      default = false;
    };
    startAtLogin = mkOption {
      default = false;
    };
    disableHardwareAcceleration = mkOption {
      default = false;
    };
    removeUpgradeButton = mkOption {
      default = false;
    };
    restartOnConfigChanges = mkOption {
      default = false;
    };
    trayClickPlayPause = mkOption {
      default = false;
    };
    autoResetAppCache = mkOption {
      default = false;
    };
    resumeOnStart = mkOption {
      default = true;
    };
    likeButtons = mkOption {
      default = "";
      type = types.enum [
        ""
        "force"
        "hide"
      ];
    };
    proxy = mkOption {
      default = "";
    };
    startingPage = mkOption {
      default = "";
      type = types.enum [
        ""
        "Default"
        "Home"
        "Explore"
        "New Releases"
        "Charts"
        "Moods & Genres"
        "Library"
        "Playlists"
        "Songs"
        "Albums"
        "Artists"
        "Subscribed Artists"
        "Uploads"
        "Uploaded Playlists"
        "Uploaded Songs"
        "Uploaded Albums"
        "Uploaded Artists"
      ];
    };
    overrideUserAgent = mkOption {
      default = true;
    };
    usePodcastParticipantAsArtist = mkOption {
      default = true;
    };
    themes = mkOption {
      default = [ ];
      type = types.listOf types.path;
    };
    customWindowTitle = mkOption {
      description = ''
        Set window title to this value instead of dynamically changing it to
        the current song's name.

        See https://github.com/th-ch/pear-desktop/pull/3656
      '';
      default = null;
      type = types.nullOr types.str;
    };
  };
}
