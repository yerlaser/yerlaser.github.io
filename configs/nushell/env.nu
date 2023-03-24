alias mc = broot --conf $'($env.HOME)/Published/configs/broot/($env.THEME).hjson' -c ':start_end_panel;:panel_left_no_open'
alias vi = hx -c $'/tmp/config($env.THEME).toml'
alias year = ^cal -N -A 10 -B 1
let-env DELTA_FEATURES = '+side-by-side'
let-env EDITOR = $'hx -c /tmp/config($env.THEME).toml'
let-env LC_ALL = 'en_US.UTF-8'
let-env LC_TYPE = 'en_US.UTF-8'
let-env VISUAL = $'hx -c /tmp/config($env.THEME).toml'
let-env WASMER_DIR = $'($env.HOME)/.wasmer'
let-env WASMER_CACHE_DIR = $'($env.WASMER_DIR)/cache'

if $env.THEME == 'Light' {
  let-env GIT_PAGER = 'delta --light'
  if ("~/werkstatt/configs/env.nu" | path exists) {
    source "~/werkstatt/configs/env.nu"
  }
} else {
  let-env GIT_PAGER = 'delta'
}

let nupaths = ([$env.HOME .config nushell nupaths.txt] | path join)
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
    rm -p /tmp/configLight.toml
  }

  if (
    ('/tmp/configDark.toml' | path exists) and
    ((ls /tmp/configDark.toml | get modified) < (ls ~/Published/configs/config.toml | get modified))
  ) {
    rm -p /tmp/configDark.toml
  }

  if (not ('/tmp/configLight.toml' | path exists)) {
    echo "theme = 'catppuccin_latte'\n" | save /tmp/configLight.toml
    open --raw ~/Published/configs/config.toml | save --append /tmp/configLight.toml
  }

  if (not ('/tmp/configDark.toml' | path exists)) {
    echo "theme = 'catppuccin_mocha'\n" | save /tmp/configDark.toml
    open --raw ~/Published/configs/config.toml | save --append /tmp/configDark.toml
  }
}

helix_configs
use ~/Published/configs/nushell/files.nu *
use ~/Published/configs/nushell/headings.nu *
use ~/Published/configs/nushell/utils.nu *
