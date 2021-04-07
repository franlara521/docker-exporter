FROM debian:10.8

# Download the latest packages
RUN apt-get update && apt-get upgrade -y

# Install basic tools
RUN apt-get update && apt-get install -y gnupg2 curl wget

# Add the repositories needed to install the exporters
RUN echo "deb http://ftp.de.debian.org/debian sid main" >> /etc/apt/sources.list
RUN wget -qO- https://repos.influxdata.com/influxdb.key | apt-key add -
RUN echo "deb https://repos.influxdata.com/debian buster stable" | tee /etc/apt/sources.list.d/influxdb.list

# Refresh the repos and install the exporters
RUN apt-get update && apt-get install -y cadvisor prometheus-squid-exporter prometheus-mongodb-exporter telegraf && rm -rf /var/lib/apt/lists/*

COPY ./scripts/start.sh ~/start.sh
COPY ./config/telegraf.conf /etc/telegraf/telegraf.conf

EXPOSE 8080/tcp
EXPOSE 9001/tcp
EXPOSE 9301/tcp


ENTRYPOINT ["/bin/sh","~/startbind.sh"]