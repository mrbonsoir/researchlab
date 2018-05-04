#!/bin/bash

# Exit this script if any error is encountered (e) and print every command (x)
set -ex

# Execute inside this script directory
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DIR"

# Name to be used for docker tags, folders and files
name=researchlab

# Build the dockerfile image
docker build . -t "$name"

# If the docker container is already running, ask to stop it
cidfile="/tmp/$name.cid"
if [ -e "$cidfile" ]
then
  cid="$(cat "$cidfile")"
  if docker ps --format='{{.ID}}' --no-trunc | grep -q "$cid"
  then
    read -rp "Container $name is already running. Restart it (potentially loosing work)? [yes/NO] "
    if [[ ! ${REPLY^^} =~ ^(Y|YES)$ ]]
    then
      exit 1
    fi
    docker stop "$cid"
  fi
  rm "$cidfile"
fi

# Run the docker image inside a container and get its Container ID (CID)
docker run --cidfile "$cidfile" -d -v "$DIR:/$name" "$name"

# Inspect the running docker container to open a browser on its current IP
cid="$(cat "$cidfile")"
ipaddr="$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' "$cid")"
xdg-open "http://$ipaddr:8888/"
