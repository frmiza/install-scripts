#!/bin/bash

sudo pacman -S pipewire\
               pipewire-pulse\
               pipewire-jack\
               pavucontrol --noconfirm

sudo groupadd audio
sudo usermod -a -G audio $USER 
echo "#audio" | sudo tee -a /etc/security/limits.conf
echo "@audio   -   rtprio    95" | sudo tee -a /etc/security/limits.conf
echo "@audio   -   memlock   unlimited" | sudo tee -a /etc/security/limits.conf
sudo pacman -S cadence ardour --noconfirm
