#!/bin/bash
#by Ao1Pointblank, May 13, 2024
#https://github.com/Ao1Pointblank

#DEPENDENCIES:
#https://github.com/bb010g/betterdiscordctl

APP_ID="com.discordapp.Discord"

#check if the Flatpak app is installed
if flatpak info $APP_ID &> /dev/null; then
	echo ">>Flatpak $APP_ID is installed, checking for updates"
	flatpak update $APP_ID -y
else
	echo ">>$APP_ID is not installed. Installing now"
	flatpak install flathub $APP_ID -y
fi

echo ">>killing $APP_ID"
flatpak kill $APP_ID

#check for bdctl updates (it won't ever get updated)
#betterdiscordctl self-upgrade

echo ">>installing betterdiscord"
betterdiscordctl -i flatpak install

#for useless extra info
#betterdiscordctl -i flatpak status

#OPENASAR
echo ">>downloading openasar. requires password to install"
sudo wget --quiet -O "/var/lib/flatpak/app/com.discordapp.Discord/current/active/files/discord/resources/app.asar" https://github.com/GooseMod/OpenAsar/releases/download/nightly/app.asar

#LINK CONFIG FOLDER FROM DEFAULT INSTALLATION
SOURCE_DIR="$HOME/.config/BetterDiscord"
DESTINATION_DIR="$HOME/.var/app/com.discordapp.Discord/config"

#link the $SOURCE_DIR. make sure this folder is permitted in Flatseal
if [ ! -L "$DESTINATION_DIR/BetterDiscord" ]; then
	echo ">>attempting to link existing BetterDiscord config folder"
	ln -s "$SOURCE_DIR" "$DESTINATION_DIR"
fi

echo ">>starting $APP_ID"
nohup flatpak run com.discordapp.Discord >/dev/null 2>&1 &

##TODO: combine with ~/.local/bin/betterdiscord-update.sh and add argparsing for different install modes (deb vs flatpak)
