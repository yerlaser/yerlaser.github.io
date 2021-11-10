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

if command -v kak &> /dev/null
  alias kakn 'kak -n'
  alias vi kak
end

bind \e\[C forward-single-char
bind \e\[D backward-char
bind -k npage forward-word
bind -k ppage backward-word

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
