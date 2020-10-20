#!/bin/bash

echo "Installing required softwares....."
sudo apt update
sudo apt upgrade
sudo apt install -y libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev \
	libxcb-util0-dev libxcb-icccm4-dev libyajl-dev \
	libstartup-notification0-dev libxcb-randr0-dev \
	libev-dev libxcb-cursor-dev libxcb-xinerama0-dev \
	libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev \
	autoconf libxcb-xrm0 libxcb-xrm-dev automake libxcb-shape0-dev \
	ranger vim vim-gtk python3-pip rofi mpv scrot \
	thunar htop arandr zathura fish rxvt-unicode lightdm \
	curl lxappearance papirus-icon-theme numix-gtk-theme \
	breeze-cursor-theme xclip guake copyq vlc \
	blueman network-manager gsimplecal feh pavucontrol \
	pulseaudio lm-sensors cargo git i3-lock imagemagick

cargo install exa
echo 'if [ -d "$HOME/.cargo/bin" ] ; then
    PATH="$HOME/.cargo/bin:$PATH"
	fi' > ~/.profile

echo "Getting configs from git and setting them...."
git clone https://github.com/Shahabaz-B/dotfiles.git ~/github

echo "Installing correct fonts...."
if [ -d "~/.fonts" ]; then
  echo "Installing fonts in ~/.fonts..."
	cp ~/github/fonts/* ~/.fonts/
	unzip ~/.fonts /Inconsolata.zip -d ~/.fonts
	fc-cache -fv
else
  echo "Creating ~/.fonts  directory and installing fonts in ~/.fonts "
	mkdir ~/.fonts
	cp ~/github/fonts/* ~/.fonts
	unzip ~/.fonts /Inconsolata.zip -d ~/.fonts
	fc-cache -fv
fi

echo "linking configs..."
if [-d "~/.config/fish"]; then
	ln -sf ~/github/config.fish ~/.config/fish/config.fish
else
	mkdir ~/.config/fish
	ln -sf ~/github/config.fish ~/.config/fish/config.fish
fi

if [-d "~/.config/i3"]; then
	ln -sf ~/github/i3config ~/.config/i3/config
else
	mkdir ~/.config/i3
	ln -sf ~/github/i3config ~/.config/i3/config
fi

ln -sf ~/github/vimrc ~/.vimrc
ln -sf ~/github/Xresources ~/.Xresources
xrdb -merge ~/.Xresources

git clone https://github.com/Shahabaz-B/wallpapers.git ~/Pictures/wallpapers
mkdir ~/Pictures/scrot


fish << 'END_FISH'
	echo "Installing OMF for fish shell...."
	curl -L https://get.oh-my.fish | fish
	
	echo	"Setting fish theme as bobthefish"
	omf install bobthefish
END_FISH

echo "change shell to fish shell...."
chsh -s /usr/bin/fish

echo "Installing bumblebee status-bar...."
pip3 install i3ipc
pip3 install psutil
pip3 install --user bumblebee-status

# at this path change icons if they are not displayed correctly
# ~/.local/lib/python2.7/site-packages/bumblebee/themes/icons/awesome-fonts.json 

# at this path add gsimplecal so that click on date show the gisimplecal
# ~/.local/lib/python2.7/site-packages/bumblebee/modules/datetime.py

echo "Installing pywal to get color-scheme from wallpaper"
sudo pip3 install pywal

echo "Installing i3-gaps form srouce..."
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

echo "i3-gaps is now installed... "
