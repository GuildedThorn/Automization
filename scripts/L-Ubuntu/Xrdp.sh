#!/bin/bash

update update
apt install xrdp

systectl enable xrdp --now

echo "lxsession -s Lubuntu -e LXDE" > ~/.sessions

echo -n "XRDP has been installed fpr the LXDE Graphics Environment"