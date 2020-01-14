#!/bin/bash

grafanaip=`echo $1`
grafanaport=`echo $2`
influxdbip=`echo $3`
influxdbport=`echo $4`

#create your datasource
curl --user admin:admin 'http://'''$grafanaip''':'''$grafanaport'''/api/datasources' -X  POST -H 'Content-Type: application/json;charset=UTF-8' --data-binary '{"name":"InfluxDB","type":"influxdb","url":"http://'''${influxdbip}''':'''${influxdbport}'''","access":"proxy","database":"telegraf","isDefault":true,"basicAuth":false}'

#create API key
apikey=`curl -X POST -H "Content-Type: application/json" -d '{"name":"apikeycurl", "role": "Admin"}' http://admin:admin@''$grafanaip'':''$grafanaport''/api/auth/keys | jq .key | tr -d '"'`

# import contents
for i in `ls *.json`;
do
#echo ${i}
    curl -X POST http://''$grafanaip'':''$grafanaport''/api/dashboards/db --insecure -H "Authorization: Bearer ${apikey}" -H "Content-Type:application/json" -d @$i;
done
