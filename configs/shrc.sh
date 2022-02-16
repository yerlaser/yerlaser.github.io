# export CPLUS_INCLUDE_PATH="$CPLUS_INCLUDE_PATH:/LOCAL/apps/gcc/include/c++/12.0.0"
# export LD_LIBRARY_PATH="/LOCAL/apps/gcc/lib64:$LD_LIBRARY_PATH"
# export LD_RUN_PATH="/LOCAL/apps/gcc/lib64:$LD_LIBRARY_PATH"
# export CC="/LOCAL/apps/gcc/bin/gcc"
# export CXX="/LOCAL/apps/gcc/bin/g++"

export CPLUS_INCLUDE_PATH="/LOCAL/apps/clang/include/c++/v1"
export LD_LIBRARY_PATH="/LOCAL/apps/clang/lib64"
export LD_RUN_PATH="/LOCAL/apps/clang/lib64"
export CC="/LOCAL/apps/clang/bin/clang"
export CXX="/LOCAL/apps/clang/bin/clang++"

export MANPATH=":/LOCAL/apps/fish/share/man"
export MANPATH=":/LOCAL/apps/gcc/share/man"
export MANPATH=":/LOCAL/apps/git/share/man"
export MANPATH=":/LOCAL/apps/jdk/man"
export MANPATH=":/LOCAL/apps/kak/share/man"
export MANPATH=":/LOCAL/apps/clang/share/man"
export MANPATH=":/LOCAL/apps/node/share/man"
export MANPATH=":/LOCAL/apps/ruby/share/man"

export GIT_PAGER=less
# export GDK_BACKEND=wayland
# export QT_QPA_PLATFORM=wayland
# export SDL_VIDEODRIVER=wayland

# export GOPATH="/BUILD/go"
# export RUSTFLAGS="-L /LOCAL/apps/rust/rust-std-x86_64-unknown-linux-gnu/lib/rustlib/x86_64-unknown-linux-gnu/lib"
export PYTHONPYCACHEPREFIX="$HOME/.local/var/python"

PATH="$PATH:/BUILD/node/bin"
PATH="$PATH:/LOCAL/apps/cmake/bin"
PATH="$PATH:/LOCAL/apps/fish/bin"
# PATH="/LOCAL/apps/gcc/bin:$PATH"
PATH="$PATH:/LOCAL/apps/git/bin"
PATH="$PATH:/LOCAL/apps/jdk/bin"
PATH="$PATH:/LOCAL/apps/kak/bin"
PATH="/LOCAL/apps/clang/bin:$PATH"
PATH="$PATH:/LOCAL/apps/mruby/bin"
PATH="$PATH:/LOCAL/apps/node/bin"
PATH="$PATH:/LOCAL/apps/ruby/bin"

alias '..'='cd ..'
alias '...'='cd ../..'
alias dir='ls -FAhl'
alias dirtime='ls -FAhlrt'
alias dirsize='ls -FAhlrS'
alias igrep='grep -i'

if command -v dnf &> /dev/null; then alias dnf='dnf --cacheonly'; fi
if command -v podman &> /dev/null; then alias docker=podman; fi
if command -v kak &> /dev/null; then
  alias kakn='kak -n'
  alias vi=kak
  alias view='kak -ro'
  export EDITOR=kak
  export VISUAL=kak
fi
if command -v exa &> /dev/null; then
  alias dir='exa --git -Umgahl'
  alias dirsize='exa --git -Umgahls size'
  alias dirtime='exa --git -Umgahls time'
  alias tree='exa --tree'
fi

set -o noclobber
