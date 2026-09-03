#!/bin/bash

OPTION_INT="n"
OPTION_NVD="n"

MENU_INT="Intall Intel Graphics drivers? [Y/n]:"

echo -n "$MENU_INT"
read  -p " " OPTION_INT

if [ "$OPTION_INT" = "y" ] || [ "$OPTION_INT" = "Y" ] || [ "$OPTION_INT" = "" ]; then
  sudo pacman -S xf86-video-intel \
    vulkan-intel \
    lib32-vulkan-intel \
    vulkan-tools \
    mesa \
    lib32-mesa \
    intel-media-driver \
    libva-utils \
    vdpauinfo \
    clinfo --noconfirm
else
  echo "You can install Intel Graphics later."
fi

MENU_NVD="Intall Nvidia drivers(Maxwell Architeture)? [Y/n]:"

echo -n "$MENU_NVD"
read  -p " " OPTION_NVD
if [ "$OPTION_NVD" = "y" ] || [ "$OPTION_NVD" = "Y" ] || [ "$OPTION_NVD" = "" ]; then
  kernel_version=$(uname -r)
  if [[ $kernel_version == *"-lts"* ]]; then
    sudo pacman -S nvidia-lts nvidia-utils nvidia-settings --noconfirm
  else
   sudo pacman -S nvidia nvidia-utils nvidia-settings
  fi 
else
  echo "You can install Nvidia drivers later."
fi
