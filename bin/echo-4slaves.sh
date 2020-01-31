#!/bin/bash

hostpath="$(dirname "$(realpath $0)")/../ansible"
(
    while IFS= read -r line; do
        [ "$line" == '[slaves]' ] && break
    done
    #shellcheck disable=SC2034
    for i in $(seq 1 4); do
        IFS=' ' read machine foo
        echo $machine
    done
) < "$hostpath/hosts"
