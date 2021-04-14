### Monitoring Mysql Container with Zabbix

This repository launches a Zabix monitoring application using Docker Compose. 

There are four services in the Docker Compose file:
- Zabbix server
- Mysql server
- Nginx
- Zabbix agent


We also want to monitor the database. But how can we achieve this?  The database container is completely separate from the zabbix agent container. In fact, whenever we want to monitor something, we have to install a zabbix agent on it. This means that we must have an image that contains both the database service and the zabbix agent service, which is incompatible with the spirit of the microservice architecture.

So what to do? UserParameters solves the problem in zabbix agent. How? 


![alt text](https://github.com/imikiani/monitoring-mysql-container-with-zabbix/blob/main/roles/app/files/app/schema.jpeg?raw=true)
