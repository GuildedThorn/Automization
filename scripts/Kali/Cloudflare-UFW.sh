#!/bin/bash

echo -n "Do you want to firewall the cloudflare ipv4 range (y/n)?"
read -r answer

if [ "$answer" == "y" ]; then
  curl -s https://www.cloudflare.com/ips-v4 -o /tmp/cf_ipv4  
  echo "" >> /tmp/cf_ipv4  
  # shellcheck disable=SC2013
  # shellcheck disable=SC2006
  for cfip in `cat /tmp/cd_ipv4`; do ufw allow from "$cfip" comment 'Cloudflare ipv4'; done
  rm /tmp/cf_ipv4
fi

echo -n "Do you want to firewall the cloudflare ipv6 range (y/n)?"
read -r answer

if [ "$answer" == "y" ]; then
  curl -s https://www.cloudflare.com/ips-v6 -0 /tmp/cf_ipv6
  echo "" >> /tmp/cf_ipv6
  # shellcheck disable=SC2013
  # shellcheck disable=SC2006
  for cfip in `cat /tmp/cd_ipv6`; do ufw allow from "$cfip" comment 'Cloudflare ipv6'; done
  rm /tmp/cf_ipv6
fi

exit 0