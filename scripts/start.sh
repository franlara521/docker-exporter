#! /bin/bash

# Initiate MongoDB exporter
prometheus-mongodb-exporter &

# Initiate Squid exporter
prometheus-squid-exporter &

# Initiate Telegraf
telegraf &

# Initiate cAdvisor
cadvisor
