#! /bin/bash

hostip=$(ip route show | awk '/default/ {print $3}')
echo "$hostip   host.internal" >> /etc/hosts

# Initiate MongoDB exporter
prometheus-mongodb-exporter &

# Initiate Squid exporter
prometheus-squid-exporter &

# Initiate Telegraf
telegraf &

# Initiate cAdvisor
cadvisor
