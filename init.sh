#!/bin/bash
# run this script after cloning repo

while true
do
read -p "do you want to build task with gnutls support? (Y/N)" yn
case $yn in
	[Yy]*)
		sudo apt-get install libgnutls-dev uuid-dev -y
		pushd ~/
		wget http://taskwarrior.org/download/task-2.4.4.tar.gz
		tar -xf task-2.4.4.tar.gz
		cd task-2.4.4
		cmake -DCMAKE_BUILD_TYPE=release .
		make
		ln -sf $PWD/src/task ~/.local/bin
		popd
		break;;
	[Nn]*) break;;
	*) echo "please answer yes or no";;
esac
done

while true
do
read -p "do you want to link taskrc to ~/.taskrc (Y/N)" yn
case $yn in
	[Yy]*) ln -s $PWD/taskrc ~/.taskrc; break;;
	[Nn]*) break;;
	*) echo "please answer yes or no";;
esac
done

while true
do
read -p "do you want to install popup crontab? (Y/N)" yn
case $yn in
	[Yy]*)
		ln -sf $PWD/task-popup.sh ~/.local/bin/
		(crontab -l; echo "*/30 * * * * DISPLAY=0: ~/.local/bin/task-popup.sh")|crontab -
		break;;
	[Nn]*) break;;
	*) echo "please answer yes or no";;
esac
done

while true
do
read -p "do you want to install sync crontab? (Y/N)" yn
case $yn in
	[Yy]*)
		ln -sf $PWD/task-popup.sh ~/.local/bin/
		(crontab -l; echo "*/30 * * * * ~/.local/bin/task sync")|crontab -
		break;;
	[Nn]*) break;;
	*) echo "please answer yes or no";;
esac
done

while true
do
read -p "do you want to extract pem files? (Y/N)" yn
case $yn in
	[Yy]*)
		gpg2 -d secret.tgz.gpg > secret.tgz
		tar -xf secret.tgz
		break;;
	[Nn]*) break;;
esac
done
