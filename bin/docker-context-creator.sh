#!/usr/bin/env bash

set -euo pipefail

declare -A existing_contexts

existing_contexts="$(docker context ls --quiet)"

while read host; do
  context="${host%%.*}"
  hoststring="host=tcp://${host}:2376"
  hoststring="${hoststring},ca=$HOME/.docker/tls/ca.pem"
  hoststring="${hoststring},cert=$HOME/.docker/tls/cert.pem"
  hoststring="${hoststring},key=$HOME/.docker/tls/key.pem"

  if grep -Fq "$context" <<< "$existing_contexts"; then
    echo "Updating context ${context}: \"${hoststring}\""
    docker context update "${context}" --docker "${hoststring}"
  else
    echo "Creating context ${context}: \"${hoststring}\""
    docker context create "${context}" --docker "${hoststring}"
  fi
done <<< $(yq -r '.docker_tls.hosts | keys | .[]' \
  "$(dirname "$(realpath $0)")/../ansible/hosts.yml")
