source /LOCAL/Sources/zsh-autosuggestions/zsh-autosuggestions.zsh
source /LOCAL/Sources/zsh-history-substring-search/zsh-history-substring-search.zsh

source /LOCAL/Published/configs/shrc.sh

HISTFILE=~/.history
HISTSIZE=1000
PROMPT='%(?..[%?] )%F{magenta}%D{%d-%m %H:%M:%S} | %~ %f'
SAVEHIST=1000
WORDCHARS=${WORDCHARS/\/}
ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=()
ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS=(end-of-line forward-char forward-word)
# ZSH_AUTOSUGGEST_STRATEGY=(completion history)

zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Za-z}'

autoload -Uz compinit && compinit

bindkey '\C-U' backward-kill-line
bindkey '\e^' expand-history
bindkey '\et' transpose-words
bindkey '\e\C-B' vi-backward-blank-word
bindkey '\e\C-F' vi-forward-blank-word
# bindkey '\e[5~' vi-backward-blank-word
# bindkey '\e[6~' vi-forward-blank-word
bindkey '\e[A' history-substring-search-up
bindkey '\e[B' history-substring-search-down
bindkey '\e[F' end-of-line
bindkey '\e[H' beginning-of-line

setopt hist_ignore_all_dups hist_ignore_space hist_no_store hist_reduce_blanks hist_verify menu_complete no_list_ambiguous share_history
