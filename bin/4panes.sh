#!/bin/bash

#
#  This file is set up for the demo environment originally shown at IBM's
#  Fast Start 2020 conference.  Unless you're in magical posession of the
#  SSH login keys, it WILL NOT work for you without modification.
#
#  However, if you've never encountered the magic of tmux, it's worth further exploration.
#

{
    read -r machine1 user1
    read -r machine2 user2
    read -r machine3 user3
    read -r machine4 user4
} <<< "$("$(dirname "$0")"/echo-4slaves.sh "$@")"

echo machine1 user1
echo machine2 user2
echo machine3 user3
echo machine4 user4

tmux new-session ssh -i ~/.ssh/openwhisk-key.pem $user1@$machine1 \; \
 split-window -h ssh -i ~/.ssh/openwhisk-key.pem $user2@$machine2 \; \
 split-window -t "%0" -v ssh -i ~/.ssh/openwhisk-key.pem $user3@$machine3 \; \
 split-window -t "%1" -v ssh -i ~/.ssh/openwhisk-key.pem $user4@$machine4 \; \
 setw synchronize-panes on \;
