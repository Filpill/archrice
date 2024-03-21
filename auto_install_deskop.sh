#!/bin/sh
dotfilerepo="https://github.com/Filpill/archrice.git"
programsfile="https://raw.githubusercontent.com/Filpill/archrice/main/programs.csv"
export TERM=ansi

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
	export scriptdir="/home/$name/.local/bin"
	export fontdir="/home/$name/.local/share/fonts"
	export configdir="/home/$name/.config"
	mkdir -p "$repodir"
    mkdir -p "$configdir"
    mkdir -p "$scriptdir"
    mkdir -p "$fontdir"
	chown -R "$name":wheel "$(dirname "$repodir")"
	echo "$name:$pass1" | chpasswd
	unset pass1 pass2
}

deployconfig() {
    # Deploy Config, Dotfiles and Scripts
	whiptail --title "Filpill's Desktop Setup Script" \
            --infobox "Deploying Desktop Dotfiles and Scripts" 7 50
    cd /home/$name
	sudo -u "$name" git -C "$repodir" clone https://github.com/Filpill/archrice.git
    cp -r "$repodir/archrice/config/dotfiles/." "/home/$name"
    cp -r "$repodir/archrice/config/."          "$configdir"
    cp -r "$repodir/archrice/scripts/."         "$scriptdir"
    cp -r "$repodir/archrice/fonts/."           "$fontdir"
    rm /home/$name/.bashrc
    rm /home/$name/.bash_profile
    rm /home/$name/.bash_logout
    rm /home/$name/.vim
    rm /home/$name/.viminfo
}

installaurhelper() {
    # Install yay to streamline AUR package build process
    pacman -Qq yay && return 0
	whiptail --infobox "Installing AUR Helper - yay..." 7 50
    sudo -u "$name" mkdir -p "$repodir/yay"
    sudo -u "$name" git clone -C "$repodir" clone --depth 1 --single-branch --no-tags -q "https://aur.archlinux.org/yay.git" "$repodir/yay" ||
        {
                cd "$repodir/yay"
                sudo -u "$name" git pull --force origin master
        }
    cd "$repodir/yay"
    sudo -u "$name" makepkg --noconfirm -si 
}

gitmakeinstall() {
	progname="${1##*/}"
	progname="${progname%.git}"
	dir="$repodir/$progname"
	whiptail --title "Filpill's Desktop Setup Script" \
		--infobox "Installing \`$progname\` ($n of $total) via \`git\` and \`make\`. $(basename "$1") $2" 8 70
	sudo -u "$name" git -C "$repodir" clone --depth 1 --single-branch \
		--no-tags -q "$1" "$dir" ||
		{
			cd "$dir" || return 1
			sudo -u "$name" git pull --force origin master
		}
	cd "$dir" || exit 1
	make >/dev/null 2>&1
	make install >/dev/null 2>&1
	cd /tmp || return 1
}

aurinstall() {
	whiptail --title "Filpill's Desktop Setup Script" \
		--infobox "Installing \`$1\` ($n of $total) from the AUR. $1 $2" 9 70
	echo "$aurinstalled" | grep -q "^$1$" && return 1
	sudo -u "$name" yay -S --noconfirm "$1" >/dev/null 2>&1
}

pacmaninstall() {
    pacman --noconfirm --needed -S "$1" >/dev/null 2>&1
}

installationloop() {
	([ -f "$programsfile" ] && cp "$programsfile" /tmp/progs.csv) ||
		curl -Ls "$programsfile" | sed '/^#/d' >/tmp/progs.csv
	total=$(wc -l </tmp/progs.csv)
	while IFS=";" read -r tag programname description; do
        n=$((n+1))
        tag=$(echo "$tag" | awk '{$1=$1;print}')
        programname=$(echo "$programname" | awk '{$1=$1;print}')
        description=$(echo "$description" | awk '{$1=$1;print}')
        echo "$n/$total Name of Prog: $tag $programname $description"
       # whiptail --title "Program Installation" --infobox "Installing $programname ($n of $total)...\n$description" 9 75
		case "$tag" in
            "AUR") aurinstall "$programname" "$comment" ;;
            "pacman") pacmaninstall "$programname" "$comment" ;;
            "github") gitmakeinstall "$programname" "$comment" ;;
		esac
    done < "/tmp/progs.csv"
}

