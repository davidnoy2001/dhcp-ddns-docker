#!/bin/bash

ip route del default via 192.168.20.1
ip route add default via 192.168.20.254

# Borrar ficheiros con pid de dhcp4 e dhcp-ddns
rm -f /run/kea/kea-dhcp-ddns.kea-dhcp-ddns.pid
rm -f /run/kea/kea-dhcp4.kea-dhcp4.pid

kea-dhcp-ddns -d -c /etc/kea/kea-dhcp-ddns.conf  &
kea-dhcp4 -d -c /etc/kea/kea-dhcp4.conf

