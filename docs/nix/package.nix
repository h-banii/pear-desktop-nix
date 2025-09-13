{
  lib,
  buildNpmPackage,
  nix-gitignore,
  importNpmLock,
  vue-nix-manual,
  ...
}:
buildNpmPackage {
  pname = "youtube-music-nix-docs";
  version = "1.0.0";

  # TODO: Figure out a better fix
  preBuild = ''
    rm ./node_modules/vue-nix-manual
    cp -r "${vue-nix-manual}/lib/node_modules/vue-nix-manual" ./node_modules/vue-nix-manual
  '';

  src = nix-gitignore.gitignoreSourcePure [
    ../.gitignore
    "result\n"
    "README.md\n"
    "flake.*\n"
    "nix\n"
  ] (lib.cleanSource ../.);

  buildPhase = ''
    runHook preBuild

    # https://discourse.nixosstag.fcio.net/t/nix-build-of-vuepress-project-is-slow-or-hangs/56521/1
    npm run build >$TEMP/npm-logs 2>&1

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall
    mv ./.vitepress/dist $out
    runHook postInstall
  '';

  npmDeps = importNpmLock {
    npmRoot = ../.;
    packageSourceOverrides = {
      "node_modules/vue-nix-manual" = "${vue-nix-manual}/lib/node_modules/vue-nix-manual";
    };
  };

  npmConfigHook = importNpmLock.npmConfigHook;

  allowSubstitutes = false;
  preferLocalBuild = true;
}
