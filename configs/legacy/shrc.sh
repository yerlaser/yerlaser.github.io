function addToPATH {
  case ":$PATH:" in
    *":$1:"*) :;;
    *) PATH="$1:$PATH";;
  esac
}

function s {
  grep -Rli "${*}"
}

function f {
  find . -iname "*${*}*"
}

if [ -e /LOCAL ]; then
  addToPATH "/LOCAL/apps/gcc/bin"
  addToPATH "/LOCAL/apps/git/bin"
fi

if [ -e /LOCAL/apps/gcc ]; then
  export CPLUS_INCLUDE_PATH="/LOCAL/apps/gcc/include/c++/13.0.0"
  export LD_LIBRARY_PATH="/LOCAL/apps/gcc/lib64"
  export LD_RUN_PATH="/LOCAL/apps/gcc/lib64"
  export CC="/LOCAL/apps/gcc/bin/gcc"
  export CXX="/LOCAL/apps/gcc/bin/g++"
elif [ -e /LOCAL/apps/clang ]
  export CPLUS_INCLUDE_PATH="/LOCAL/apps/clang/include/c++/v1"
  export LD_LIBRARY_PATH="/LOCAL/apps/clang/lib64"
  export LD_RUN_PATH="/LOCAL/apps/clang/lib64"
  export CC="/LOCAL/apps/clang/bin/clang"
  export CXX="/LOCAL/apps/clang/bin/clang++"
fi

# export MANPATH=":/LOCAL/apps/jdk/man"
export GIT_PAGER=less

# export PYTHONPYCACHEPREFIX="$HOME/.local/var/python"

alias '..'='cd ..'
alias '...'='cd ../..'
alias dir='ls -FAhl'
alias dirtime='ls -FAhlrt'
alias dirsize='ls -FAhlrS'

if command -v dnf &> /dev/null; then alias dnf='dnf --cacheonly'; fi

alias view='vi -ro'
export EDITOR=vi
export VISUAL=vi

set -o noclobber
