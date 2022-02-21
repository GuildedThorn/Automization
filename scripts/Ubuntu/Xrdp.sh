#!/bin/bash

echo -n "Do you want to install xfce or gnome (x/g)?"
read -r answer

if [ "$answer" = "x" ]; then
  apt update
  apt install xubuntu-desktop
  
  apt install xrdp
  adduser xrdp ssl-cert
  systemctl restart xrdp
  
  systemctl enable xrdp
  
  reboot
fi

if [ "$answer" = "g" ]; then
  apt update
  apt install ubuntu-desktop
  
  apt install xrdp
  adduser xrdp ssl-cert
  systemctl restart xrdp
  
  systemctl enable xrdp
  
  reboot
fi