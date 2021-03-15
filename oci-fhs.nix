{ pkgs ? import <nixpkgs> { }
}:
let
  fhs-environment = import ./fhs-environment.nix {
    pkgs = pkgs;
  };

  bash-fhs = pkgs.writeScriptBin "bash-fhs" ''
    #!${pkgs.stdenv.shell}
      echo 'Running entrypoint script!'

      export PATH=$(echo /nix/store/*-fhs-env-fhs)/bin:$PATH
      cd $(echo /nix/store/*-fhs-env-fhs)
      chmod +x /bin/fhs-env-fhs/bin/bash
      exec /bin/fhs-env-fhs/bin/bash "$@"
  '';

  tests = pkgs.writeScriptBin "tests" ''
    cat /nix/store/*-fhs-env-derivation/bin/fhs-env
    ls -al /nix/store/*-fhs-env-fhs/usr/bin | wc

    ls $(pwd) | grep 'bin' || echo 'Error, pwd seems to be wrong' || exit 123
    ls $(pwd) | grep 'etc' || echo 'Error, pwd seems to be wrong' || exit 123
    ls $(pwd) | grep 'lib' || echo 'Error, pwd seems to be wrong' || exit 123
    ls $(pwd) | grep 'lib32' || echo 'Error, pwd seems to be wrong' || exit 123
    ls $(pwd) | grep 'lib64' || echo 'Error, pwd seems to be wrong' || exit 123
    ls $(pwd) | grep 'sbin' || echo 'Error, pwd seems to be wrong' || exit 123
    ls $(pwd) | grep 'usr' || echo 'Error, pwd seems to be wrong' || exit 123

    dpkg --version
  '';


in
pkgs.dockerTools.buildImage {
  name = "fhs-oci-image";
  tag = "0.0.1";

  contents = with pkgs; [
    bash-fhs
    fhs-environment
    tests
  ];

  config = {
    Cmd = with pkgs; [ bash-fhs ];

    Env = [
      "PATH=${bash-fhs}:${fhs-environment}/bin/fhs-env:/run/current-system/sw/bin:/nix/var/nix/profiles/default/bin:/nix/var/nix/profiles/default/sbin:/bin:/sbin:/usr/bin:/usr/sbin"
      "MANPATH=/run/current-system/sw/share/man"
      "NIX_PAGER=cat"
      #"NIX_PATH=nixpkgs=${unstable}"
      "NIX_SSL_CERT_FILE=${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt"
      "ENV=/etc/profile"
    ];
  };
}
