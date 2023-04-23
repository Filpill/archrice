#!/bin/sh
dotFolder="dotfiles/"
confFolder="config/"

echo "--------------------------------"
echo "     Saving dotfiles files"
echo "--------------------------------"
cp -v ~/.zshrc 				${dotFolder}.zshrc
cp -v ~/.zprofile 			${dotFolder}.zprofile
cp -v ~/.vimrc 			        ${dotFolder}.vimrc
cp -v ~/.xinitrc 			${dotFolder}.xinitrc

echo "--------------------------------"
echo "      Saving config files"
echo "--------------------------------"
cp -r -v ~/.config/picom/ 		${confFolder}
cp -r -v ~/.config/ranger/		${confFolder}
