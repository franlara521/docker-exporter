#! /bin/bash

hostip=$(ip route show | awk '/default/ {print $3}')
echo "$hostip   host.internal" >> /etc/hosts

# Initiate MongoDB exporter
#-mongodb.uri string 
# Mongodb URI, format: [mongodb://][user:pass@]host1[:port1][,host2[:port2],...][/database][?options] (default "mongodb://localhost:27017")

prometheus-mongodb-exporter -mongodb.uri string mongodb://tnjs:password@host.internal:27017/admin &

# Initiate Squid exporter
prometheus-squid-exporter -squid-hostname host.internal -squid-port 3129 &

# Initiate Telegraf
telegraf &

# Initiate cAdvisor
cadvisor
