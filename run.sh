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

podman \
run \
--interactive=true \
--tty=true \
localhost/bash-fhs:0.0.1 \
bash -c '/nix/store/*-bash-env/bin/bash-env'

podman \
run \
--interactive=true \
--tty=true \
localhost/bash-fhs:0.0.1 \
bash -c 'hello'


echo '-------------------------'
podman \
run \
--interactive=true \
--tty=true \
localhost/bash-fhs:0.0.1 \
bash -c 'export PATH=$(echo /nix/store/*-bash-env-fhs/bin):$PATH && ldd $(which hello) && python --version && julia --version'

podman \
run \
--interactive=true \
--tty=true \
localhost/bash-fhs:0.0.1 \
bash -c 'echo /nix/store/*-bash-env-fhs/bin'


podman \
run \
--interactive=true \
--tty=true \
localhost/bash-fhs:0.0.1 \
bash -c 'wget http://archive.ubuntu.com/ubuntu/pool/main/h/hello/hello_2.10-1_amd64.deb && dpkg --install hello_2.10-1_amd64.deb'


podman \
run \
--interactive=true \
--tty=true \
docker.io/library/debian:bullseye-20210208-slim \
bash -c 'apt update && apt install -y wget && wget http://archive.ubuntu.com/ubuntu/pool/main/h/hello/hello_2.10-1_amd64.deb && dpkg --install hello_2.10-1_amd64.deb && hello'

