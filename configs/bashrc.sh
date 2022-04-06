bind '"\e[A":history-substring-search-backward'
bind '"\e[B":history-substring-search-forward'

HISTCONTROL=ignoredups:erasedups:ignorespace
PS1="\[\e[2;35m\]\D{%d-%m %H:%M:%S} | \w \[\e[0m\]"

shopt -s direxpand
shopt -s dotglob
shopt -s globstar
shopt -s histappend
shopt -s histverify

source /LOCAL/Published/configs/shrc.sh

set -o noclobber
