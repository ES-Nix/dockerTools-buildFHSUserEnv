



./nix/store/*-bash-env-fhs/bin/bash


docker run -it bash-fhs:latest bash -c './nix/store/*-bash-env-fhs/bin/hello'


https://discourse.nixos.org/t/buildfhsuserenv-package-inside-a-docker-image/8930


exec ${bash-env}/bash-env \ export PATH=$(echo /nix/store/*-bash-env-fhs/bin):$PATH


Maybe:

exec $(echo /nix/store/*-bash-env-fhs/bin/bash)
