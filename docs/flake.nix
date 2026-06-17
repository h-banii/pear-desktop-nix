{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    vue-nix-docs = {
      url = "github:h-banii/vue-nix-docs";
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
      vue-nix-docs,
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
          vue-nix-docs = vue-nix-docs.packages.${system}.default;
          home-manager-options = self.legacyPackages.${system}.home-manager-options.optionsJSON;
        };
      });

      legacyPackages = forAllSystems (system: {
        home-manager-options = vue-nix-docs.lib.${system}.mkOptionsDoc {
          module = hm-module.homeManagerModules.default;
        };
      });

      devShells = forAllSystems (system: {
        default = pkgsFor.${system}.callPackage ./nix/shell.nix { };
      });
    };
}
