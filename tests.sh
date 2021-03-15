#!/usr/bin/env sh

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
#set -euxo pipefail


IMAGE='localhost/fhs-oci-image:0.0.1'

echo 'Line :' $LINENO
podman \
run \
--interactive=true \
--rm=true \
--tty=true \
"$IMAGE" \
bash-fhs \
-c 'id'

echo 'Line :' $LINENO
podman \
run \
--interactive=true \
--rm=true \
--tty=false \
"$IMAGE" \
bash-fhs \
<< COMMAND
hello
COMMAND


echo 'Line :' $LINENO
podman \
run \
--interactive=true \
--rm=true \
--tty=false \
"$IMAGE" \
bash-fhs \
<< COMMAND
tests
COMMAND


#echo 'Line :' $LINENO
#
#podman \
#run \
#--interactive=true \
#--rm=true \
#--tty=true \
#"$IMAGE" \
#bash -c 'export PATH=$(echo /nix/store/*-fhs-env-fhs)/bin:$PATH && dpkg --version'
#
#echo 'Line :' $LINENO
#
#podman \
#run \
#--interactive=true \
#--rm=true \
#--tty=true \
#"$IMAGE" \
#bash -c 'export PATH=$(echo /nix/store/*-bash-env-fhs)/bin:$PATH && python --version'
#
#echo 'Line :' $LINENO
#
#podman \
#run \
#--interactive=true \
#--rm=true \
#--tty=true \
#"$IMAGE" \
#bash -c 'export PATH=$(echo /nix/store/*-bash-env-fhs)/bin:$PATH && julia --version'
#
#echo 'Line :' $LINENO
#
#podman \
#run \
#--interactive=true \
#--rm=true \
#--tty=true \
#"$IMAGE" \
#bash -c 'export PATH=$(echo /nix/store/*-bash-env-fhs/bin) && hello && python --version && julia --version'
#
#
## Broken! Why??
##podman \
##run \
##--interactive=true \
##--rm=true \
##--tty=false \
##"$IMAGE" \
##<< COMMAND
##ls -al
##export PATH=$(echo /nix/store/*-bash-env-fhs)/bin:$PATH
##hello
##COMMAND
#
#echo 'Line :' $LINENO
#
#podman \
#run \
#--interactive=true \
#--rm=true \
#--tty=true \
#"$IMAGE" \
#bash -c './nix/store/*-bash-env-fhs/bin/hello'
#
#echo 'Line :' $LINENO
#
#podman \
#run \
#--interactive=true \
#--rm=true \
#--tty=true \
#"$IMAGE" \
#bash -c 'ls -al $(echo /nix/store/*-bash-env-fhs/bin)'
#
##podman \
##run \
##--interactive=true \
##--rm=true \
##--tty=true \
##docker.io/library/debian:bullseye-20210208-slim \
##bash -c 'apt update && apt install -y wget && wget http://archive.ubuntu.com/ubuntu/pool/main/h/hello/hello_2.10-1_amd64.deb && dpkg --install hello_2.10-1_amd64.deb && hello'
#
#
#echo 'Line :' $LINENO
#podman \
#run \
#--interactive=true \
#--rm=true \
#--tty=true \
#"$IMAGE" \
#bash -c 'export PATH=$(echo /nix/store/*-bash-env-fhs/bin) && dpkg --help'
#
## Broken!
##echo 'Line :' $LINENO
##podman \
##run \
##--interactive=true \
##--rm=true \
##--tty=false \
##"$IMAGE" \
##bash \
##<< COMMAND
##export PATH=$(echo /nix/store/*-bash-env-fhs/bin)
##dpkg --help
##COMMAND
#
#echo 'Line :' $LINENO
#podman \
#run \
#--interactive=true \
#--rm=true \
#--tty=false \
#"$IMAGE" \
#bash \
#<< COMMAND
#entrypoin-file.sh
#COMMAND
