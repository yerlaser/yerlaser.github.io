set -o vi
# bind -m vi-insert '"\e\r":"$(sk -m --bind 'tab:down,btab:up,alt-enter:toggle')\r"'
bind "set completion-ignore-case on"
bind "set menu-complete-display-prefix on"
bind "set show-all-if-ambiguous on"
bind "set show-mode-in-prompt on"
bind TAB:menu-complete
bind -m vi-insert '"\e[Z":history-search-backward'
bind -m vi-insert '"\e[3;2~":backward-kill-word'
# bind -M viins "^[[Z" history-beginning-search-backward-end

shopt -s direxpand
shopt -s dotglob
shopt -s globstar
shopt -s histappend
shopt -s histverify
HISTCONTROL=ignoredups:erasedups:ignorespace

source ~/Published/configs/shrc.sh
