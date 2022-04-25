function addToPATH {
  case ":$PATH:" in
    *":$1:"*) :;;
    *) PATH="$1:$PATH";;
  esac
}

addToPATH "/LOCAL/apps/clang/bin"
addToPATH "/LOCAL/apps/ruby/bin"

# export CPLUS_INCLUDE_PATH="/LOCAL/apps/gcc/include/c++/12.0.0"
# export LD_LIBRARY_PATH="/LOCAL/apps/gcc/lib64"
# export LD_RUN_PATH="/LOCAL/apps/gcc/lib64"
# export CC="/LOCAL/apps/gcc/bin/gcc"
# export CXX="/LOCAL/apps/gcc/bin/g++"

# export CPLUS_INCLUDE_PATH="/LOCAL/apps/clang/include/c++/v1"
# export LD_LIBRARY_PATH="/LOCAL/apps/clang/lib64"
# export LD_RUN_PATH="/LOCAL/apps/clang/lib64"
# export CC="/LOCAL/apps/clang/bin/clang"
# export CXX="/LOCAL/apps/clang/bin/clang++"

# export MANPATH=":/LOCAL/apps/jdk/man"
export GIT_PAGER=less

# export PYTHONPYCACHEPREFIX="$HOME/.local/var/python"

alias '..'='cd ..'
alias '...'='cd ../..'
alias dir='ls -FAhl'
alias dirtime='ls -FAhlrt'
alias dirsize='ls -FAhlrS'

if command -v dnf &> /dev/null; then alias dnf='dnf --cacheonly'; fi
if command -v podman &> /dev/null; then alias docker=podman; fi
if command -v hx &> /dev/null; then
  alias vi=hx
  export EDITOR=hx
  export VISUAL=hx
fi

set -o noclobber
