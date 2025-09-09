{ lib, ... }:
let
  inherit (lib) mkEnableOption mergeAttrs;
  inherit (builtins) listToAttrs map;

  complexPlugins = [
    "adblocker"
    "album-color-theme"
    "ambient-mode"
    "api-server"
    "auth-proxy-adapter"
    "captions-selector"
    "crossfade"
    "custom-output-device"
    "disable-autoplay"
    "discord"
    "downloader"
    "equalizer"
    "in-app-menu"
    "lyrics-genius"
    "notifications"
    "picture-in-picture"
    "precise-volume"
    "scrobbler"
    "shortcuts"
    "skip-silences"
    "sponsorblock"
    "synced-lyrics"
    "transparent-player"
    "video-toggle"
    "visualizer"
  ];

  simplePlugins = {
    audio-compressor = "Audio Compressor plugin";
    album-actions = "Album Actions plugin";
    amuse = "Amuse plugin";
    blur-nav-bar = "Blur Navigation Bar plugin";
    bypass-age-restrictions = "Bypass Age Restrictions plugin";
    compact-sidebar = "Compact Sidebar plugin";
    exponential-volume = "Exponential Volume plugin";
    lumiastream = "Lumia Stream plugin";
    music-together = "Music Together plugin";
    navigation = "Navigation plugin";
    no-google-login = "No Google Login plugin";
    playback-speed = "Playback Speed plugin";
    quality-changer = "Quality Changer plugin";
    skip-disliked-songs = "Skip Disliked Songs plugin";
    taskbar-mediacontrol = "Taskbar Media Control plugin (Windows)";
    touchbar = "TouchBar plugin";
    tuna-obs = "Tuna OBS plugin";
    unobtrusive-player = "Unobtrusive Player plugin";
    performance-improvement = "Performance Improvement plugin";
  };
in
{
  options.programs.youtube-music.plugins =
    mergeAttrs
      (listToAttrs (
        map (plugin: {
          name = plugin;
          value = import ./${plugin}.nix { inherit lib; };
        }) complexPlugins
      ))
      (
        lib.attrsets.mapAttrs (pluginName: pluginDescription: {
          enabled = mkEnableOption pluginDescription;
        }) simplePlugins
      );
}
