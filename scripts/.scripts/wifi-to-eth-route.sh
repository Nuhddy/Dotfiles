#! /bin/bash

sudo sysctl -w net.ipv4.ip_forward=1
sudo iptables -t nat -A POSTROUTING -o wlo1 -j MASQUERADE
sudo iptables -I FORWARD -o wlo1 -s 192.168.0.0/16 -j ACCEPT
sudo iptables -I INPUT -s 192.168.0.0/16 -j ACCEPT
sudo ifconfig enp2s0 192.168.122.10 netmask 255.255.255.0 up
