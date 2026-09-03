#!/bin/bash

mkdir -pv ~/{Programs/,Downloads/}
mkdir -pv ~/Media/{Images{Wallpapers,Misc,Screenshots},Videos,Misc}
mkdir -pv ~/Documents/Code/{Python/,Shell/,JS-TS/,C-CPP/}
mkdir -pv ~/.local/share/fonts/
mkdir -pv ~/.config/nvim
mkdir -pv ~/{.themes/,.icons/}

rm -rvf ./logfiles
mkdir -pv ./logfiles/{05sh/,07sh/}

if [ ! -d ~/Programs/dotfiles ]; then
  git clone https://github.com/frmiza/dotfiles ~/Programs/dotfiles
fi

if [ ! -d ~/Programs/vim-config ]; then
  git clone https://github.com/frmiza/vim-config ~/Programs/vim-config
fi

./00-system-packages.sh | tee ./logfiles/00sh.log
./01-graphic-interface.sh | tee ./logfiles/01sh.log
./02-term.sh | tee ./logfiles/02sh.log
./03-panel.sh | tee ./logfiles/03sh.log
./04-browsers.sh | tee ./logfiles/04sh.log
./05-development.sh
./07-miscelanies.sh

echo -e "\n\n####### NEOVIM #######\n" >> ./logfiles/general.log
cp -rv ~/Programs/vim-config/* ~/.config/nvim/ | tee -a ./logfiles/general.log
source ~/.config/nvim/dependencies.sh | tee -a ./logfiles/05sh/nvim_deps_install.log

#cp -r ~/Programs/dotfiles/{scripts,zathura} ~/.config/ 

if [ -f "$(which bspwm 2>/dev/null)" ]; then
  echo -e "\n\n####### BSPWM #######\n" >> ./logfiles/general.log
  cp -rv ~/Programs/dotfiles/{bspwm/,sxhkd/} ~/.config/ | tee -a ./logfiles/general.log 
fi

if [ -f "$(which polybar 2>/dev/null)" ]; then
  echo -e "\n\n####### POLYBAR #######\n" >> ./logfiles/general.log
  cp -rv ~/Programs/dotfiles/polybar ~/.config/ | tee -a ./logfiles/general.log
  cp -rv ~/Programs/dotfiles/scripts ~/.config/ | tee -a ./logfiles/general.log
fi

if [ -f "$(which picom 2>/dev/null)" ]; then
  echo -e "\n\n####### PICOM #######\n" >> ./logfiles/general.log
  cp -rv ~/Programs/dotfiles/picom ~/.config/ | tee -a ./logfiles/general.log
fi

if [ -f "$(which alacritty 2>/dev/null)" ]; then
  echo -e "\n\n####### ALACRITTY #######\n" >> ./logfiles/general.log
  cp -rv ~/Programs/dotfiles/alacritty ~/.config/ | tee -a ./logfiles/general.log
fi

#if [ -f "$(which rofi 2>/dev/null)" ]; then
  #cp -r ~/Programs/dotfiles/rofi ~/.config/ 
#fi

if [ -f "$(which openbox 2>/dev/null)" ]; then
  echo -e "\n\n####### OPENBOX #######\n" >> ./logfiles/general.log
  cp -r ~/Programs/dotfiles/openbox ~/.config/ | tee -a ./logfiles/general.log
  cp -r ~/Programs/dotfiles/.themes/Shoyo-Theme ~/.themes | tee -a ./logfiles/general.log
fi

if [ -f "$(which ranger 2>/dev/null)" ]; then
  echo -e "\n\n####### RANGER #######\n" >> ./logfiles/general.log
  ranger --copy-config=all
  cp -rv ~/Programs/dotfiles/ranger/* ~/.config/ranger/ | tee -a ./logfiles/general.log
  cp -rv ~/Programs/dotfiles/.themes/shoyo.zsh-theme ~/..oh-my-zsh/themes/ | tee -a ./logfiles/general.log
fi
