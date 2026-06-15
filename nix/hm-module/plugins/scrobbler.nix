{ lib, ... }:
let
  inherit (lib) mkEnableOption mkOption types;
in
{
  enable = mkEnableOption "Scrobbler plugin";
  scrobbleOtherMedia = mkEnableOption "" // {
    description = "Attempt to scrobble other video types (e.g. Podcasts, normal videos)";
    default = true;
  };
  alternativeTitles = mkEnableOption "" // {
    description = ''
      Use alternative titles for scrobbling (Useful for non-roman song titles, e.g. (Not) A Devil -> デビルじゃないもん)
    '';
    default = true;
  };
  alternativeArtist = mkEnableOption "" // {
    description = ''
      Use alternative artist for scrobbling (e.g., DECO27 & (or) PinocchioP -> DECO27 / marasy -> まらしぃ)
    '';
    default = true;
  };
  scrobblers = {
    lastfm = {
      enable = mkEnableOption "Last.fm scrobbling";
      token = mkOption {
        description = "Token used for authentication";
        default = null;
        type = types.nullOr types.str;
      };
      sessionKey = mkOption {
        description = "Session key used for scrobbling";
        default = null;
        type = types.nullOr types.str;
      };
      apiRoot = mkOption {
        description = "Root of the Last.fm API";
        default = "http =//ws.audioscrobbler.com/2.0/";
        type = types.str;
      };
      apiKey = mkOption {
        description = "Last.fm api key registered by @semvis123";
        default = "04d76faaac8726e60988e14c105d421a";
        type = types.str;
      };
      secret = mkOption {
        description = "Last.fm api secret registered by @semvis123";
        default = "a5d2a36fdf64819290f6982481eaffa2";
        type = types.str;
      };
    };
    listenbrainz = {
      enable = mkEnableOption "ListenBrainz scrobbling";
      token = mkOption {
        description = "ListenBrainz API key";
        default = null;
        type = types.nullOr types.str;
      };
      apiRoot = mkOption {
        description = "Root of the ListenBrainz API";
        default = "https =//api.listenbrainz.org/1/";
        type = types.str;
      };
    };
  };
}
