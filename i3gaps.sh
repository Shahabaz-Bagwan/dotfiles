#!/bin/bash

sudo apt install -y libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev libxcb-icccm4-dev libyajl-dev libstartup-notification0-dev libxcb-randr0-dev libev-dev libxcb-cursor-dev libxcb-xinerama0-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev autoconf libxcb-xrm0 libxcb-xrm-dev automake ranger vim vim-gtk python3-pip rofi mpv scrot thunar htop arandr zathura fish rxvt-unicode lightdm i3lock-fancy curl lxappearance papirus-icon-theme numix-gtk-theme breeze-cursor-theme xclip

curl -L https://get.oh-my.fish | fish

omf install bobthefish

pip install --user bumblebee-status

sudo pip3 install pywal

cd /tmp
git clone https://www.github.com/Airblader/i3 i3-gaps
cd i3-gaps
git checkout gaps && git pull
autoreconf --force --install
rm -rf build
mkdir build
cd build
../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers
make
sudo make install
