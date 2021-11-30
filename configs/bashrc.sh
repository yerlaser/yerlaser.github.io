bind TAB:menu-complete
bind "set completion-ignore-case on"
bind "set menu-complete-display-prefix on"
bind "set show-all-if-ambiguous on"

bind '"\C-@":history-expand-line'
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'
bind '"\e[5~":backward-word'
bind '"\e[6~":forward-word'
bind '"\e[17~":kill-line'
bind '"\e[19~":kill-whole-line'
bind '"\eOR":backward-kill-line'
PROMPT_COMMAND='MYVAR="$?" && [ "$MYVAR" -ne 0 ] && printf "[$MYVAR] "'
PS1="\[\e[2;35m\]\D{%d-%m %H:%M:%S} | \w \[\e[0m\]"

shopt -s direxpand
shopt -s dotglob
shopt -s globstar
shopt -s histappend
shopt -s histverify
HISTCONTROL=ignoredups:erasedups:ignorespace

source /LOCAL/Published/configs/shrc.sh
if [ -s "$HOME/Sources/bash-complete-partial-path/bash_completion" ]
then
    source "$HOME/Sources/bash-complete-partial-path/bash_completion"
    _bcpp --defaults
fi
