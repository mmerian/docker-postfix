#!/usr/bin/env bash

# Copy default config to config dir
if [ ! "$(ls -A /etc/postfix)" ]; then
    echo "Initializing postfix configuration"
    cp -r /orig/etc/postfix/* /etc/postfix
fi

# Set configuration from env vars
while read -r conf; do
    echo postconf -c /etc/postfix "${conf:9}"
    postconf "${conf:9}"
done <<< `env|grep POSTCONF_`

# Start postfix
postfix -c /etc/postfix start-fg
