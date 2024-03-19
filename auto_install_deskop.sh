#!/bin/sh
dotfilerepo="https://github.com/Filpill/archrice.git"
programsfile="https://raw.githubusercontent.com/Filpill/archrice/main/programs.csv"
export TERM=ansi

installpkg() {
    pacman --noconfirm --needed -S "$1" >/dev/null 2>&1
}

error() {
    #Log Standard Error and Output
    printf "%s\n" "$1" >&2
    exit 1
}

welcomemsg() {
    whiptail --title "Arch Desktop Ricing Script by Filpill" \
             --msgbox "Welcome to the ricing script, please select modules to install." 10 60

    whiptail --title "Important Note!" \
             --yes-button "Yes - System is up-to-date" \
             --no-button  "No - I must run update" \
             --yesno "Make sure computer is using latest pacman updates and refreshed Arch keyrings i.e.: \n\n pacman -Syu \n pacman -S archlinux-keyring \n\n An out-of-date system may cause the installation may fail." 12 90
}

createuserandpass () {
    name=$(whiptail --inputbox "Please enter a name for the user account." 10 60 3>&1 1>&2 2>&3 3>&1) || exit 1
    while ! echo "$name" | grep -q "^[a-z_][a-z0-9_-]*$"; do
        name=$(whiptail --nocancel --inputbox "Username not valid. Must start with letter, and then contain lowercase letters only, - or _." 10 90 3>&1 1>&2 2>&3 3>&1)
    done
    pass1=$(whiptail --nocancel --passwordbox "Enter a password for that user." 10 60 3>&1 1>&2 2>&3 3>&1)
	pass2=$(whiptail --nocancel --passwordbox "Retype password." 10 60 3>&1 1>&2 2>&3 3>&1)
	while ! [ "$pass1" = "$pass2" ]; do
		unset pass2
		pass1=$(whiptail --nocancel --passwordbox "Passwords do not match.\\n\\nEnter password again." 10 60 3>&1 1>&2 2>&3 3>&1)
		pass2=$(whiptail --nocancel --passwordbox "Retype password." 10 60 3>&1 1>&2 2>&3 3>&1)
	done
}

usercheck() {
	! { id -u "$name" >/dev/null 2>&1; } ||
		whiptail --title "WARNING" \
                --yes-button "CONTINUE" \
			    --no-button "No wait..." \
			    --yesno "The user \`$name\` already exists on this system. This script WILL OVERWRITE conflicting settings/dotfiles on the user account. Click <CONTINUE> if you don't mind your settings being overwritten.\\n\\nNote also that the script will change $name's password to the one you just gave." 14 70
}

adduserandpass() {
	# Adds user `$name` with password $pass1.
	whiptail --infobox "Adding user \"$name\"..." 7 50
	useradd -m -g wheel -s /bin/zsh "$name" >/dev/null 2>&1 ||
		usermod -a -G wheel "$name" && mkdir -p /home/"$name" && chown "$name":wheel /home/"$name"
	export repodir="/home/$name/.local/src"
	mkdir -p "$repodir"
	chown -R "$name":wheel "$(dirname "$repodir")"
	echo "$name:$pass1" | chpasswd
	unset pass1 pass2
}

installaurhelper() {
    # Install yay to streamline AUR package build process
    pacman -Qq yay && return 0
	whiptail --infobox "Installing AUR Helper - yay..." 7 50
    sudo -u "$name" mkdir -p "$repodir/yay"
    sudo -u "$name" git clone -C "$repodir" clone --depth 1 --single-branch \
        --no-tags -q "https://aur.archlinux.org/yay.git" "$repodir/yay ||
        {
                cd "$repodir/yay" || return 1
                sudo -u "$name" git pull --force origin master
        }
    cd "$repodir/yay" || exit 1
    sudo -u "$name -D "$repodir/yay" \
          makepkg --noconfirm -si >/dev/null 2>&1 || return 1
}

installationloop() {
	([ -f "$programsfile" ] && cp "$programsfile" /tmp/progs.csv) ||
		curl -Ls "$programsfile" | sed '/^#/d' >/tmp/progs.csv
	total=$(wc -l </tmp/progs.csv)
	while IFS=";" read -r tag name description; do
        n=$((n+1))
        tag=$(echo "$tag" | awk '{$1=$1;print}')
        name=$(echo "$name" | awk '{$1=$1;print}')
        description=$(echo "$description" | awk '{$1=$1;print}')
        echo "$n/$total Name of Prog: $tag $name $description"
        whiptail --title "Program Installation" --infobox "Installing $name ($n of $total)...\n$description" 9 75

        if [ $tag = "pacman" ]; then
            installpkg 
        fi

    done < "/tmp/progs.csv"
}

#welcomemsg || error "User exited"
#createuserandpass || error "User exited"
#usercheck || "User exited"
#installationloop || "User exited"
installaurhelper || "User exited"
clear
