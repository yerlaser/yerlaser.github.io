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
bind -k nul kill-whole-line
bind -k sdc backward-kill-word
bind \b beginning-of-line
bind \f end-of-line
bind \e\[13\;2u complete-and-search
bind \e\x20 self-insert

function fish_prompt
  if test "$status" -ne 0
    set_color red
    echo -n \[$status\]\ 
  end
  set_color purple
  echo -n (date '+%d-%m %H:%M:%S') \| (prompt_pwd)\ 
  set_color normal
end

set CDPATH . /LOCAL
set fish_greeting
