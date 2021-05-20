alias '...'='cd ../..'
alias dir='ls -FAhl'
alias dirtime='ls -FAhlrt'
alias dirsize='ls -FAhlrS'

if command -v dnf &> /dev/null
then
  alias dnf='dnf --cacheonly'
fi

alias igrep='grep -i'
alias ivgrep='grep -iv'
alias vgrep='grep -v'

if command -v kak &> /dev/null
then
  alias kakn='kak -n'
  alias vi=kak
  alias vilka=kak
  alias villa=kak
fi

set -o noclobber
