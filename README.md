# Filip's Arch Config Files And Scripts -- WORK IN PROGRESS

# Saving System Configs/Scripts/Dots
The **action.sh** contains a variety of functions to help apply various configurations to your system (or save new changes). (It's still currently under progress)

### TO DO
- Post Install Tasks e.g. 
    - Sudoers
    - Segment more of the functions into separate scripts?
    - Change default shell to zsh
    - Put files in the relevant directories
    - Pull out all the directories/mappings into separate file to be called on
    - Allow script to be curl'ed directly from the github and executed
    - Change copy_local and deploy_config functions to sit together. Use variables to interchange the source and destination of the copy procedure.

### IF INSTALLING DWM/ST on Raspberry Pi 4B
- If installing DWM on raspberry pi, minimallly, you must install the following dependancies in order for the program to compile:
```bash
sudo apt-get install \ 
    xorg \
    libx11-dev \
    libxft-dev \
    libxinerama-dev \
    xcb \
    libxcb-xkb-dev \
    x11-xkb-utils \
    libx11-xcb-dev \
    libxkbcommon-x11-dev \
    libxtst-dev \
    libxcb-res0-dev \
```
