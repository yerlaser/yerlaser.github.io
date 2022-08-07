alias jour = vi ~/journal.md
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

# Filter piped list for files that contain search pattern
def-env pgrep [
  --after_context (-A): int = 7 # Number of lines to show after each match (default 7)
  --before_context (-B): int = 3 # Number of lines to show before each match (default 3)
  --fixed_string (-F) # Treat pattern as fixed string
  search_pattern: string # Pattern to search
] {
  let input = $in
  let input = (if $input == null {ls -a **/*} else {$input})
  let coln = 'found_' + ($search_pattern | str replace -a '[^a-zA-Z0-9]' '_')
  let pres = (
    $input | where type == file | par-each {
      |it| $it | insert $coln (
        if $fixed_string {
          rg -F -A $after_context -B $before_context -n $search_pattern $it.name | lines
        } else {
          rg -A $after_context -B $before_context -n $search_pattern $it.name | lines
        }
      )
    } | where ($it | get $coln | length) > 0
  )
  let-env PRES = (
    if ($pres | length) > 0 {$pres | sort-by name} else {null}
  )
  $env.PRES
}

# Get a listing of a folder and save result in PRES
def-env dir [
  folder_name: string = '.' # Folder name to get listing of (default current folder)
] {
  let input = $in
  let-env PRES = (
    if $input == null {
      ls -a $folder_name
    } else {
      $input
    }
  )
  $env.PRES
}

# Get last command result
def l [] {
  $env.PRES
}

# Find files or folders where name contains pattern
def-env f [
  search_pattern: string # Search pattern
  --regex (-r) # Treat pattern as regex
] {
  let input = $in
  let input = (
    if $input == null {
      ls -a **/*
    } else {
      $input
    }
  )
  let-env PRES = (
    if $regex {
      $input | where name =~ $search_pattern
    } else {
      $input | find -i $search_pattern
    }
  )
  $env.PRES
}

# Run command on row number
def r [
  cmd: string # Command to run
  row_number: int # Row number
] {
  let input = $in
  let fpath = (if $input == null {$env.PRES} else {$input} | get $row_number)
  let dpath = if ($fpath | get type) == file {$fpath | get name | path dirname} else {$fpath | get name}
  cd (if $cmd == 'cd' {$dpath} else {'.'})
  if $cmd != 'cd' {
    run-external $cmd ($fpath | get name)
  }
}
