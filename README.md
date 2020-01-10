# AMS
System, altibase monitoring

## 1.createDashboard
### a. Redhat
sh influxdbgrafana_redhat.run [--ipgrafana=IP] [--portgrafana=PORT] [--ipinfluxdb=IP] [--portinfluxdb=PORT] [--help]

### b. Ubuntu
sh influxdbgrafana_ubuntu.run [--ipgrafana=IP] [--portgrafana=PORT] [--ipinfluxdb=IP] [--portinfluxdb=PORT] [--help]
```
--ipgrafana=IP        If no --ipgrafana option is given, the default value is 127.0.0.1
--portgrafana=PORT    If no --portgrafana option is given, the default value is 3000
--ipinfluxdb=IP       If no --ipinfluxdb option is given, the default value is 127.0.0.1
--portinfluxdb=PORT   If no --portinfluxdb option is given, the default value is 8086
```

## 2. monitor하고 싶은 장비에서 telegraf 수행 합니다.
telegraf -config telegraf.conf

확인 해야 할 부분이 다음과 같습니다. influxdb uri, altibase uri,port 맞춰서 수정 하면 됩니다.
### a. telegraf.conf
[[outputs.influxdb]] urls = ["http://127.0.0.1:8086"]

hostname = "nval02(receiver)"

[[inputs.altibase]]
altibase_dsn    = "Altiodbc"

altibase_server = "127.0.0.1"

altibase_port   = 43019

altibase_user   = "sys"

altibase_password = "manager"

[[inputs.exec]]
   commands = [
     "/home1/perf/work/ams/telegraf_altibase/checkdir.sh"
    ]  
    
    
### b. test.go
mysrv  = flag.String("mysrv", "127.0.0.1", "altibase server ip")

mydb   = flag.String("mydb", "mydb", "altibase database name")

myuser = flag.String("myuser", "sys", "altibase user name")

mypass = flag.String("mypass", "manager", "altibase password")

myport = flag.String("myport", "43019", "altibase port")

### c. altibase.go
mysrv  = flag.String("mysrv", "127.0.0.1", "altibase server ip")

mydb   = flag.String("mydb", "mydb", "altibase database name")

myuser = flag.String("myuser", "sys", "altibase user name")

mypass = flag.String("mypass", "manager", "altibase password")

myport = flag.String("myport", "43019", "altibase port")

