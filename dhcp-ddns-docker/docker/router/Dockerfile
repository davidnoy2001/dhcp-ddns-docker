FROM debian:13

# Allow optional HTTP proxy at build time. If not provided, do nothing.
ARG HTTP_PROXY
RUN if [ -n "$HTTP_PROXY" ]; then echo "Acquire::http { Proxy \"$HTTP_PROXY\"; };" >/etc/apt/apt.conf.d/02proxy; fi


RUN apt update  && apt install -y \
    procps \
    iproute2 \
    iputils-ping \
    bind9utils \
    dnsutils \
    tcpdump \
    dhcp-helper \
    nftables \
    && rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /sbin/entrypoint.sh

RUN chmod 777 /sbin/entrypoint.sh

ENTRYPOINT ["/sbin/entrypoint.sh"]
