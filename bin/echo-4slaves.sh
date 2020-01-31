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
{
    while IFS= read -r line; do
        [ "$line" == '[slaves]' ] && break
    done
    #shellcheck disable=SC2034
    for i in $(seq 1 4); do
        IFS=' ' read machine assignments
        [ "$privileged" == 'no' ] && { echo $machine demo; continue; }
        username=root
        for assignment in $assignments; do
          variable=${assignment%%=*}
          setting=${assignment#*=}
          [ "$variable" == 'ansible_user' ] && username="$setting"
        done
        echo $machine $username
    done
} < "$hostpath/hosts"
