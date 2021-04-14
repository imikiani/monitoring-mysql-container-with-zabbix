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

As you can see in the figure, we developed the zabbix agent container and installed a tool on it (neither a service nor a process). This tool is a simple and compact Myql Client. The docker file for this dedicated container is placed in the`docker-images` directory and also in the docker hub to be puuled from the docker hub when deploying Docker Compos services.

Meanwhile, in the zabbix agent configuration, we created some User Parameters so that mysqladmin would call from the Mysql Client package and read the parameters from the database container to us. When these parameters are read, for example, once every minute, the zabbix agent picks them up and sends them to the zabbix server.
