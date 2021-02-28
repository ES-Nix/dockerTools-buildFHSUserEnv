{
  pkgs ? import <nixpkgs> {}
}:
let
  bash-env = pkgs.buildFHSUserEnv rec {
    name = "bash-env";

    runScript = "bash";

    targetPkgs = pkgs: (with pkgs; [
      bashInteractive
      hello
      python39
      julia
      nix
      nixFlakes
    ]);
  };
  
  entrypoint = pkgs.writeScriptBin "entrypoin-file.sh" ''
       echo 'Running entrypoint script!'     
    '';
in
  pkgs.dockerTools.buildImage {
    name = "bash-fhs";
    tag = "0.0.1";

    contents = with pkgs; [ 
                bashInteractive 
		coreutils 
		which 
		file 
		bash-env 
		];

    config = {
      Cmd = [ "/bin/bash-env" ];
      #Entrypoint = [ entrypoint ];
      WorkingDir = "/";
      Env = [ 
         "PATH2=${bash-env}/bin:$PATH"
        ];
    };
  }

