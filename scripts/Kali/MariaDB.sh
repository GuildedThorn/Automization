#!/bin/bash

apt -y update
apt install mariadb-server

echo -n "Would you like allow remote connections (y/n)?"
read -r answer

if [ "$answer" = "y" ]; then
  # check if sed is installed
  if ! [ -x "$(command -v sed)" ]; then
    echo 'Error: sed is not installed.' >&2
    exit 1
  fi
  
  # allow remote access in my.cnf file
  sed -i 's/bind-address            = 127.0.0.1/bind-address            = 0.0.0.0/g' /etc/mysql/mariadb.conf.d/50-server.cnf
  
  # restart mariadb
  systemctl restart mariadb.service
fi

echo -n "Would you like to make an admin account (y/n)? "
read -r answer

if [ "$answer" = "y" ]; then
    echo -n "Enter the username: "
    read -r username
    echo -n "Enter the password: "
    read -r password
    # create a new user with the username and password provided
    mysql -u root -e "CREATE USER '${username}'@'%' IDENTIFIED BY '${password}';"
    # grant all privileges to the user
    mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO '${username}'@'%' WITH GRANT OPTION;"
    # flush privileges
    mysql -u root -e "FLUSH PRIVILEGES;"
fi

echo -n "Would you like to install ufw or allow mariadb to listen on port 3306 (y/n)? "
read -r answer

if [ "$answer" = "y" ]; then
  # check if ufw is installed
  if [ -x "$(command -v ufw)" ]; then
    ufw enable
    ufw allow 3306
  else
    apt install ufw
    ufw enable
    ufw allow 3306
    fi
fi

exit 0