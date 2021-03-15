#!/usr/bin/env sh

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail


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


# Broken!
#echo 'Line :' $LINENO
#podman \
#run \
#--interactive=true \
#--rm=true \
#--tty=false \
#"$IMAGE" \
#bash-fhs \
#<< COMMAND
#wget http://archive.ubuntu.com/ubuntu/pool/main/h/hello/hello_2.10-1_amd64.deb
#dpkg --install hello_2.10-1_amd64.deb
#hello
#COMMAND


#echo 'Line :' $LINENO
#podman \
#run \
#--interactive=true \
#--rm=true \
#--tty=false \
#docker.io/library/debian:bullseye-20210208-slim \
#bash \
#<< COMMAND
#apt update
#apt install -y wget
#wget http://archive.ubuntu.com/ubuntu/pool/main/h/hello/hello_2.10-1_amd64.deb
#dpkg --install hello_2.10-1_amd64.deb
#hello
#COMMAND
