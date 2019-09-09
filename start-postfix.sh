#!/usr/bin/env bash

# Copy default config to config dir
if [ ! "$(ls -A $POSTFIX_CONF_DIR)" ]; then
    cp -r /etc/postfix/* $POSTFIX_CONF_DIR
    find $POSTFIX_CONF_DIR -type f -exec sed -i 's/\/etc\/postfix/\/usr\/local\/etc\/postfix/g' {} \;
fi

# Set configuration from env vars
while read -r conf; do
    postconf -c $POSTFIX_CONF_DIR "${conf:9}"
done <<< `env|grep POSTCONF_`

# Start postfix
postfix -c $POSTFIX_CONF_DIR start-fg
