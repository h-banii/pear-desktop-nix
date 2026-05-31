{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    vue-nix-manual = {
      url = "github:h-banii/vue-nix-manual";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hm-module = {
      url = "path:../.";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      systems,
      hm-module,
      vue-nix-manual,
      ...
    }:
    let
      inherit (nixpkgs) lib;
      forAllSystems = lib.genAttrs (import systems);
      pkgsFor = forAllSystems (system: nixpkgs.legacyPackages.${system});
    in
    {
      packages = forAllSystems (system: {
        default = pkgsFor.${system}.callPackage ./nix/package.nix {
          vue-nix-manual = vue-nix-manual.packages.${system}.default;
          home-manager-options = self.legacyPackages.${system}.home-manager-options.optionsJSON;
        };
      });

      legacyPackages = forAllSystems (system: {
        home-manager-options = vue-nix-manual.lib.${system}.mkOptionsDoc {
          module = hm-module.homeManagerModules.default;
        };
      });

      devShells = forAllSystems (system: {
        default = pkgsFor.${system}.callPackage ./nix/shell.nix { };
      });
    };
}
