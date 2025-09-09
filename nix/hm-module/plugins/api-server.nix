{ lib }:
let
  inherit (lib) mkOption mkEnableOption types;
in
{
  enable = mkEnableOption "API Server plugin";
  hostname = mkOption { default = "0.0.0.0"; };
  port = mkOption {
    default = 26538;
    type = types.port;
  };
  authStrategy = mkOption {
    type = types.enum [
      "AUTH_AT_FIRST"
      "NONE"
    ];
    default = "AUTH_AT_FIRST";
  };
  secret = mkOption { default = ""; };
  authorizedClients = mkOption {
    default = [ ];
    type = types.listOf types.str;
  };
}
