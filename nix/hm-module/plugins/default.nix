{ lib, ... }:
let
  inherit (lib) mkEnableOption mergeAttrs;
  inherit (builtins) listToAttrs map;
in
{
  options.programs.youtube-music.plugins =
    mergeAttrs
      (listToAttrs (
        map
          (plugin: {
            name = plugin;
            value = import ./${plugin}.nix { inherit lib; };
          })
          [
            "adblocker"
            "album-color-theme"
            "ambient-mode"
            "api-server"
            "auth-proxy-adapter"
            "captions-selector"
            "crossfade"
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
            "video-toggle"
            "visualizer"
          ]
      ))
      {
        audio-compressor.enabled = mkEnableOption "Audio Compressor plugin";
        album-actions.enabled = mkEnableOption "Album Actions plugin";
        amuse.enabled = mkEnableOption "Amuse plugin";
        blur-nav-bar.enabled = mkEnableOption "Blur Navigation Bar plugin";
        bypass-age-restrictions.enabled = mkEnableOption "Bypass Age Restrictions plugin";
        compact-sidebar.enabled = mkEnableOption "Compact Sidebar plugin";
        exponential-volume.enabled = mkEnableOption "Exponential Volume plugin";
        lumiastream.enabled = mkEnableOption "Lumia Stream plugin";
        music-together.enabled = mkEnableOption "Music Together plugin";
        navigation.enabled = mkEnableOption "Navigation plugin";
        no-google-login.enabled = mkEnableOption "No Google Login plugin";
        playback-speed.enabled = mkEnableOption "Playback Speed plugin";
        quality-changer.enabled = mkEnableOption "Quality Changer plugin";
        skip-disliked-songs.enabled = mkEnableOption "Skip Disliked Songs plugin";
        taskbar-mediacontrol.enabled = mkEnableOption "Taskbar Media Control plugin (Windows)";
        touchbar.enabled = mkEnableOption "TouchBar plugin";
        tuna-obs.enabled = mkEnableOption "Tuna OBS plugin";
        unobtrusive-player.enabled = mkEnableOption "Unobtrusive Player plugin";
        performance-improvement.enabled = mkEnableOption "Performance Improvement plugin";
      };
}
