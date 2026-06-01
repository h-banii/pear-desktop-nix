{
  mkShell,
  nodejs,
  ...
}:
mkShell {
  name = "pear-desktop-nix-docs-dev";
  packages = [
    nodejs
  ];
}
