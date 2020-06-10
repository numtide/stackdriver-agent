# doesn't work for Ubuntu 18.04 (yet?)
# https://cloud.google.com/monitoring/agent/#supported_operating_systems
from ubuntu:18.04

RUN apt-get update && apt-get -y install --no-install-recommends \
    vim-tiny \
    iproute2 \
    curl \
    ca-certificates \
    lsb-release \
    gnupg2 \
    bash \
    wget \
  && update-alternatives --install /usr/bin/vim vim /usr/bin/vim.tiny 1 


RUN curl https://dl.google.com/cloudagents/add-monitoring-agent-repo.sh | bash -
RUN apt-get update
RUN apt-get install -y stackdriver-agent
RUN cd /opt/stackdriver/collectd/etc/collectd.d/ && wget --no-verbose https://raw.githubusercontent.com/Stackdriver/stackdriver-agent-service-configs/master/etc/collectd.d/statsd.conf

ADD entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
