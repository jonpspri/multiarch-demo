#!/bin/sh

#
#  This file is set up for the demo environment originally shown at IBM's
#  Fast Start 2020 conference.  Unless you're in magical posession of the
#  SSH login keys, it WILL NOT work for you without modification.
#
#  However, if you've never encountered the magic of tmux, it's worth further exploration.
#

tmux new-session ssh -i ~/.ssh/openwhisk-key.pem demo@x86-64.multiarch-demo.com \; \
 split-window -h ssh -i ~/.ssh/openwhisk-key.pem demo@ppc64le.multiarch-demo.com \; \
 split-window -t "%0" -v ssh -i ~/.ssh/openwhisk-key.pem demo@s390x.multiarch-demo.com \; \
 split-window -t "%1" -v ssh -i ~/.ssh/openwhisk-key.pem demo@aarch64-big.multiarch-demo.com \; \
 setw synchronize-panes on \;
