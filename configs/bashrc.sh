bind TAB:menu-complete

bind '"\e[A":history-substring-search-backward'
bind '"\e[B":history-substring-search-forward'

HISTCONTROL=ignoredups:erasedups:ignorespace
PROMPT_COMMAND='MYVAR="$?" && [ "$MYVAR" -ne 0 ] && printf "[$MYVAR] "'
# PS1="\[\e[2;35m\]\D{%d-%m %H:%M:%S} | \w \[\e[0m\]"
PS1="\w "

shopt -s direxpand
shopt -s dotglob
shopt -s globstar
shopt -s histappend
shopt -s histverify

source /LOCAL/Published/configs/shrc.sh

if [ -s "$HOME/Sources/bash-complete-partial-path/bash_completion" ]; then
    source "$HOME/Sources/bash-complete-partial-path/bash_completion"
    _bcpp --defaults
fi
