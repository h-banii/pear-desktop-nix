{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    {
      nixpkgs,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      homeManagerModules.default = ./nix/hm-module;

      # TODO: Move this to vue-nix-manual
      lib = {
        mkOptionsDoc = { module }: pkgs.callPackage ./nix/packages/options-doc.nix { inherit module; };
      };

      formatter.${system} = pkgs.nixfmt-tree;
    };
}
