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

if command -v hx &> /dev/null
  alias vi hx
end

bind \e\[13\;2u complete-and-search
bind \e\[1\;5F history-token-search-backward
bind \e\[1\;5H history-prefix-search-backward
bind \e\[3\;6~ backward-kill-bigword
bind \e\x20 self-insert
bind \t forward-char
bind -k btab complete
bind -k nul backward-jump
bind -k sdc backward-kill-word

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
