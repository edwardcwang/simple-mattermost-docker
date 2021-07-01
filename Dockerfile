# From https://docs.mattermost.com/install/install-ubuntu-2004.html

FROM ubuntu:20.04
MAINTAINER Edward Wang <edward.c.wang@compdigitec.com>

# Basic tools & dependencies
RUN apt-get update && apt-get install -y vim wget unzip git jq
RUN apt-get update && apt-get install -y --no-install-recommends poppler-utils # for pdftotext

# Grab Mattermost 5.36.1
RUN wget https://releases.mattermost.com/5.36.1/mattermost-team-5.36.1-linux-amd64.tar.gz
RUN tar -xvzf mattermost*.gz
RUN rm mattermost*.gz
RUN mv mattermost /opt
RUN mkdir -p /opt/mattermost/data

RUN mkdir -p /opt/mattermost/config
COPY config.json /opt/mattermost/config/
COPY build-config-json /opt/mattermost/config/

EXPOSE 80 443

# Entrypoint
COPY entrypoint.sh /

ENTRYPOINT /entrypoint.sh
