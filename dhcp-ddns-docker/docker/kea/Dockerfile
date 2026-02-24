FROM debian:13

# Allow optional HTTP proxy at build time. If not provided, do nothing.
ARG HTTP_PROXY
RUN if [ -n "$HTTP_PROXY" ]; then echo "Acquire::http { Proxy \"$HTTP_PROXY\"; };" >/etc/apt/apt.conf.d/02proxy; fi

RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y \
        procps \
        iproute2 \
        iputils-ping \
        dnsutils \
        tcpdump \
        rsyslog \        
        kea-dhcp4-server \
        kea-dhcp-ddns-server \
        && rm -rf /var/lib/apt/lists/*

# COPY kea-dhcp4.conf.json /etc   /kea/kea-dhcp4.conf

RUN mkdir -p /run/kea /var/run/kea /var/lib/kea && \
    touch /var/lib/kea/kea-leases4.csv && \
    chmod -R 777 /run/kea /var/run/kea /var/lib/kea && \
    mkdir -p /var/log/kea && chmod 777 /var/log/kea


RUN sed -i 's/^\s*module(load="imklog")/#module(load="imklog")/' /etc/rsyslog.conf
