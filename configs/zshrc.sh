source /LOCAL/Sources/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source /LOCAL/Published/configs/shrc.sh

HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.history
PROMPT='%(?..[%?] )%F{magenta}%D{%d-%m %H:%M:%S} | %~ '
WORDCHARS=${WORDCHARS/\/}

zstyle ':autocomplete:*' min-input 1
zstyle ':completion:*:paths' path-completion yes

setopt hist_ignore_all_dups hist_ignore_space hist_no_store hist_reduce_blanks hist_verify share_history
