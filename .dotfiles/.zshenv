#Exporting Environmental Variables
export GOOGLE_APPLICATION_CREDENTIALS=$HOME/.config/gcloud/application_default_credentials.json
export RANGER_LOAD_DEFAULT_RC=false
export EDITOR="/usr/bin/nvim"
export XAUTHORITY=/home/filpill/.Xauthority
export DISPLAY=:0
export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$UID/bus

# Local Scripts
export PATH="$HOME/.local/bin:$PATH"                
export PATH="$HOME/.local/bin/camera:$PATH"
export PATH="$HOME/.local/bin/docker:$PATH"
export PATH="$HOME/.local/bin/git:$PATH"
export PATH="$HOME/.local/bin/system:$PATH"

# Google SDK Credentials
export PATH="$PATH:$GOOGLE_APPLICATION_CREDENTIALS" 

# Cargo
. "$HOME/.cargo/env"
