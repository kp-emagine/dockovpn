#!/usr/bin/env bash


docker run -d --rm --cap-add=NET_ADMIN \
-p 1194:1194/udp -p 80:8080/tcp \
-e HOST_ADDR="vpn.emagine.com" \
--name emagine-vpn alekslitvinenk/openvpn:latest
