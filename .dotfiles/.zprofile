#
# ~/.zprofile
#

[[ -f ~/.zshrc ]] && . ~/.zshrc

# StartX
[[ $(fgconsole 2>/dev/null) == 1 ]] && exec startx --vt1
