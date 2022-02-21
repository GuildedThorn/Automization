#!/bin/bash

if [ -x "$(command -v ufw)" ]; then
  ufw enable
  for cfip in $(curl "https://tcpshield.com/v4/"); do ufw allow from $cfip comment 'TCPShield ipv4'; done
  echo -n "Successfully added TCPShield ipv4 addresses to firewall."
else
  apt install ufw
  ufw enable
  for cfip in $(curl "https://tcpshield.com/v4/"); do ufw allow from $cfip comment 'TCPShield ipv4'; done
  echo -n "Successfully added TCPShield ipv4 addresses to firewall."
fi
