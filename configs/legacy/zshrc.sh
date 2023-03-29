alias dh='dirs -v'
alias 1='cd -1'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -3'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'
alias 0='cd -10'
source ~/Published/configs/legacy/shrc.sh
DIRSTACKSIZE=11
HISTFILE=~/.history
HISTSIZE=1000
PROMPT='%(?..[%?] )%F{magenta}%D{%d-%m %H:%M:%S} | %~ %f'
SAVEHIST=1000
WORDCHARS=${WORDCHARS/\/}
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Za-z}'
autoload -Uz compinit && compinit
autoload -z edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line
bindkey "^[^[" expand-or-complete
bindkey '^N' history-beginning-search-forward
bindkey '^P' history-beginning-search-backward
setopt autocd autopushd hist_ignore_all_dups hist_ignore_space hist_no_store hist_reduce_blanks hist_verify menu_complete no_list_ambiguous share_history pushdignoredups pushdminus pushdsilent pushdtohome
