alias ... 'cd ../../'
alias f 'fd -tf -tl'
alias vi "hx -c /tmp/config$THEME.toml"
alias year '^cal -N -A 10 -B 1'

fish_vi_key_bindings
set fish_cursor_default block
set fish_cursor_insert line blink
set fish_cursor_normal line
set fish_cursor_replace_one underscore
set fish_cursor_visual block
set fish_vi_force_cursor true

bind l forward-single-char
bind \e\[F edit_command_buffer

set DELTA_FEATURES '+side-by-side'
set EDITOR "hx -c /tmp/config$THEME.toml"
set LC_ALL 'en_US.UTF-8'
set LC_TYPE 'en_US.UTF-8'
set VISUAL "hx -c /tmp/config$THEME.toml"

if test $THEME = 'Light'
  set GIT_PAGER 'delta --light'
else
  set GIT_PAGER 'delta'
end

if test -d '/LOCAL/apps/gcc'
  set CPLUS_INCLUDE_PATH '/LOCAL/apps/gcc/include/c++/13.0.0'
  set LD_LIBRARY_PATH '/LOCAL/apps/gcc/lib64'
  set LD_RUN_PATH '/LOCAL/apps/gcc/lib64'
  set CC '/LOCAL/apps/gcc/bin/gcc'
  set CXX '/LOCAL/apps/gcc/bin/g++'
else if test -d '/LOCAL/apps/clang'
  set CPLUS_INCLUDE_PATH '/LOCAL/apps/clang/include/c++/v1'
  set LD_LIBRARY_PATH '/LOCAL/apps/clang/lib64'
  set LD_RUN_PATH '/LOCAL/apps/clang/lib64'
  set CC '/LOCAL/apps/clang/bin/clang'
  set CXX '/LOCAL/apps/clang/bin/clang++'
end

if test -e /tmp/configLight.toml; and test /tmp/configLight.toml -ot ~/Published/configs/config.toml
  cp ~/Published/configs/config.toml /tmp/configLight.toml
  sed -i'' -Ee 's/mocha/latte/g' /tmp/configLight.toml
end

if not test -e '/tmp/configDark.toml'
  ln -s ~/Published/configs/config.toml /tmp/configDark.toml
end

if command -v dnf &> /dev/null
  alias dnf 'dnf --cacheonly'
end

for p in $(cat ~/Published/configs/paths.txt | grep -v '^\s*#' | grep -v '^$')
  fish_add_path -m $p
end

if test -f ~/werkstatt/configs/env.fish
  source ~/werkstatt/configs/env.fish
end

function fish_mode_prompt; end

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
