alias ... 'cd ../../'
alias dir 'ls -FAhl'
alias dirtime 'ls -FAhlrt'
alias dirsize 'ls -FAhlrS'

if command -v dnf &> /dev/null
  alias dnf 'dnf --cacheonly'
end

if command -v podman &> /dev/null
  alias docker podman
end

if command -v kak &> /dev/null
  alias kakn 'kak -n'
  alias vi kak
end

bind \e complete
bind \e\[A history-prefix-search-backward
bind \e\[B history-prefix-search-forward
bind \e\[C forward-char
bind \e\[D backward-char
bind \t end-of-line
bind -k btab history-prefix-search-backward
bind -k sdc backward-kill-word

set fish_greeting
