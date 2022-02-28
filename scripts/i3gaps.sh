#!/bin/bash

echo "WARNING: Running this script will replace the following dotfiles"
echo ".vimrc, .fonts, .Xresources, .xbindkeysrc, config.fish and i3config"
echo "old files are stored in dotfiles-backup folder"

echo "Creating dotfiles backup"
mkdir $HOME/dotfiles-backup 

pushd $HOME

echo "Copying old dotfiles"
cp .vimrc .fonts .config/fish/config.fish .config/i3/config .Xresources .xbindkeysrc dotfiles-backup

popd


echo "Installing required softwares....."
sudo apt update
sudo apt upgrade -y
sudo apt install -y libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev \
	libxcb-util0-dev libxcb-icccm4-dev libyajl-dev \
	libstartup-notification0-dev libxcb-randr0-dev \
	libev-dev libxcb-cursor-dev libxcb-xinerama0-dev \
	libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev \
	autoconf libxcb-xrm0 libxcb-xrm-dev automake libxcb-shape0-dev \
	ranger vim vim-gtk python3-pip rofi mpv scrot \
	thunar htop arandr zathura fish rxvt-unicode \
	curl lxappearance numix-gtk-theme \
	breeze-cursor-theme xclip guake copyq vlc \
	blueman network-manager gsimplecal feh pavucontrol \
	pulseaudio lm-sensors git i3lock imagemagick compton

echo "change shell to fish shell...."
sudo chsh -s /usr/bin/fish $USER

echo "Getting configs from git and setting them...."
git clone https://github.com/shahabaz-bagwan/dotfiles.git ~/github

echo "Installing correct fonts...."
if [ -d "$HOME/.fonts" ]; then
  echo "Installing fonts in $HOME/.fonts..."
	cp $HOME/github/fonts/* $HOME/.fonts/
	unzip $HOME/.fonts/Inconsolata.zip -d $HOME/.fonts
	fc-cache -fv
else
  echo "Creating $HOME/.fonts  directory and installing fonts in $HOME/.fonts "
	mkdir $HOME/.fonts
	cp $HOME/github/fonts/* $HOME/.fonts
	unzip $HOME/.fonts/Inconsolata.zip -d $HOME/.fonts
	fc-cache -fv
fi

echo "linking configs..."
if [ -d "$HOME/.config/fish" ]; then
	ln -sf $HOME/github/config.fish $HOME/.config/fish/config.fish
else
	mkdir $HOME/.config/fish
	ln -sf $HOME/github/config.fish $HOME/.config/fish/config.fish
fi

if [ -d "$HOME/.config/i3" ]; then
	ln -sf $HOME/github/i3config $HOME/.config/i3/config
else
	mkdir $HOME/.config/i3
	ln -sf $HOME/github/i3config $HOME/.config/i3/config
fi

ln -sf $HOME/github/vimrc $HOME/.vimrc
ln -sf $HOME/github/Xresources $HOME/.Xresources
xrdb -merge $HOME/.Xresources
ln -sf $HOME/github/xbindkeysrc $HOME/.xbindkeysrc

git clone https://github.com/shahabaz-bagwan/wallpapers.git $HOME/Pictures/wallpapers
mkdir $HOME/Pictures/scrot

touch $HOME/scrp.sh
curl -L https://get.oh-my.fish > $HOME/scrp.sh
fish $HOME/scrp.sh --noninteractive

fish << 'themeInstall'
	echo	"Setting fish theme as bobthefish"
	omf install bobthefish
  omf install https://github.com/jethrokuan/fzf  
themeInstall

echo "Installing bumblebee status-bar...."
pip3 install i3ipc
pip3 install psutil
pip3 install --user bumblebee-status

# at this path add gsimplecal so that click on date show the gisimplecal
# ~/.local/lib/python3.6/site-packages/bumblebee/modules/core/datetime.py

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
