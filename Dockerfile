FROM debian:buster-slim

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends ca-certificates postfix && \
    apt-get clean

RUN mkdir -p /orig/etc && \
    cp -r /etc/postfix /orig/etc

VOLUME /etc/postfix

COPY start-postfix.sh /usr/local/bin
RUN chmod +x /usr/local/bin/start-postfix.sh
CMD /usr/local/bin/start-postfix.sh
