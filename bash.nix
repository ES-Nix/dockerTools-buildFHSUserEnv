{
  pkgs ? import <nixpkgs> {}
}:
let
  bash-env = pkgs.buildFHSUserEnv rec {
    name = "bash-env";

    runScript = "bash";

    targetPkgs = pkgs: (with pkgs; [
      #bashInteractive
      #curl
      coreutils
      #binutils
      dpkg
      #file
      #which
      hello
      python39
      julia
      #ripgrep
      wget
      #nix
      #nixFlakes
    ]);
  };
  
  entrypoint = pkgs.writeScriptBin "entrypoin-file.sh" ''
     #!${pkgs.stdenv.shell}
       echo 'Running entrypoint script!'
       #cat ${bash-env}/bin/bash-env

       echo ${pkgs.bashInteractive}

       export PATH=$(echo /nix/store/*-bash-env-fhs)/bin:$PATH
       #exec "$@"
       #echo /nix/store/*-bash-env-usr-target/bin
  '';
in
  pkgs.dockerTools.buildImage {
    name = "bash-fhs";
    tag = "0.0.1";

    contents = with pkgs; [
                bashInteractive
                bash-env
                entrypoint
                which
                file
		];

    config = {
      Cmd = with pkgs; [ "${bashInteractive}/bin/bash" ];
      #Entrypoint = [ entrypoint ];
      WorkingDir = "/";

      Env = [
            "PATH=/nix/store/ypsd29c5hgj1x7xz5ddffanxw5d8fh7b-coreutils-8.32/bin:${bash-env}/bin:/jane/.nix-profile/bin:/run/current-system/sw/bin:/nix/var/nix/profiles/default/bin:/nix/var/nix/profiles/default/sbin:/bin:/sbin:/usr/bin:/usr/sbin"
            "MANPATH=/jane/.nix-profile/share/man:/home/jane/.nix-profile/share/man:/run/current-system/sw/share/man"
            "NIX_PAGER=cat"
            #"NIX_PATH=nixpkgs=${unstable}"
            "NIX_SSL_CERT_FILE=${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt"
            "ENV=/etc/profile"
        ];
    };
  }
#:/nix/store/m687mc739ghs4igq5wck20yvinlgamqf-bash-env-fhs/bin