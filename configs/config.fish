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
  # alias vi kak
end
alias vi amp
alias vgrep 'grep -v'

bind -M insert -k btab forward-word
bind -M insert \e\[13\;2u forward-char # s-cr
# bind -M insert -m default ää 'commandline -f repaint'
set -g fish_key_bindings fish_vi_key_bindings

set fish_greeting
