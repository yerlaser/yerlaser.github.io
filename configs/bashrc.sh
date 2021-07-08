alias '..'='cd ..'
bind TAB:menu-complete
bind "set completion-ignore-case on"
bind "set menu-complete-display-prefix on"
bind "set show-all-if-ambiguous on"
bind '"\C-\xff":history-expand-line'
bind '"\e[1;5F":"\C-\xff\e[F"'
bind '"\e[1;5H":"\C-\xff\e[H"'
bind '"\e ":"\C-\xff "'
bind '"\e[13;2u":history-search-forward'
bind '"\e[Z":history-search-backward'
bind '"\e[3;2~":backward-kill-word'
PROMPT_COMMAND='MYVAR="$?" && [ "$MYVAR" -ne 0 ] && printf "[$MYVAR] "'
PS1='\e[2;35m\D{%d-%m %H:%M:%S} | \w \e[0m'

shopt -s direxpand
shopt -s dotglob
shopt -s globstar
shopt -s histappend
shopt -s histverify
HISTCONTROL=ignoredups:erasedups:ignorespace

source /LOCAL/Published/configs/shrc.sh
