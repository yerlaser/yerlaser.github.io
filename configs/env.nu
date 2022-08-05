alias jour = vi ~/journal.md
alias l = shells
alias tree = exa -FlT

let-env EDITOR = "hx"
let-env VISUAL = "hx"
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

# Run command on piped list of files or directories
def gather [
  cmd: string # Command to run
] {
  let all_items = ($in | get name)
  run-external $cmd $all_items
}

# Get a listing of a folder and save result in PRES
def-env dir [
  folder_name: string = '.' # Folder name to get listing of
] {
  let-env PRES = ls -a $folder_name
  $env.PRES
}

# Filter piped list for files that contain search pattern
def-env pgrep [
  --after_context (-A): int = 7 # Number of lines to show after each match
  --before_context (-B): int = 3 # Number of lines to show before each match
  --fixed_string (-F) # Treat pattern as fixed string
  search_pattern: string = '' # Pattern to search
] {
  let inp = $in
  let-env PRES = (
    if ($search_pattern | str length) == 0 {
      $inp
    } else {
      let coln = 'found_' + ($search_pattern | str replace -a '[^a-zA-Z0-9]' '_')
      let pres = (
        $inp | where type == file | par-each {
          |it| $it | insert $coln (
            if $fixed_string {
              rg -F -A $after_context -B $before_context -n $search_pattern $it.name | lines
            } else {
              rg -A $after_context -B $before_context -n $search_pattern $it.name | lines
            }
          )
        } | where ($it | get $coln | length) > 0
      )
      if ($pres | length) > 0 {$pres | sort-by name} else {null}
    }
  )
  $env.PRES
}

# Run command on row number (default cd)
def-env row [
  row_number: int # Row number to cd to
  cmd: string = 'cd' # Command to run
] {
  let inp = $in
  let fpa = (if $inp == null {$env.PRES} else {$inp} | get $row_number)
  let cpa = if ($fpa | get type) == file {$fpa | get name | path dirname} else {$fpa | get name}
  cd (if $cmd == 'cd' {$cpa} else {'.'})
  if $cmd != 'cd' {
    run-external $cmd ($fpa | get name)
  }
}
