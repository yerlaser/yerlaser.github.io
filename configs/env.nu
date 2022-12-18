alias tree = exa -FlT

let-env EDITOR = 'vi'
let-env VISUAL = 'vi'
let-env WASMER_DIR = $"($env.HOME)/.wasmer"
let-env WASMER_CACHE_DIR = $"($env.WASMER_DIR)/cache"

let nupaths = ([$env.HOME .config nushell nupaths.txt] | path join)
let-env PATH = if ($nupaths | path exists) {
  $env.PATH | split row (char esep) | prepend (open --raw $nupaths | lines) | uniq
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

# Recursively find files or folders whose name contains pattern
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

# Dir files
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

# Filter piped list for files that contain search pattern
# def-env pgrep [
#   --after_context (-A): int = 7 # Number of lines to show after each match (default 7)
#   --before_context (-B): int = 3 # Number of lines to show before each match (default 3)
#   --fixed_string (-F) # Treat pattern as fixed string
#   search_pattern: string # Pattern to search
# ] {
#   let input = $in
#   let input = (if $input == null {ls -a **/*} else {$input})
#   let coln = 'found_' + ($search_pattern | str replace -a '[^a-zA-Z0-9]' '_')
#   let pres = (
#     $input | where type == file | par-each {
#       |it| $it | insert $coln (
#         if $fixed_string {
#           rg -F -A $after_context -B $before_context -n $search_pattern $it.name | lines
#         } else {
#           rg -A $after_context -B $before_context -n $search_pattern $it.name | lines
#         }
#       )
#     } | where ($it | get $coln | length) > 0
#   )
#   let-env LAST_CMD_RESULT = (
#     if ($pres | length) > 0 {$pres | sort-by name} else {null}
#   )
#   $env.LAST_CMD_RESULT
# }
