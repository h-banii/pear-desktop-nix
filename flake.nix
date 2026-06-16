{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    {
      self,
      nixpkgs,
      ...
    }:
    let
      inherit (nixpkgs) lib;
      forAllSystems = lib.genAttrs [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      pkgsFor = forAllSystems (system: nixpkgs.legacyPackages.${system});
    in
    {
      homeManagerModules.default = import ./nix/hm-module { pearLib = self.lib; };

      lib = import ./nix/lib { inherit lib; };

      legacyPackages = forAllSystems (
        system:
        let
          pkgs = pkgsFor.${system};
        in
        rec {
          eval = pkgs.callPackage ./nix/legacyPackages/eval.nix { module = self.homeManagerModules.default; };
          nixosOptionsDoc = pkgs.callPackage ./nix/legacyPackages/nixosOptionsDoc.nix { inherit eval; };
        }
      );

      checks = forAllSystems (
        system:
        let
          inherit (self.legacyPackages.${system}) nixosOptionsDoc;
        in
        {
          optionsJSON = nixosOptionsDoc.optionsJSON.overrideAttrs {
            allowSubstitutes = false;
            preferLocalBuild = true;
          };
        }
      );

      formatter = forAllSystems (system: pkgsFor.${system}.nixfmt-tree);
    };
}
