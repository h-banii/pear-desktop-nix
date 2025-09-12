{
  lib,
  buildNpmPackage,
  nix-gitignore,
  importNpmLock,
  ...
}:
buildNpmPackage {
  pname = "youtube-music-nix-docs";
  version = "1.0.0";

  src = nix-gitignore.gitignoreSourcePure [
    ../.gitignore
    "result\n"
    "README.md\n"
    "flake.*\n"
    "nix\n"
  ] (lib.cleanSource ../.);

  buildPhase = ''
    runHook preBuild
    ls -la ./
    npm run build >/dev/null 2>&1
    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall
    mv ./.vitepress/dist $out
    runHook postInstall
  '';

  npmDeps = importNpmLock {
    npmRoot = ../.;
  };

  npmConfigHook = importNpmLock.npmConfigHook;

  allowSubstitutes = false;
  preferLocalBuild = true;
}
