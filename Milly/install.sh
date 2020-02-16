#!/bin/bash -l
sponge_var="$(command -v sponge)"
if [ "$sponge_var" != "" ] ; then
	mkdir -p ~/.themes
	mkdir -p ~/.icons
	echo "Installing GTK2/GTK3 themes..."
	cp -r GTK3/Milly ~/.themes/
	echo "Installing icons..."
	cp -r Icons/Milly ~/.icons/
	echo "Installing Fluxbox style..."
	cp -r Fluxbox/Styles/Milly ~/.fluxbox/styles/
	echo "Installing Fluxbox init file..."
	cp ~/.fluxbox/init ~/.fluxbox/init.backup
	cat Fluxbox/Configs/init |  sed "s/alexsson/$(whoami)/g" | sponge Fluxbox/init
	cp Fluxbox/Configs/init ~/.fluxbox/init
	fbsetbg Wallpaper/wallpaper.jpg
	echo "Let me try to apply Fluxbox style for you (allowRemoteActions true required)..."
	fluxbox-remote restart
	echo "Installation done."
	echo "* Apply GTK2/GTK3, icons and font (Roboto, size 12) with lxappearance or similar! *"
else
	echo "Please install moreutils."
fi
