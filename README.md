## Monitoring Mysql Container with Zabbix

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


### Up and running zabbix monitoring:

You just need to have vagrant and ansible. But if you have Docker and Docker Compose installed on your system, you can clone the project and go to the directory.
`roles/app/files/app/` and run Docker Compose from there.

But the method that is suggested and we will explain it here is that after you clone the project, only run `vagrant up`. 



After running `vagrant up`, a virtual machine with IP `192.168.40.100` will be created and Docker and Docker Compos will be installed on it and finally Zabbix application will be deployed on it. Wait a while for these steps to be done. After that, you have access to the Zabbix monitoring tool and you can log in to it. The process of importing data into the database may take some time, waiting for the database to be fully configured. After that, you have access to Zabbix through the mentioned IP and you can log in with the default username and password:

User name: `Admin`

Password : `zabbix`


### Update zabbix agent interface
After the Zabbix is fully installed and you can log in, you need to update the interface for zabbix agent so that zabbix server can communicate with zabbix agent. To do this, just run the script `update-interface.sh`.

Log in to your car for this purpose:
`vagrant ssh node1`

Then go to the `/home/vagrant` directory of your machine and run the script.

```
sudo su

cd /home/vagrant

./update-interface.sh
```
