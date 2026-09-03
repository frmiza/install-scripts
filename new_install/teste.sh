#!/bin/bash

source ~/Programs/install-scripts/arch-setup/installer.sh

JSON_PATH="./packages.json"
LOG_PATH="./logs"

installer "$JSON_PATH" "$LOG_PATH" "Xorg"
# Instalar a base do Xorg

# Instalar as ferramentas Wayland/Hyprland quando quiser mudar
# install-packages "$JSON_PATH" ".Packages.Wayland" "$LOG_PATH"
