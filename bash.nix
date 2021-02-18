{
  pkgs ? import <nixpkgs> {}
}:
let
  bash-env = pkgs.buildFHSUserEnv rec {
    name = "bash-env";

    runScript = "bash";

    targetPkgs = pkgs: (with pkgs; [
      bashInteractive
    ]);
  };
in
  pkgs.dockerTools.buildImage {
    name = "bash-fhs";
    tag = "latest";
    contents = bash-env;

    config = {
      Cmd = [ "/bin/bash-env" ];
      WorkingDir = "/";
    };
  }

