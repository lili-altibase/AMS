#!/bin/bash
 
#create your datasource
curl --user admin:admin 'http://$1:$2/api/datasources' -X  POST -H 'Content-Type: application/json;charset=UTF-8' --data-binary '{"name":"InfluxDB","type":"influxdb","url":"http://$3:$4","access":"proxy","database":"telegraf","isDefault":true,"basicAuth":false}'
 
#create API key 
apikey=`curl -X POST -H "Content-Type: application/json" -d '{"name":"apikeycurl", "role": "Admin"}' http://admin:admin@$1:$2/api/auth/keys | jq .key | tr -d '"'`
 
# import contents
for i in `ls *.json`;
do
#echo ${i}
    curl -X POST http://$1:$2/api/dashboards/db --insecure -H "Authorization: Bearer ${apikey}" -H "Content-Type:application/json" -d @$i;
done
