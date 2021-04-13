#!/bin/sh

# Login an obtain authorization token
LOGIN_RESPONSE=`curl -s -H "Content-Type: application/json-rpc" -X POST http://127.0.0.1/api_jsonrpc.php -d '
{
   "jsonrpc" : "2.0",
   "method": "user.login",
   "params" : {
       "user" : "Admin",
       "password" : "zabbix"
   },
   "id": 1
}'
`

# Parse response and extract token from it.
AUTH_TOKEN=`echo $LOGIN_RESPONSE | cut -d"," -f2 | cut -d":" -f2 | sed 's/\"//g'`

# Make request body for updating interface 1.
generate_data() {
cat <<EOF
{
    "jsonrpc": "2.0",
    "method": "hostinterface.update",
    "params": {
        "interfaceid": "1",
        "dns": "zabbix-agent",
        "useip": 0,
        "ip": ""
    },
    "auth": "$AUTH_TOKEN",
    "id": 1
}
EOF
}

# Update interface 1 in order to we can communicate with zabbix agenti container.
curl -H "Content-Type: application/json-rpc" -X POST -d "$(generate_data)" http://127.0.0.1/api_jsonrpc.php



# Obtain container id of the zabbix server in order to we can reload its configuraion
# After updating the interface 1.
CONTAINER_ID=`docker ps -q --filter="name=zabbix-server"`
docker exec -ti ${CONTAINER_ID} zabbix_server -R config_cache_reload
