FROM zabbix/zabbix-agent:alpine-5.2-latest
# Change container user temporarily to setup mysql-client package.
USER root
RUN apk add mysql-client
USER zabbix