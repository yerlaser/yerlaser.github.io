if 'ITERM_PROFILE' in $env and $env.ITERM_PROFILE == 'Light' {
  let-env THEME = 'Light'
}

if 'TERM_PROGRAM' in $env and $env.TERM_PROGRAM == 'WezTerm' {
  let-env THEME = 'Dark'
}

if $env.THEME == 'Light' {
  let-env BAT_THEME = 'GitHub'
  let-env _ZO_DATA_DIR = $'($env.HOME)/.local/share/zoxideLight'
} else {
  let-env BAT_THEME = ''
  let-env _ZO_DATA_DIR = $'($env.HOME)/.local/share/zoxideDark'
}

alias cut = split column -c
alias ng = find
alias mc = broot --conf $'($env.HOME)/Published/configs/broot/($env.THEME).hjson' -c ':start_end_panel;:panel_left_no_open'
alias sed = str replace
alias tree = broot --conf $'($env.HOME)/Published/configs/broot/($env.THEME).hjson' -c ':pt'
alias vi = hx -c $'/tmp/config($env.THEME).toml'
alias year = ^cal -N -A 10 -B 1
let-env DELTA_FEATURES = '+side-by-side'
let-env EDITOR = $'hx -c /tmp/config($env.THEME).toml'
let-env LC_ALL = 'en_US.UTF-8'
let-env LC_TYPE = 'en_US.UTF-8'
let-env VISUAL = $'hx -c /tmp/config($env.THEME).toml'

if ('/LOCAL/apps/gcc' | path exists) {
  let-env CPLUS_INCLUDE_PATH = '/LOCAL/apps/gcc/include/c++/13.0.0'
  let-env LD_LIBRARY_PATH = '/LOCAL/apps/gcc/lib64'
  let-env LD_RUN_PATH = '/LOCAL/apps/gcc/lib64'
  let-env CC = '/LOCAL/apps/gcc/bin/gcc'
  let-env CXX = '/LOCAL/apps/gcc/bin/g++'
} else if ('/LOCAL/apps/clang' | path exists) {
  let-env CPLUS_INCLUDE_PATH = '/LOCAL/apps/clang/include/c++/v1'
  let-env LD_LIBRARY_PATH = '/LOCAL/apps/clang/lib64'
  let-env LD_RUN_PATH = '/LOCAL/apps/clang/lib64'
  let-env CC = '/LOCAL/apps/clang/bin/clang'
  let-env CXX = '/LOCAL/apps/clang/bin/clang++'
}

if $env.THEME == 'Light' {
  let-env GIT_PAGER = 'delta --light'
  if ("~/werkstatt/configs/env.nu" | path exists) {
    source "~/werkstatt/configs/env.nu"
  }
} else {
  let-env GIT_PAGER = 'delta'
}

let nupaths = ([$env.HOME Published configs paths.txt] | path join)
let-env PATH = if ($nupaths | path exists) {
  $env.PATH | split row (char esep) | prepend (open --raw $nupaths | lines | where {|l| ($l !~ '^\s*#.*') and ($l !~ '^\s*$')} | path expand | filter {|p| path exists}) | uniq
} else {
  $env.PATH
}

def create_right_prompt () {
  do -i {git branch --show-current}
}
let-env PROMPT_COMMAND_RIGHT = {|| create_right_prompt}

# Create helix config files with light and dark themes
def helix_configs () {
  if (
    ('/tmp/configLight.toml' | path exists) and
    ((ls /tmp/configLight.toml | get modified) < (ls ~/Published/configs/config.toml | get modified))
  ) {
    rm /tmp/configLight.toml
  }
  if not ('/tmp/configLight.toml' | path exists) {
    open ~/Published/configs/config.toml | update theme catppuccin_latte | save /tmp/configLight.toml
  }
  if not ('/tmp/configDark.toml' | path exists) {
    ln -s ~/Published/configs/config.toml /tmp/configDark.toml
  }
}

helix_configs
use ~/Published/configs/nushell/files.nu *
use ~/Published/configs/nushell/headings.nu *
use ~/Published/configs/nushell/utils.nu *
