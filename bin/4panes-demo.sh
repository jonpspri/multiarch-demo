#!/bin/bash

#
#  This file is set up for the demo environment originally shown at IBM's
#  Fast Start 2020 conference.  Unless you're in magical posession of the
#  SSH login keys, it WILL NOT work for you without modification.
#
#  However, if you've never encountered the magic of tmux, it's worth further exploration.
#

{
    IFS= read -r machine1
    IFS= read -r machine2
    IFS= read -r machine3
    IFS= read -r machine4
} <<< "$("$(dirname "$0")"/echo-4slaves.sh)"

tmux new-session ssh -i ~/.ssh/openwhisk-key.pem demo@$machine1 \; \
 split-window -h ssh -i ~/.ssh/openwhisk-key.pem demo@$machine2 \; \
 split-window -t "%0" -v ssh -i ~/.ssh/openwhisk-key.pem demo@$machine3 \; \
 split-window -t "%1" -v ssh -i ~/.ssh/openwhisk-key.pem demo@$machine4 \; \
 setw synchronize-panes on \;
