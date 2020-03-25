#!/usr/bin/env bash

if [ "$(getopt -T)" == " --" ]; then
  echo "Not using the appropriate getopt.  Please obtain 'GNU getout'"; exit 255
fi
eval set -- "$(getopt -op --longoptions privileged: -n 'getopt' -- "$@")"

privileged=no
while true; do
  case "$1" in
    -p | --privileged) privileged=yes; shift;;
    -- ) shift; break;;
    * ) break;;
  esac
done

hostpath="$(dirname "$(realpath $0)")/../ansible"
#shellcheck disable=SC2034
yq -r '
    .slaves.hosts | to_entries | .[] |
    [ .key, .value?.ansible_user // "root" ] | join(" ")
  ' "$hostpath/hosts.yml" | \
for i in $(seq 1 4); do
    IFS=' ' read machine privileged_user
    [ "$privileged" == 'no' ] && { echo $machine demo; continue; }
    # username=root
    echo $machine $privileged_user
done
