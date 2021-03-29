HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.history
PROMPT='%F{magenta}%* | %~ %#%f '
DIRSTACKSIZE=7
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
autoload -Uz compinit && compinit

setopt auto_pushd autocd extended_history extendedglob hist_expire_dups_first hist_ignore_space hist_no_store hist_reduce_blanks hist_verify ksh_arrays nomatch notify share_history

# bindkey -M viins "^[[A" history-beginning-search-backward
bindkey "^[[Z" history-beginning-search-backward

# Fix Keypad
# bindkey -M viins '"\e[Z"' '"$(sk -m --bind 'tab:down,btab:up,alt-enter:toggle')\r"'
bindkey -s "^[Op" "0"
bindkey -s "^[Ol" "."
bindkey -s "^[OM" "^M"
bindkey -s "^[Oq" "1"
bindkey -s "^[Or" "2"
bindkey -s "^[Os" "3"
bindkey -s "^[Ot" "4"
bindkey -s "^[Ou" "5"
bindkey -s "^[Ov" "6"
bindkey -s "^[Ow" "7"
bindkey -s "^[Ox" "8"
bindkey -s "^[Oy" "9"
bindkey -s "^[Ok" "+"
bindkey -s "^[Om" "-"
bindkey -s "^[Oj" "*"
bindkey -s "^[Oo" "/"
# bindkey -v

source ~/Public/dotfiles/shrc.sh
