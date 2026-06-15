{ lib, ... }:
let
  inherit (lib) mkEnableOption mkOption types;
in
{
  enable = mkEnableOption "Notifications plugin";
  unpauseNotification = mkOption {
    default = false;
  };
  urgency = mkOption {
    default = "normal";
    description = "Only has effect on Linux";
    type = types.enum [
      "low"
      "normal"
      "critical"
    ];
  };
  interactive = mkOption {
    default = true;
    description = "Only has effect on Windows";
  };
  toastStyle = mkOption {
    default = 1;
    type = types.enum [
      1
      2
      3
      4
      5
      6
      7
    ];
    description = ''
      1: logo
      2: banner_centered_top
      3: hero
      4: banner_top_custom
      5: banner_centered_bottom
      6: banner_bottom
      7: legacy
    '';
  };
  refreshOnPlayPause = mkOption {
    default = false;
  };
  trayControls = mkOption {
    default = true;
  };
  hideButtonText = mkOption {
    default = false;
  };
}
