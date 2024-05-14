# betterdiscord-flatpak-update.sh
Simple bash script to update Flatpak Discord, install OpenAsar, and update BetterDiscord

# Dependencies
``betterdiscordctl``: https://github.com/bb010g/betterdiscordctl  
``wget``  
``flatpak``  

# Key functions
* This script will check if the flatpak/flathub release [com.discordapp.Discord](https://flathub.org/apps/com.discordapp.Discord) is installed.  
It will then attempt to update it. (all flatpak commands in this script use the -y flag to automatically choose 'yes')  

* com.discordapp.Discord process is killed, and then ``betterdiscordctl -i flatpak install`` is invoked to download and install BetterDiscord itself.  

* After that, it will download [OpenAsar](https://github.com/GooseMod/OpenAsar), a mod to make Discord a bit faster and with less tracking.  
Unfortunately, the file that OpenAsar replaces is in a root folder, at least for the Flatpak installation of Discord. (/var/lib/flatpak/app/com.discordapp.Discord/current/active/files/discord/resources/app.asar)  
A password prompt will show, allowing you to download the new asar file directly to this location.  

* I have also included a part of the script which attempts to make the BetterDiscord config folder for the flatpak install (~/.var/app/com.discordapp.Discord/config/BetterDiscord) into a symbolic link to ~/.config/BetterDiscord  
This is because former apt/deb install users of Discord + BetterDiscord will already have their plugins and themes in this location. It is also just slightly easier to navigate to in a file browser.  

* Finally, after all this, discord is booted up for your convenience

# TODO
I have an older version of this script which does the same thing for apt/deb installations of Discord, and I would like to combine the two and include some command line options to choose which installation mode to use.  
I think I'd also add options to disable OpenAsar installation and symlinking the config folder.  
Please tell me what you think! Feedback is appreciated!
