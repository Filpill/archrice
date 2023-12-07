#!/bin/sh

#Define Variables For Saving Dotfiles and Folders to Git Repo
dot_array=(".zshrc" ".zshenv" ".zprofile" ".xinitrc")
de_folder="$HOME/desktop_setup"
base_folder="${de_folder}/$(basename $(pwd))"
config_folder="${de_folder}/$(basename $(pwd))/config"
script_folder="${de_folder}/$(basename $(pwd))/script"

#Making sure we have DE Folder Setup For Organisation
if [ -d "${de_folder}" ]; then
    echo "desktop env folder already exists"
else
    mkdir $de_folder
    echo "desktop env folder created"
fi

function copy_local {
    echo "Copying Local System Configuration Git Repo"
    echo "==========================================="
    #Looping Through Dotfile Array
    for file in "${dot_array[@]}"; do
        if [ -f $HOME/${file} ]; then 
            echo "Saving dotfile ${file}"
            cp $HOME/${file} ${config_folder}/dotfiles/${file}
        fi
    done

    #Looping Through Config Array
    for folder in "$HOME/.config"/*; do
        if [ -d "$folder" ] && [ "$(basename $folder)" != "dotfiles" ]; then 
            echo "Saving config $(basename $folder)"
            cp -r $folder ${config_folder}
        fi 
    done

    #Looping Through Scripts 
    for file in "$HOME/.local/bin"/*; do
        if [ -f $file ]; then
            echo "Saving script $(basename $file)"
            cp $file ${script_folder}
        fi 
    done

    #Saving Fonts
    echo "Saving Fonts"
    cp -r $HOME/.local/share/fonts $base_folder

    #Saving Crontabs
    crontab -l > ${script_folder}/filip_crontab
}

function deploy_config {
    echo "Deploying Git Repo Config to Local System"
    echo "========================================="
    #Looping Through Git Dotfiles
    for file in "${dot_array[@]}"; do
        if [ -f ${config_folder}/dotfiles/${file} ]; then 
            echo "Deploying dotfile $file"
            cp  ${config_folder}/dotfiles/${file} $HOME/$file
        fi
    done

    #Looping Through Git Configs 
    for folder in "${config_folder}"/*; do
        if [ -d "$folder" ] && [ $(basename $folder) != "dotfiles" ]; then 
            echo "Deploying config $(basename $folder)"
            cp -r $folder $HOME/.config
        fi 
    done

    #Looping Through Scripts 
    for file in "${script_folder}"/*; do
        if [ -f $file ]; then
            echo "Deploying script $(basename $file)"
            cp $file $HOME/.local/bin
        fi 
    done

    #-----
    #Deploying Crontabs -- TO DO
    #-----
}

function program_install {
    csv_file="${de_folder}/$(basename $(pwd))/programs.csv"
    declare -a program_array
    declare -a pArray

    while IFS= read -ra line; do
        program_array+=("$(echo "$line" | tr ',' ' ')")
    done < "$csv_file"

    for program in "${program_array[@]}"; do
        pArray+=$program
    done

    echo "Run System Update - Enter PW"
    #sudo pacman -Syu
    echo "The following programs are going to be installed:"
    echo $pArray
    sudo pacman -S $pArray

    echo "Installing Image Previewer ctpv from github"
    cd $de_folder
    git clone https://github.com/NikitaIvanovV/ctpv
    cd $de_folder/ctpv
    make
    sudo make install
}

function suckless_install {
    echo "Suckless Install Procedure"
    echo "=========================="
    cd $de_folder

    if [ -d "${de_folder}/st" ]; then
        echo "st - already exists"
    else
        echo "st - does not exist - cloning from repo"
        git clone https://github.com/Filpill/st.git
        cd ${de_folder}/st
        sudo make clean install
    fi
    
    cd ${de_folder}

    if [ -d "${de_folder}/dwm" ]; then
        echo "dwm - already exists"
    else
        echo "dwm - does not exist - cloning from repo"
        git clone https://github.com/Filpill/dwm.git
        cd ${de_folder}/dwm
        sudo make clean install
    fi
}

function git_push {
    echo "Pushing Config and Script Update to Github"
    echo "=========================================="

    git add .
    msg="updating config files `date`"
    if [ $# -eq 1 ]
        then msg="$1"
    fi
    git commit -m "$msg"
    git push origin main
}

#-------------Script Starts Here------------------
# Hashmap to define what options this script can execute
declare -A actions=(
    [1]="1 - Copy Local System Configuration to Git" 
    [2]="2 - Deploy Repository Config to Local System" 
    [3]="3 - Install Required Arch Linux Programs"
    [4]="4 - Clone and Install Suckless: DWM/ST"
    [5]="5 - Push Changes to Git Repository"
)
keys_sorted=($(echo ${!actions[@]} | tr ' ' '\n' | sort -n))

# Run the selected function defined in the script
while true; do
    echo "=============================================="
    echo "Please Select An Action (Enter Integer Value):"
    echo "=============================================="
    for key in "${keys_sorted[@]}"; do
        echo "  ${actions[$key]}"
    done
    read num
    case $num in
        1) copy_local ;;
        2) deploy_config ;;
        3) program_install ;;
        4) suckless_install  ;;
        5) git_push ;;
        *) 
            clear
            echo "-------------------------------------------------"
            echo "---  Invalid Selection - Enter Value on List  ---"
            echo "-------------------------------------------------
            "
            continue ;;
    esac
    break
done
