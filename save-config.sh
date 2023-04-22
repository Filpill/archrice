#!/bin/sh
dotFolder=".dotfiles/"
confFolder=".config/"
cp -v ~/.zshrc 				${dotFolder}.zshrc
cp -v ~/.zprofile 			${dotFolder}.zprofile
cp -v ~/.xinitrc 			${dotFolder}.xinitrc
cp -v ~/.config/picom/picom.conf 	${confFolder}picom/picom.conf
