alias ... 'cd ../../'
alias dir 'ls -FAhl'
alias dirtime 'ls -FAhlrt'
alias dirsize 'ls -FAhlrS'
if command -v dnf &> /dev/null
  alias dnf 'dnf --cacheonly'
end
alias igrep 'grep -i'
alias ivgrep 'grep -iv'
if command -v kak &> /dev/null
  alias kakn 'kak -n'
  alias vi kak
end
alias vgrep 'grep -v'

# bind -k btab history-prefix-search-backward
bind -k btab forward-word
bind \e\[13\;2u forward-char # s-cr
# bind -M insert -m default \e\[B 'commandline -f repaint'
# set -g fish_key_bindings fish_vi_key_bindings

set fish_greeting