# Create user and password
welcomemsg || error "User exited"
createuserandpass || error "User exited"
usercheck || "User exited"

# Ensure prerequisite programs exist
for x in curl ca-certificates base-devel git ntp zsh; do
	whiptail --title "Filpill's Desktop Setup Script" \
		--infobox "Installing \`$x\` which is required to install and configure other programs." 8 70
	pacmaninstall "$x"
done

# Ensure Date and Time is Synced
	whiptail --title "Filpill's Desktop Setup Script" \
             --infobox "Synchronizing system time to ensure successful and secure installation of software..." 8 70
    ntpd -q -g >/dev/null 2>&1

# Adding User and Pass
adduserandpass || error "Error adding username and/or password"

# Make backup of sudoers file
[ -f /etc/sudoers.pacnew ] && cp /etc/sudoers.pacnew /etc/sudoers

# Allow user to run sudo without password. Since AUR programs must be installed
# in a fakeroot environment, this is required for all builds with AUR.
trap 'rm -f /etc/sudoers.d/filpill-temp' HUP INT QUIT TERM PWR EXIT
echo "%wheel ALL=(ALL) NOPASSWD: ALL
Defaults:%wheel runcwd=*" >/etc/sudoers.d/filpill-temp

# Make pacman colorful, concurrent downloads and Pacman eye-candy.
grep -q "ILoveCandy" /etc/pacman.conf || sed -i "/#VerbosePkgLists/a ILoveCandy" /etc/pacman.conf
sed -Ei "s/^#(ParallelDownloads).*/\1 = 5/;/^#Color$/s/#//" /etc/pacman.conf

# Use all cores for compilation.
sed -i "s/-j2/-j$(nproc)/;/^#MAKEFLAGS/s/^#//" /etc/makepkg.conf

# Install Aurhelper - yay - Ensuring automatic updates
installaurhelper || "User exited"
yay -Y --save --devel

# Read programs.csv and install programs
installationloop || "User exited"

# Deploying Configuration | dotfiles, configs, scripts and fonts
deployconfig || "User exited"

# Change default shell to zsh for user
chsh -s /bin/zsh "$name" >/dev/null 2>&1
sudo -u "$name" mkdir - "/home/$name/.cache/zsh"

# Allow wheel users to sudo with password and allow several system commands
echo "%wheel ALL=(ALL:ALL) ALL" >/etc/sudoers.d/00-filpill-wheel-can-sudo
echo "%wheel ALL=(ALL:ALL) NOPASSWD: /usr/bin/shutdown,/usr/bin/reboot,/usr/bin/systemctl suspend,/usr/bin/wifi-menu,/usr/bin/mount,/usr/bin/umount,/usr/bin/pacman -Syu,/usr/bin/pacman -Syyu,/usr/bin/pacman -Syyu --noconfirm,/usr/bin/loadkeys,/usr/bin/pacman -Syyuw --noconfirm,/usr/bin/pacman -S -y --config /etc/pacman.conf --,/usr/bin/pacman -S -y -u --config /etc/pacman.conf --" >/etc/sudoers.d/01-filpill-cmds-without-password
echo "Defaults editor=/usr/bin/nvim" >/etc/sudoers.d/02-filpill-visudo-editor
mkdir -p /etc/sysctl.d
echo "kernel.dmesg_restrict = 0" > /etc/sysctl.d/dmesg.conf

# Installation Complete
whiptail --title "Installation Complete!" \
         --msgbox "Congrats! Provided there were no hidden errors, the script completed successfully and all the programs and configuration files should be in place.\\n\\nTo run the new graphical environment, log out and log back in as your new user, then run the command \"startx\" to start the graphical environment (it will start automatically in tty1).\\n\\nFilip" 13 80
