FROM debian:buster-slim

ENV POSTFIX_HOSTNAME localhost
ENV POSTFIX_DOMAIN localhost
ENV POSTFIX_CONF_DIR /usr/local/etc/postfix

# Postfix default configuration
#
# Any env var starting with POSTCONF_
# will be added to postconf
ENV POSTCONF_maillog_file /dev/stdout
ENV POSTCONF_myhostname $POSTFIX_HOSTNAME
ENV POSTCONF_mydomain $POSTFIX_DOMAIN
ENV POSTCONF_myorigin $POSTFIX_DOMAIN
ENV POSTCONF_mynetworks 127.0.0.0/8 [::ffff:127.0.0.0]/104 [::1]/128
ENV POSTCONF_smtpd_use_tls yes
ENV POSTCONF_smtpd_tls_auth_only yes
ENV POSTCONF_smtp_tls_security_level may
ENV POSTCONF_smtpd_tls_security_level may
ENV POSTCONF_smtpd_sasl_security_options noanonymous,noplaintext
ENV POSTCONF_smtpd_sasl_tls_security_options noanonymous

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends postfix

VOLUME $POSTFIX_CONF_DIR

COPY start-postfix.sh /usr/local/bin
RUN chmod +x /usr/local/bin/start-postfix.sh
CMD /usr/local/bin/start-postfix.sh
