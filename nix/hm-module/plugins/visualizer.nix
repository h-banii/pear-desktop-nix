{ lib }:
let
  inherit (lib) mkEnableOption mkOption types;
in
{
  enable = mkEnableOption "Visualizer plugin";
  type = mkOption {
    default = "butterchurn";
    type = types.enum [
      "butterchurn"
      "vudio"
      "wave"
    ];
  };
  butterchurn = {
    preset = mkOption {
      default = "martin [shadow harlequins shape code] - fata morgana";
    };
    renderingFrequencyInMs = mkOption {
      default = 500;
    };
    blendTimeInSeconds = mkOption {
      default = 2.7;
    };
  };
  vudio = {
    effect = mkOption {
      default = "lighting";
      type = types.enum [
        "waveform"
        "circlewave"
        "circlebar"
        "lighting"
      ];
    };
    accuracy = mkOption {
      default = 128;
    };
    lighting = {
      maxHeight = mkOption {
        default = 160;
      };
      maxSize = mkOption {
        default = 12;
      };
      lineWidth = mkOption {
        default = 1;
      };
      color = mkOption {
        default = "#49f3f7";
      };
      shadowBlur = mkOption {
        default = 2;
      };
      shadowColor = mkOption {
        default = "rgba(244,244,244,.5)";
      };
      fadeSide = mkOption {
        default = true;
      };
      prettify = mkOption {
        default = false;
      };
      horizontalAlign = mkOption {
        default = "center";
        type = types.enum [
          "left"
          "center"
          "right"
        ];
      };
      verticalAlign = mkOption {
        default = "middle";
        type = types.enum [
          "top"
          "middle"
          "bottom"
        ];
      };
      dottify = mkOption {
        default = true;
      };
    };
  };
  wave =
    let
      waveColor =
        with types;
        submodule {
          options = {
            gradient = mkOption {
              default = null;
              type = listOf str;
            };
            rotate = mkOption {
              default = null;
              type = nullOr int;
            };
          };
        };
    in
    {
      animations = mkOption {
        default = [
          {
            type = "Cubes";
            config = {
              bottom = true;
              count = 30;
              cubeHeight = 5;
              fillColor = {
                gradient = [
                  "#FAD961"
                  "#F76B1C"
                ];
              };
              lineColor = "rgba(0;0;0;0)";
              radius = 20;
            };
          }
          {
            type = "Cubes";
            config = {
              top = true;
              count = 12;
              cubeHeight = 5;
              fillColor = {
                gradient = [
                  "#FAD961"
                  "#F76B1C"
                ];
              };
              lineColor = "rgba(0;0;0;0)";
              radius = 10;
            };
          }
          {
            type = "Circles";
            config = {
              lineColor = {
                gradient = [
                  "#FAD961"
                  "#FAD961"
                  "#F76B1C"
                ];
                rotate = 90;
              };
              lineWidth = 4;
              diameter = 20;
              count = 10;
              frequencyBand = "base";
            };
          }
        ];
        type =
          with types;
          listOf (submodule {
            options = {
              type = mkOption { type = str; };
              config = {
                bottom = mkOption {
                  default = null;
                  type = nullOr bool;
                };
                top = mkOption {
                  default = null;
                  type = nullOr bool;
                };
                count = mkOption {
                  default = null;
                  type = nullOr int;
                };
                cubeHeight = mkOption {
                  default = null;
                  type = nullOr int;
                };
                lineWidth = mkOption {
                  default = null;
                  type = nullOr int;
                };
                diameter = mkOption {
                  default = null;
                  type = nullOr int;
                };
                fillColor = mkOption {
                  default = null;
                  type = nullOr (oneOf [
                    str
                    waveColor
                  ]);
                };
                lineColor = mkOption {
                  default = null;
                  type = nullOr (oneOf [
                    str
                    waveColor
                  ]);
                };
                radius = mkOption {
                  default = null;
                  type = nullOr int;
                };
                frequencyBand = mkOption {
                  default = null;
                  type = nullOr str;
                };
              };
            };
          });
      };
    };
}
