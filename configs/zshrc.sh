HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.history
PROMPT='%F{magenta}%* | %~ %#%f '
DIRSTACKSIZE=7
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
autoload -Uz compinit && compinit
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey -v
bindkey -M viins "^[[A" history-beginning-search-backward-end

setopt auto_pushd autocd extended_history extendedglob hist_expire_dups_first hist_ignore_space hist_no_store hist_reduce_blanks hist_verify ksh_arrays nomatch notify share_history

source ~/Public/dotfiles/shrc.sh
