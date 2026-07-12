{ lib, ... }:
let
  inherit (lib) mkOption mkEnableOption types;
in
{
  enable = mkEnableOption "API Server plugin";
  hostname = mkOption {
    default = "0.0.0.0";
    type = types.str;
    description = "API server host";
  };
  port = mkOption {
    default = 26538;
    type = types.port;
    description = "API server port";
  };
  authStrategy = mkOption {
    type = types.enum [
      "AUTH_AT_FIRST"
      "NONE"
    ];
    default = "AUTH_AT_FIRST";
    description = "API server authentication";
  };
  secret = mkOption {
    default = "";
    type = types.str;
    internal = true;
  };
  authorizedClients = mkOption {
    default = [ ];
    type = types.listOf types.str;
    internal = true;
  };
  useHttps = mkEnableOption "HTTPS support";
  certPath = mkOption {
    description = "string path to HTTPS certificate";
    type = types.str;
    default = "";
  };
  keyPath = mkOption {
    description = "path to HTTPS key";
    type = types.str;
    default = "";
  };
}
