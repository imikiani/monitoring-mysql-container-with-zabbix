FROM zabbix/zabbix-agent:alpine-5.2-latest
COPY scripts /etc/zabbix/scripts
# Change container user temporarily to setup mysql-client package.
USER root
RUN apk add mysql-client \
    && chown -R zabbix:zabbix /etc/zabbix/scripts \
    && chmod u+x,g+x /etc/zabbix/scripts/mysql_check.sh

USER zabbix
