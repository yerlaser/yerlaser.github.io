if (sys | get host | get name) == 'Darwin' {
  $env.BROWSER = '/Applications/Google Chrome Beta.app/Contents/MacOS/Google Chrome Beta'
}

if 'ITERM_PROFILE' in $env and $env.ITERM_PROFILE == 'Light' {
  $env.THEME = 'Light'
  if ("~/werkstatt/configs/env.nu" | path exists) {
    source "~/werkstatt/configs/env.nu"
  }
}

if 'TERM_PROGRAM' in $env and $env.TERM_PROGRAM == 'WezTerm' {
  $env.THEME = 'Light'
  if ("~/werkstatt/configs/env.nu" | path exists) {
    source "~/werkstatt/configs/env.nu"
  }
}

if $env.THEME == 'Light' {
  $env.BAT_THEME = 'GitHub'
  $env._ZO_DATA_DIR = $'($env.HOME)/.local/share/zoxideLight'
  $env.GIT_PAGER = 'delta --light'
} else {
  $env.BAT_THEME = ''
  $env._ZO_DATA_DIR = $'($env.HOME)/.local/share/zoxideDark'
  $env.GIT_PAGER = 'delta'
}

alias cut = split column -c
alias ng = find
alias mc = broot --conf $'($env.HOME)/Published/configs/broot/($env.THEME).hjson' -c ':start_end_panel;:panel_left_no_open'
alias sed = str replace
alias tree = broot --conf $'($env.HOME)/Published/configs/broot/($env.THEME).hjson' -c ':pt'
alias year = ^cal -N -A 10 -B 1
$env.DELTA_FEATURES = '+side-by-side'
$env.EDITOR = $'hx -c /tmp/config($env.THEME).toml'
$env.LC_ALL = 'en_US.UTF-8'
$env.LC_TYPE = 'en_US.UTF-8'
$env.VISUAL = $'hx -c /tmp/config($env.THEME).toml'

if ('/LOCAL/apps/gcc' | path exists) {
  $env.CPLUS_INCLUDE_PATH = '/LOCAL/apps/gcc/include/c++/13.0.0'
  $env.LD_LIBRARY_PATH = '/LOCAL/apps/gcc/lib64'
  $env.LD_RUN_PATH = '/LOCAL/apps/gcc/lib64'
  $env.CC = '/LOCAL/apps/gcc/bin/gcc'
  $env.CXX = '/LOCAL/apps/gcc/bin/g++'
} else if ('/LOCAL/apps/clang' | path exists) {
  $env.CPLUS_INCLUDE_PATH = '/LOCAL/apps/clang/include/c++/v1'
  $env.LD_LIBRARY_PATH = '/LOCAL/apps/clang/lib64'
  $env.LD_RUN_PATH = '/LOCAL/apps/clang/lib64'
  $env.CC = '/LOCAL/apps/clang/bin/clang'
  $env.CXX = '/LOCAL/apps/clang/bin/clang++'
}

let nupaths = ([$env.HOME Published configs paths.txt] | path join)
$env.PATH = if ($nupaths | path exists) {
  $env.PATH | split row (char esep) | prepend (open --raw $nupaths | lines | where {|l| ($l !~ '^\s*#.*') and ($l !~ '^\s*$')} | path expand | filter {|p| path exists}) | uniq
} else {
  $env.PATH
}

def create_right_prompt () {
  do -i {git branch --show-current}
}
$env.PROMPT_COMMAND_RIGHT = {|| create_right_prompt}
$env.PROMPT_INDICATOR_VI_NORMAL = "〕"
$env.PROMPT_INDICATOR_VI_INSERT = "〉"

# Create helix config files with light and dark themes
def helix_configs () {
  if (
    ('/tmp/configDark.toml' | path exists) and
    ((ls /tmp/configDark.toml | get modified) < (ls ~/Published/configs/config.toml | get modified))
  ) {
    rm /tmp/configDark.toml
  }
  if not ('/tmp/configDark.toml' | path exists) {
    open ~/Published/configs/config.toml | update theme catppuccin_mocha | save /tmp/configDark.toml
  }
  if not ('/tmp/configLight.toml' | path exists) {
    ln -s ~/Published/configs/config.toml /tmp/configLight.toml
  }
}

helix_configs
use ~/Published/configs/nushell/files.nu *
use ~/Published/configs/nushell/headings.nu *
use ~/Published/configs/nushell/utils.nu *
