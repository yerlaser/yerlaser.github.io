source /LOCAL/Sources/zsh-autosuggestions/zsh-autosuggestions.zsh
source /LOCAL/Published/configs/shrc.sh

HISTFILE=~/.history
HISTSIZE=1000
PROMPT='%(?..[%?] )%F{magenta}%D{%d-%m %H:%M:%S} | %~ %f'
SAVEHIST=1000
WORDCHARS=${WORDCHARS/\/}
ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=()
ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS=(end-of-line forward-char forward-word)
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

autoload -Uz compinit && compinit

bindkey '\e[5~' backward-word
bindkey '\e[6~' forward-word
bindkey '\e[17~' kill-line
bindkey '\e[19~' backward-kill-line
bindkey '\e[F' end-of-line
bindkey '\e[H' beginning-of-line
bindkey '\eOR' kill-whole-line

setopt hist_ignore_all_dups hist_ignore_space hist_no_store hist_reduce_blanks hist_verify menu_complete no_list_ambiguous share_history
