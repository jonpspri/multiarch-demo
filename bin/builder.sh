#!/usr/bin/env bash

set -euo pipefail

if [ "$(getopt -T)" == " --" ]; then
  echo "Not using the appropriate getopt.  Please obtain 'GNU getout'"; exit 255
fi
eval set -- "$(getopt -ob: --longoptions builder: -n 'getopt' -- "$@")"

builder_provided=no

while true; do
  case "$1" in
    -b | --builder) builder_provided=yes; buildx_name=$2; shift; shift;;
    -- ) shift; break;;
    * ) break;;
  esac
done

if [ "$builder_provided" = "no" ]; then
  buildx_name="builder_$$"
  {
    read context
    docker buildx create --use --name "${buildx_name}" "${context}"
    while read context; do
      docker buildx create --append --name "${buildx_name}" "${context}"
    done
  } <<< "$(yq -r '.docker_tls.hosts | keys | .[] | ./"." | first ' \
    "$(dirname "$(realpath $0)")/../ansible/hosts.yml")"
fi

echo "Building on ${buildx_name}..."
docker buildx build \
  --platform linux/amd64,linux/arm64,linux/s390x,linux/ppc64le \
  "$@"

if [ "$builder_provided" = "no" ]; then
  echo "... removing ${buildx_name}"
  docker buildx rm "${buildx_name}"
fi
