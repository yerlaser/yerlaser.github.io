alias '...'='cd ../..'
alias dir='ls -FAhl'
alias dirtime='ls -FAhlrt'
alias dirsize='ls -FAhlrS'

if command -v dnf &> /dev/null; then alias dnf='dnf --cacheonly'; fi
if command -v podman &> /dev/null; then alias docker=podman; fi
if command -v kak &> /dev/null; then alias kakn='kak -n'; alias vi=kak; alias view='kak -ro'; fi

set -o noclobber
