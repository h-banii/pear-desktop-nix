{
  lib,
  pkgs,
  module,
}:
lib.evalModules {
  modules = [
    {
      config = {
        _module.check = false;
      };
    }
    module
  ];

  specialArgs = {
    inherit pkgs;
    lib = lib // {
      # Dummy home-manager lib
      # (to avoid having to add home-manager as an input)
      #
      # OBS.: it's not recommended to overwrite lib:
      # https://nixos.org/manual/nixpkgs/unstable/#module-system-lib-evalModules-param-specialArgs
      #
      # But home-manager does it anyway, so we gotta deal with it.
      hm.dag.entryAfter = a: b: { };
    };
  };
}
