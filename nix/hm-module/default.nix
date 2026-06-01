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
  inherit (lib.attrsets) mapAttrs' mapAttrsRecursiveCond nameValuePair;

  mapAttrsRecursive' =
    f: set:
    let
      recurse =
        path:
        mapAttrs' (
          name: value:
          if builtins.isAttrs value then
            nameValuePair name (recurse (path ++ [ name ]) value)
          else
            f (path ++ [ name ]) value
        );
    in
    recurse [ ] set;

  toPearDesktopJSON =
    opts: cfg:
    let
      # This is done to avoid "obsolete option" warnings:
      # - first check if the option is defined
      # - then we get the corresponding configuration value
      definedOptions = filterAttrsRecursive (n: v: !lib.isOption v || v.isDefined or false) opts;
      definedConfig = mapAttrsRecursiveCond (as: !(lib.isOption as)) (
        path: value: lib.getAttrFromPath path cfg
      ) definedOptions;
    in
    builtins.toJSON (
      mapAttrsRecursive' (
        path: value:
        let
          name = lib.lists.last path;
          renamedKeys = {
            enable = "enabled";
          };
        in
        nameValuePair (renamedKeys.${name} or name) value
      ) (filterAttrsRecursive (n: v: v != null) definedConfig)
    );

  inherit (lib.attrsets) filterAttrsRecursive;
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

    url = mkOption { default = "https://music.youtube.com"; };

    version = mkOption {
      description = "Version used in migrations";
      default = "3.11.0";
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
