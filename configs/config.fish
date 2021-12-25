fish_add_path -m ~/.local/bin

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
  alias view 'kak -ro'
  export EDITOR kak
  export VISUAL kak
end

if command -v exa &> /dev/null
  alias dir 'exa --git -Umgahl'
  alias dirsize 'exa --git -Umgahls size'
  alias dirtime 'exa --git -Umgahls time'
  alias tree 'exa --tree'
end

# bind -k npage forward-bigword
# bind -k ppage backward-bigword
bind \cR history-token-search-forward
bind \e^ expand-abbr
bind \et transpose-words
bind \e\[C forward-single-char

function fish_prompt
  if test "$status" -ne 0
    set_color red
    echo -n \[$status\]\ 
  end
  set_color purple
  echo -n (date '+%d-%m %H:%M:%S') \| (prompt_pwd)\ 
  set_color normal
end

# set CDPATH . /LOCAL
set fish_greeting

if command -v starship &> /dev/null
  starship init fish | source
end
