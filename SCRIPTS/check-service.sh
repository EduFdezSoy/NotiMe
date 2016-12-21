#!/bin/bash

#    NotiMe - No time to check that all, please notify me.
#    Copyright (C) 2017  Eduardo Fernandez
#    email: yo (at) edufdezsoy.es
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU Affero General Public License as
#    published by the Free Software Foundation, either version 3 of the
#    License, or (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU Affero General Public License for more details.
#
#    You should have received a copy of the GNU Affero General Public License
#    along with this program.  If not, see <https://www.gnu.org/licenses/agpl>.

## MSQL CONFIG ##
host="example.net"
user="exampleuser"
pass="mypassword"
dbname="notime"

## NOTIME CONFIG ##
service="java -Xmx756M -Xms100M -jar minecraft_server.1.11.jar"
notimeid=8



## SCRIPT - DO NOT TOUCH UNDER HERE ##
temp=time
dothis=$(ps aux | grep -v "grep" | grep -c "$service")
#recordamos que el grep puede aparecer en la lista, asi que lo filtramos

# comprobar los datos
if [$dothis -ge 1]
    ok=1
	# si es igual o mayor a 1 el servicio esta ok
else
    ok=0
    if [$(echo "SELECT ok FROM auto_logs where services_id=$notimeid ORDER BY id DESC LIMIT 1" | mysql database --user=$user --password=$pass)=0]
        ultinc=$(echo "SELECT inc_num FROM incidences ORDER BY id DESC LIMIT 1" | mysql database --user=$user --password=$pass)
        $ultinc=$ultinc+1
        mysql --host=$host --user=$user --password=$pass $dbname << EOF
        insert into incidences (inc_num,service_id,title,description,iopen) values($ultinc, $service, "The service is down!", $temp);
EOF
    fi
fi
# insertar los datos en la tabla 
mysql --host=$host --user=$user --password=$pass $dbname << EOF
insert into auto_logs (services_id,ok,timedate) values($notimeid, $ok, $temp);
EOF