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

bind -k btab history-prefix-search-backward
bind \e backward-kill-word
bind \e\[13\;2u end-of-line
bind \e\x20 self-insert
bind \e\[A history-prefix-search-backward
bind \e\[B history-prefix-search-forward
bind \e\[C forward-char
bind \e\[D backward-char

set CDPATH . /LOCAL
set fish_escape_delay_ms 10
set fish_greeting
