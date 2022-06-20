alias ... 'cd ../../'
alias dir 'ls -FAhl'
alias dirtime 'ls -FAhlrt'
alias dirsize 'ls -FAhlrS'

bind -M insert -k sright up-or-search
bind -M insert -k sleft down-or-search

if command -v dnf &> /dev/null
  alias dnf 'dnf --cacheonly'
end

if command -v podman &> /dev/null
  alias docker podman
end

export EDITOR vi
export VISUAL vi

# set CDPATH . /LOCAL
fish_add_path -m ~/.local/bin

function fish_prompt
  if test "$status" -ne 0
    set_color red
    echo -n \[$status\]\
  end
  set_color purple
  echo -n (date '+%d-%m %H:%M:%S') \| (prompt_pwd)\
  set_color normal
end

set fish_greeting
