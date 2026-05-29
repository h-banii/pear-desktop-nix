{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    {
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
      homeManagerModules.default = ./nix/hm-module;

      # TODO: Move this to vue-nix-manual
      lib = {
        mkOptionsDoc =
          { module }: pkgsFor.x86_64-linux.callPackage ./nix/packages/options-doc.nix { inherit module; };
      };

      formatter = forAllSystems (system: pkgsFor.${system}.nixfmt-tree);
    };
}
