
# Testing it

Just run the `run.sh` script:

`/run.sh`



## Old stuff


https://discourse.nixos.org/t/buildfhsuserenv-package-inside-a-docker-image/8930


exec ${bash-env}/bash-env \ export PATH=$(echo /nix/store/*-bash-env-fhs/bin):$PATH

Maybe:

exec $(echo /nix/store/*-bash-env-fhs/bin/bash)

nix build .#OCIImageFHS
podman load < result
podman \
run \
--interactive=true \
--rm=true \
--tty=true \
"$IMAGE" \
bash
