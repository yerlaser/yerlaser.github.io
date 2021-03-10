alias dir='ls -FAhl'
alias dirtime='ls -FAhlrt'
alias dirsize='ls -FAhlrS'
if command -v dnf &> /dev/null
then
  alias dnf='dnf --cacheonly'
fi
alias igrep='grep -i'
alias ivgrep='grep -iv'
if command -v kak &> /dev/null
then
  alias kakn='kak -n'
  alias vi=kak
fi
alias vgrep='grep -v'

set -o noclobber
