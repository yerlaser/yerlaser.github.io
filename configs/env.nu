alias docker = podman

let-env EDITOR = 'vi'
let-env VISUAL = 'vi'
let-env WASMER_DIR = $"($env.HOME)/.wasmer"
let-env WASMER_CACHE_DIR = $"($env.WASMER_DIR)/cache"
let-env DELTA_FEATURES = '+side-by-side'
# let-env CPLUS_INCLUDE_PATH = "/LOCAL/apps/gcc/include/c++/13.0.0"
# let-env LD_LIBRARY_PATH = "/LOCAL/apps/gcc/lib64"
# let-env LD_RUN_PATH = "/LOCAL/apps/gcc/lib64"
# let-env CC = "/LOCAL/apps/gcc/bin/gcc"
# let-env CXX = "/LOCAL/apps/gcc/bin/g++"

let nupaths = ([$env.HOME .config nushell nupaths.txt] | path join)
let-env PATH = if ($nupaths | path exists) {
  $env.PATH | split row (char esep) | prepend (open --raw $nupaths | lines | where {|l| ($l !~ '^\s*#.*') and ($l !~ '^\s*$')} | path expand | filter {|p| path exists}) | uniq
} else {
  $env.PATH
}

def create_right_prompt [] {
  do -i {git branch --show-current}
}
let-env PROMPT_COMMAND_RIGHT = {create_right_prompt}

# Get last recursive command result
def r [] {
  $env.LAST_CMD_RESULT
}

# Recursively search for pattern in file names
def-env rfind [
  --fixed_string (-f) = true # Treat pattern as fixed string (default)
  search_pattern: string # Search pattern
] {
  let-env LAST_CMD_RESULT = (
    if $fixed_string {fd -Fi $search_pattern} else {fd $search_pattern} | lines | wrap 'name'
  )
  $env.LAST_CMD_RESULT
}

# Recursively grep files for pattern
def-env rgrep [
  --fixed_string (-f) = true # Treat pattern as fixed string (default)
  search_pattern: string # Search pattern
] {
  let-env LAST_CMD_RESULT = (
    if $fixed_string {rg -Fil $search_pattern} else {fd -l $search_pattern} | lines | wrap 'name'
  )
  $env.LAST_CMD_RESULT
}

# Get directory listing
def-env dir [
  search_pattern = '.' # Search pattern
] {
  ls -a $search_pattern
  let-env LAST_CMD_RESULT = (
    ls -a $search_pattern
  )
}

# Run command on row number
def rcmd [
  cmd: string # Command to run
  row_number: int = 100000 # Row number (default last)
] {
  let input = $in
  let input = (if $input == null {$env.LAST_CMD_RESULT} else {$input})
  let ilast = ($input | length) - 1
  let ilast = (if $row_number > $ilast {$ilast} else {$row_number})
  let fpath = ($input | select $ilast | get name | get 0)
  run-external $cmd $fpath
}

# Change dir to the item on the specified row number
def-env rcd [
  row_number: int = 100000 # Row number (default last)
] {
  let input = $in
  let input = (if $input == null {$env.LAST_CMD_RESULT} else {$input})
  let ilast = ($input | length) - 1
  let ilast = (if $row_number > $ilast {$ilast} else {$row_number})
  let fpath = ($input | select $ilast | get name | get 0)
  let dpath = (if ($fpath | path type) == 'file' {$fpath | path dirname} else {$fpath})
  cd $dpath
}

# Open file on the specified row number with vi
def rvi [
  row_number: int = 100000 # Row number (default last)
] {
  let input = $in
  let input = (if $input == null {$env.LAST_CMD_RESULT} else {$input})
  let ilast = ($input | length) - 1
  let ilast = (if $row_number > $ilast {$ilast} else {$row_number})
  let fpath = ($input | select $ilast | get name | get 0)
  vi $fpath
}

# Open file on the specified row number with cat
def rcat [
  row_number: int = 100000 # Row number (default last)
] {
  let input = $in
  let input = (if $input == null {$env.LAST_CMD_RESULT} else {$input})
  let ilast = ($input | length) - 1
  let ilast = (if $row_number > $ilast {$ilast} else {$row_number})
  let fpath = ($input | select $ilast | get name | get 0)
  cat $fpath
}
