alias ... 'cd ../../'
alias dir 'ls -FAhl'
alias dirtime 'ls -FAhlrt'
alias dirsize 'ls -FAhlrS'

if command -v dnf &> /dev/null
  alias dnf 'dnf --cacheonly'
end

alias eg 'grep -Ee'
alias igrep 'grep -i'
alias ivgrep 'grep -iv'

if command -v kak &> /dev/null
  alias kakn 'kak -n'
  alias vi kak
end

alias vgrep 'grep -v'

bind \e complete
bind \e\[A history-prefix-search-backward
bind \e\[B history-prefix-search-forward
bind \e\[C forward-char
bind \e\[D backward-char
bind \t end-of-line
bind -k btab history-prefix-search-backward
bind -k sdc backward-kill-word

set fish_greeting
