source ~/Published/configs/shrc.sh
HISTFILE=~/.history
HISTSIZE=1000
PROMPT='%(?..[%?] )%F{magenta}%D{%d-%m %H:%M:%S} | %~ %f'
SAVEHIST=1000
WORDCHARS=${WORDCHARS/\/}
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Za-z}'
autoload -Uz compinit && compinit
bindkey '\e[A' history-beginning-search-backward
bindkey '\e[B' history-beginning-search-forward
setopt hist_ignore_all_dups hist_ignore_space hist_no_store hist_reduce_blanks hist_verify menu_complete no_list_ambiguous share_history
