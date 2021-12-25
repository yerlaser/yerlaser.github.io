alias '..'='cd ..'
alias '...'='cd ../..'
alias dir='ls -FAhl'
alias dirtime='ls -FAhlrt'
alias dirsize='ls -FAhlrS'
alias igrep='grep -i'

if command -v dnf &> /dev/null; then alias dnf='dnf --cacheonly'; fi
if command -v podman &> /dev/null; then alias docker=podman; fi
if command -v kak &> /dev/null; then
  alias kakn='kak -n'
  alias vi=kak
  alias view='kak -ro'
  export EDITOR=kak
  export VISUAL=kak
fi
if command -v exa &> /dev/null; then
  alias dir='exa --git -Umgahl'
  alias dirsize='exa --git -Umgahls size'
  alias dirtime='exa --git -Umgahls time'
  alias tree='exa --tree'
fi

set -o noclobber
