#!/usr/bin/env sh

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
#set -euxo pipefail


nix build .#OCIImageFHS

podman load < result

podman \
run \
--interactive=true \
--tty=true \
localhost/bash-fhs:0.0.1 \
bash -c './nix/store/*-bash-env-fhs/bin/hello'

