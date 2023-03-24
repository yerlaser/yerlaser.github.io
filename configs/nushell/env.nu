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

# Open a shell for each folder
def-env pushd_all () {
  for p in (ls -f | where type == dir | get name) {enter $p}; g 0; g
}

if $env.THEME == 'Light' {
  let-env GIT_PAGER = 'delta --light'
  if ("~/werkstatt/configs/env.nu" | path exists) {
    source "~/werkstatt/configs/env.nu"
  }
} else {
  let-env GIT_PAGER = 'delta'
}

# List files using broot possibly doing additional filter
def tree (
  --all (-a): bool # Include ignored files
  --long (-l): bool # Long format
  --extended (-e): bool # Show extended attributes
  folder: string = '.' # Folder to list
  filter: string = '' # Filter or addtional command
) {
  let args = ['--conf' $'($env.HOME)/Published/configs/broot/($env.THEME).hjson']
  let args = if $all {$args | append '-hi'} else {$args}
  let args = if $long {$args | append '-ds'} else {$args}
  let args = if $extended {$args | append '-gp'} else {$args}
  let cmd = ':pt'
  let args = ($args | append ['-c' $'($filter)($cmd | str join ";")' $folder])
  broot $args
}

let nupaths = ([$env.HOME .config nushell nupaths.txt] | path join)
let-env PATH = if ($nupaths | path exists) {
  $env.PATH | split row (char esep) | prepend (open --raw $nupaths | lines | where {|l| ($l !~ '^\s*#.*') and ($l !~ '^\s*$')} | path expand | filter {|p| path exists}) | uniq
} else {
  $env.PATH
}

# Convert raw file names into ls-like output
def ls_lines (
  filename = '' # Path to file containing file names
) {
  let $inp = $in
  if ($inp | is-empty) {
    if ($filename | is-empty) {return}
    get_lines $filename | par-each {|f| if ($f | path exists) {ls -D $f}}
  } else {
    $inp | lines | par-each {|f| if ($f | path exists) {ls -D $f}}
  }
}

# Filter files containing search string
def grep_contents (
  --case_sensitive (-c): bool # Preserve case
  pattern = '' # Pattern to search
  path = '.' # Search path
) {
  let inp = $in
  let inp = if ($inp | is-empty) {ls $'($path)/**/*' | where type == file} else {$inp | where type == file}
  if ($pattern | is-empty) {
    $inp
  } else {
    let dp = ($pattern | str downcase)
    if ($case_sensitive or $dp != $pattern) {
      $inp | par-each {|f| if not (open -r $f.name | find -r $pattern | is-empty) {ls $f.name}}
    } else {
      $inp | par-each {|f| if not (open -r $f.name | find -i -r $pattern | is-empty) {ls $f.name}}
    }
  }
}

# Open all piped filenames with provided command
def open_all (
  path = '.' # Search path
  command = 'vi' # Command to run (default vi)
) {
  let inp = $in
  let inp = if ($inp | is-empty) {ls $'($path)/**/*'} else {$inp}
  let $inp = ($inp | get name)
  if ($inp | length) > 13 {
    print -e 'Too many files'
    return
  } else {
    if $command == 'vi' {
      vi $inp
    } else {
      ^$command $inp
    }
  }
}

# Find files names matching a pattern
def grep_names (
  --case_sensitive (-c): bool # Preserve case
  pattern = '' # Pattern to search
  path = '.' # Search path
) {
  let inp = $in
  let inp = if ($inp | is-empty) {ls $'($path)/**/*'} else {$inp}
  if ($pattern | is-empty) {
    $inp
  } else {
    let dp = ($pattern | str downcase)
    if ($case_sensitive or $dp != $pattern) {
      $inp | where name =~ $pattern
    } else {
      $inp | par-each {|f| if ($f.name | str downcase) =~ $dp {ls $f.name}}
    }
  }
}

# Get lines from a text file
def get_lines (
  file_name: string # File name
) {
  open -r $file_name | lines
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
use ~/Published/configs/nushell/headings.nu *
use ~/Published/configs/nushell/utils.nu *
