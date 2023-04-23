#!/bin/sh
dotFolder="dotfiles/"
confFolder="config/"

echo "--------------------------------"
echo "Saving config files"
echo "--------------------------------"

cp -v ~/.zshrc 				${dotFolder}.zshrc
cp -v ~/.zprofile 			${dotFolder}.zprofile
cp -v ~/.vimrc 			        ${dotFolder}.vimrc
cp -v ~/.xinitrc 			${dotFolder}.xinitrc
cp -v ~/.config/picom/picom.conf 	${confFolder}picom/picom.conf
