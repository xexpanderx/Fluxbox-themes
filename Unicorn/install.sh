#!/bin/bash -l
sponge_var="$(command -v sponge)"
if [ "$sponge_var" != "" ] ; then
	mkdir -p ~/.themes
	mkdir -p ~/.icons
	echo "Installing GTK2/GTK3 themes..."
	cp -r GTK/Unicorn ~/.themes/
	echo "Installing icons..."
	cp -r Icons/Unicorn ~/.icons/
	echo "Installing Fluxbox style..."
	cp -r Fluxbox/Style/Unicorn ~/.fluxbox/styles/
	echo "Installing Fluxbox init file..."
	cp ~/.fluxbox/init ~/.fluxbox/init.backup
	cat Fluxbox/init |  sed "s/alexsson/$(whoami)/g" | sponge Fluxbox/init
	cp Fluxbox/init ~/.fluxbox/init
	fbsetbg Wallpaper/wallpaper.jpg
	echo "Let me try to apply Fluxbox style for you (allowRemoteActions true required)..."
	fluxbox-remote restart
	echo "Installation done."
	echo "* Apply GTK2/GTK3 and icons with lxappearance or similar! *"
else
	echo "Please install moreutils."
fi
