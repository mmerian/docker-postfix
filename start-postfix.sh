#!/usr/bin/env bash

# Copy default config to config dir
if [ ! "$(ls -A /etc/postfix)" ]; then
    echo "Initializing postfix configuration"
    cp -r /orig/etc/postfix/* /etc/postfix
fi

if [ ! -z "$PRE_EXEC"  ] && [ -x "$PRE_EXEC" ]; then
    echo "Executing pre-exec $PRE_EXEC"
    $PRE_EXEC
fi

# Start postfix
echo "Starting postfix"
postfix -c /etc/postfix start-fg
