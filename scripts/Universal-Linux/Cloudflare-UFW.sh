#!/bin/bash

echo -n "Do you want to firewall the cloudflare ipv4 range (y/n)?"
read -r answer

if [ "$answer" = "y" ]; then
  for cfip in $(curl "https://www.cloudflare.com/ips-v4"); do ufw allow from $cfip comment 'Cloudflare ipv4'; done
  echo -n "Successfully added Cloudflare ipv4 addresses to firewall."
fi

echo -n "Do you want to firewall the cloudflare ipv6 range (y/n)?"
read -r answer

if [ "$answer" = "y" ]; then
  for cfip in $(curl "https://www.cloudflare.com/ips-v6"); do ufw allow from $cfip comment 'Cloudflare ipv6'; done
  echo -n "Successfully added Cloudflare ipv6 addresses to firewall."
fi

echo -n "Successfully added Cloudflare IPs to firewall."

exit 0