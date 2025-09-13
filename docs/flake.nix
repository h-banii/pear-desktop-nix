{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    vue-nix-manual.url = "github:h-banii/vue-nix-manual";
    hm-module.url = "path:../.";
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
        };
      });

      legacyPackages = forAllSystems (
        system:
        let
          pkgs = pkgsFor.${system};
        in
        {
          homeManagerOptionsDoc = hm-module.lib.mkOptionsDoc {
            module = hm-module.homeManagerModules.default;
          };
          docs =
            let
              homeManagerOptionsJSON = self.legacyPackages.${system}.homeManagerOptionsDoc.optionsJSON;
            in
            pkgs.symlinkJoin {
              name = "youtube-music-nix-docs";
              paths = [
                self.packages.${system}.default
                (pkgs.linkFarm "youtube-music-nix-hm-options" [
                  {
                    name = "pages/home-manager/options.json";
                    path = "${homeManagerOptionsJSON}/share/doc/nixos/options.json";
                  }
                ])
              ];
            };
        }
      );

      devShells = forAllSystems (system: {
        default = pkgsFor.${system}.callPackage ./nix/shell.nix { };
      });
    };
}
