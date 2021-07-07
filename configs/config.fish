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
bind -k nul accept-autosuggestion
bind -k sdc backward-kill-line
bind \b kill-line
bind \e\[5\;6~ backward-jump
bind \e\[6\;6~ forward-jump
bind \e\[13\;2u backward-word
bind \e\[13\;3u forward-word
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
