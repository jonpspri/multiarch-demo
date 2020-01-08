#!/bin/sh

tmux new-session ssh -i ~/.ssh/openwhisk-key.pem demo@x86-64.multiarch-demo.com \; \
 split-window -h ssh -i ~/.ssh/openwhisk-key.pem demo@ppc64le.multiarch-demo.com \; \
 split-window -t "%0" -v ssh -i ~/.ssh/openwhisk-key.pem demo@s390x.multiarch-demo.com \; \
 split-window -t "%1" -v ssh -i ~/.ssh/openwhisk-key.pem demo@aarch64.multiarch-demo.com \; \
 setw synchronize-panes on \;
