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
  && update-alternatives --install /usr/bin/vim vim /usr/bin/vim.tiny 1 

RUN curl https://dl.google.com/cloudagents/add-monitoring-agent-repo.sh | bash -
RUN apt-get update
RUN apt-get install -y stackdriver-agent
COPY statsd.conf /opt/stackdriver/collectd/etc/collectd.d/
ADD entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
