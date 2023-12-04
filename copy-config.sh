#!/bin/sh
dotFolder="dotfiles"
confFolder="config"
shellFolder="shell"
cronFolder="cron"

echo "--------------------------------------------------------------"
echo "                       Saving dotfiles"
echo "--------------------------------------------------------------"
cp -v ~/.zshrc 				${dotFolder}/.zshrc
cp -v ~/.zprofile 			${dotFolder}/.zprofile
cp -v ~/.vimrc 			    ${dotFolder}/.vimrc
cp -v ~/.xinitrc 			${dotFolder}/.xinitrc

echo "--------------------------------------------------------------"
echo "                     Saving config files"
echo "--------------------------------------------------------------"
cp -r -v ~/.config/picom/ 		${confFolder}/
cp -r -v ~/.config/ranger/		${confFolder}/

echo "--------------------------------------------------------------"
echo "                     Saving shell scripts"
echo "--------------------------------------------------------------"
cp -v ~/.local/bin/random_wallpaper.sh 	${shellFolder}/random_wallpaper.sh

echo "--------------------------------------------------------------"
echo "                     Saving local cronjobs"
echo "--------------------------------------------------------------"
crontab -l > ${cronFolder}/filip_cronjobs
