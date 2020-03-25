#!/usr/bin/env bash

set -euo pipefail

buildx_name="builder_$$"

{
  read context
  docker buildx create --use --name "${buildx_name}" "${context}"
  while read context; do
    docker buildx create --append --name "${buildx_name}" "${context}"
  done
} <<< "$(yq -r '.docker_tls.hosts | keys | .[] | ./"." | first ' \
  "$(dirname "$(realpath $0)")/../ansible/hosts.yml")"

docker buildx build \
  --platform linux/x86_64,linux/aarch64,linux/s390x,linux/ppc64le \
  .
