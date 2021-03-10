set -o vi
# bind -m vi-insert '"\e\r":"$(sk -m --bind 'tab:down,btab:up,alt-enter:toggle')\r"'
bind "set completion-ignore-case on"
bind "set menu-complete-display-prefix on"
bind "set show-all-if-ambiguous on"
bind "set show-mode-in-prompt on"
bind TAB:menu-complete

shopt -s direxpand
shopt -s dotglob
shopt -s globstar
shopt -s histappend
shopt -s histverify
HISTCONTROL=ignoredups:erasedups:ignorespace

source ~/Synced/configs/shrc.sh
