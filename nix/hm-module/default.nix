{
  pearLib,
}:
{
  options,
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib)
    mkIf
    mkOption
    mkEnableOption
    mkPackageOption
    mkRenamedOptionModule
    ;
  inherit (pearLib) toPearDesktopJSON;

  cfg = config.programs.pear-desktop;

  generatedConfig =
    let
      opts = options.programs.pear-desktop;
      jsonOptions = toPearDesktopJSON opts.options cfg.options;
      jsonPlugins = toPearDesktopJSON opts.plugins cfg.plugins;
      configText = ''
        "url": "${cfg.url}",
        "options": ${jsonOptions},
        "plugins": ${jsonPlugins},
        "__internal__": {
          "migrations": {
            "version": "${cfg.version}"
          }
        }
      '';
    in
    rec {
      package = pkgs.writeText "pear-desktop-config.json" ''
        {
          ${configText},
          "__nix__": {
            "hash": "${hash}"
          }
        }
      '';
      hash = builtins.hashString "sha256" configText;
    };
in
{
  options.programs.pear-desktop = {
    enable = mkEnableOption "Pear Desktop";

    package = mkPackageOption pkgs "pear-desktop" { };

    url = mkOption {
      default = "https://music.youtube.com";
      description = ''
        Starting page url.

        This is only used if `options.resumeOnStart` is enabled.

        This is set internally by the application.
      '';
      internal = true;
    };

    version = mkOption {
      description = "Version used in migrations";
      default = "3.12.0";
      internal = true;
    };

    # TODO: Check for changes on this option on the next release
    #
    # this is the `productName` in `package.json` (probably)
    configFolderName = mkOption {
      description = "Name of the config folder";
      default = "YouTube Music";
      internal = true;
    };

    configFileName = mkOption {
      description = "Name of the config file";
      default = "config.json";
      internal = true;
    };
  };

  imports = [
    ./options.nix
    ./plugins
    (mkRenamedOptionModule
      [
        "programs"
        "youtube-music"
      ]
      [
        "programs"
        "pear-desktop"
      ]
    )
  ];

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];

    home.activation.updatePearDesktopConfig =
      let
        jq = lib.getExe pkgs.jq;
      in
      lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        outConfig="${config.xdg.configHome}/${cfg.configFolderName}/${cfg.configFileName}"
        homeManagerConfigHash="$(${jq} -r '.__nix__.hash' < "$outConfig")"

        if [[ "$homeManagerConfigHash" != "${generatedConfig.hash}" ]]; then
          cp ${generatedConfig.package} "$outConfig"
          chmod u+w "$outConfig"
        fi
      '';
  };
}
