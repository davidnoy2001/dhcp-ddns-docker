#!/bin/bash

echo 1 | tee /proc/sys/net/ipv4/ip_forward

nft list tables | grep -q '^table ip nat$' || nft add table ip nat

# Crear chain POSTROUTING si no existe
nft list chain ip nat POSTROUTING >/dev/null 2>&1 || \
  nft 'add chain ip nat POSTROUTING { type nat hook postrouting priority 100 ; policy accept; }'

# Agregar regla de masquerade (evita duplicados)
nft list ruleset | grep -q 'oifname "eth0" masquerade' || \
  nft add rule ip nat POSTROUTING oifname "eth0" masquerade


ip addr add 192.168.20.253/24 dev eth1

# Mantener el contenedor vivo
#Chamar ao relay
dhcp-helper -s 192.168.20.10 -i eth2 -d

