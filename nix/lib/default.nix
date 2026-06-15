{ lib }:
let
  inherit (lib.attrsets)
    mapAttrs'
    mapAttrsRecursiveCond
    nameValuePair
    filterAttrsRecursive
    ;
in
rec {
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
      # - first check if the option is defined (or if it's not even an option)
      # - then we get the corresponding configuration value
      definedOptions = filterAttrsRecursive (
        n: v: (!lib.isOption v) && n != "_module" || (v.isDefined or false)
      ) opts;
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
}
