if test "$ITERM_PROFILE" = 'Light'
  set -x THEME 'Light'
  set -x BAT_THEME 'GitHub'
  set -x _ZO_DATA_DIR '/tmp/zoxideLight'
else
  set -x THEME 'Dark'
  set -x BAT_THEME ''
  set -x _ZO_DATA_DIR '/tmp/zoxideDark'
end

alias ... 'cd ../../'
alias vi "hx -c /tmp/config$THEME.toml"
alias year '^cal -N -A 10 -B 1'
alias tree 'broot --conf ~/Published/configs/broot/$THEME.hjson -c :pt'

fish_vi_key_bindings
set fish_cursor_default block
set fish_cursor_insert line blink
set fish_cursor_normal line
set fish_cursor_replace_one underscore
set fish_cursor_visual block
set fish_history "$THEME"
set fish_vi_force_cursor true

bind l forward-single-char
bind \e\[6\;6~ edit_command_buffer
bind -M insert \e\[1\;6C forward-bigword
bind -M insert \e\[1\;6F end-of-line
bind -M insert \e\[1\;6D backward-word
bind -M insert \e\[3\;6~ backward-kill-word repaint-mode
bind -M insert \e\[1\;6H backward-kill-bigword repaint-mode
bind -M insert \e\[1\;6A up-or-search
bind -M insert \e\[5\;6~ down-or-search
bind -M insert \e\[6\;6~ 'fish_commandline_prepend " vi ("' 'fish_commandline_append " )"' 'commandline -f execute'

set -x DELTA_FEATURES '+side-by-side'
set -x EDITOR "hx -c /tmp/config$THEME.toml"
set -x LC_ALL 'en_US.UTF-8'
set -x LC_TYPE 'en_US.UTF-8'
set -x VISUAL "hx -c /tmp/config$THEME.toml"

if test -d /LOCAL/apps/gcc
  set -x CPLUS_INCLUDE_PATH '/LOCAL/apps/gcc/include/c++/13.0.0'
  set -x LD_LIBRARY_PATH '/LOCAL/apps/gcc/lib64'
  set -x LD_RUN_PATH '/LOCAL/apps/gcc/lib64'
  set -x CC '/LOCAL/apps/gcc/bin/gcc'
  set -x CXX '/LOCAL/apps/gcc/bin/g++'
else if test -d /LOCAL/apps/clang
  set -x CPLUS_INCLUDE_PATH '/LOCAL/apps/clang/include/c++/v1'
  set -x LD_LIBRARY_PATH '/LOCAL/apps/clang/lib64'
  set -x LD_RUN_PATH '/LOCAL/apps/clang/lib64'
  set -x CC '/LOCAL/apps/clang/bin/clang'
  set -x CXX '/LOCAL/apps/clang/bin/clang++'
end

if test -e /tmp/configLight.toml; and test /tmp/configLight.toml -ot ~/Published/configs/config.toml
  cp ~/Published/configs/config.toml /tmp/configLight.toml
  sed -i'' -Ee 's/mocha/latte/g' /tmp/configLight.toml
end

if not test -e /tmp/configDark.toml
  ln -s ~/Published/configs/config.toml /tmp/configDark.toml
end

if command -v dnf &> /dev/null
  alias dnf 'dnf --cacheonly'
end

for p in $(cat ~/Published/configs/paths.txt | grep -v '^\s*#' | grep -v '^$')
  fish_add_path -m $p
end

function fish_mode_prompt; end

function f
  switch (count $argv)
  case 0
    fd -tf -tl
  case 1
    fd -tf -tl '' $argv[1]
  case 2
    fd -tf -tl $argv[2] $argv[1]
  case '*'
    if string match -i -- '-x' "$argv[1]"; or string match -i -- '-x' "$argv[2]"
      echo Error: search for filenames or use the command directly
      return 1
    end
    fd -tf -tl $argv[2] $argv[1] $argv[3..]
  end
end

function fish_right_prompt
     printf '%s' (fish_git_prompt)
end

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
source ~/Published/configs/fish/utils.fish

if test "$THEME" = 'Light'
  alias zellij "zellij --config ~/Published/configs/zellij/config.kdl options --theme catppuccin-latte"
  set -x GIT_PAGER 'delta --light'
  if test -f ~/werkstatt/configs/env.fish
    source ~/werkstatt/configs/env.fish
  end
else
  alias zellij "zellij --config ~/Published/configs/zellij/config.kdl options --theme catppuccin-mocha"
  set -x GIT_PAGER 'delta'
end
