{ pkgs ? import <nixpkgs> { } }:
let
  fhs = pkgs.buildFHSUserEnv {
    name = "fhs-env";
    targetPkgs = pkgs: with pkgs; [
      coreutils
      dpkg
      wget
      which
    ];
    runScript = "bash";
  };
in
pkgs.stdenv.mkDerivation {
  name = "fhs-env-derivation";

  # https://nix.dev/anti-patterns/language.html#reproducability-referencing-top-level-directory-with
  src = builtins.path { path = ./.; };

  nativeBuildInputs = [ fhs ];

  installPhase = ''
    mkdir --parent $out/bin
    cp -r ${fhs}/bin/fhs-env $out/bin/fhs-env
    cp -r /nix/store/*-fhs-env-fhs/ $out/bin/fhs-env-fhs
  '';
}
