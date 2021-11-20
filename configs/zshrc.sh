source /LOCAL/Sources/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source /LOCAL/Published/configs/shrc.sh

HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.history
PROMPT='%(?..[%?] )%F{magenta}%D{%d-%m %H:%M:%S} | %~ %f'
WORDCHARS=${WORDCHARS/\/}

zstyle ':autocomplete:*' min-input 1
zstyle ':autocomplete:*' min-delay .3
zstyle ':completion:*:paths' path-completion yes
zstyle ':autocomplete:*' insert-unambiguous yes

bindkey -M menuselect '\e[2~' accept-line
bindkey '\e[5~' backward-word
bindkey '\e[6~' forward-word
bindkey '\e[17~' kill-line
bindkey '\e[19~' backward-kill-line
bindkey '\e[F' end-of-line
bindkey '\e[H' beginning-of-line
bindkey '\eOR' kill-whole-line

setopt hist_ignore_all_dups hist_ignore_space hist_no_store hist_reduce_blanks hist_verify share_history
