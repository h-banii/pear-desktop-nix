{ lib }:
let
  inherit (lib) mkOption mkEnableOption types;
in
{
  enable = mkEnableOption "Auth Proxy Adapter plugin";
  hostname = mkOption {
    default = "127.0.0.1";
    type = types.str;
  };
  port = mkOption {
    default = 4545;
    type = types.port;
  };
}
