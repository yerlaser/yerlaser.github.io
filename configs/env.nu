alias dir = exa -Fal
alias l = shells
alias tree = exa -FlT

let-env EDITOR = "hx"
let-env PROMPT_COMMAND_RIGHT = {create_my_right_prompt}
let-env PROMPT_INDICATOR_VI_INSERT = "〉"
let-env PROMPT_INDICATOR_VI_NORMAL = "〕"
let-env VISUAL = "hx"
let-env WASMER_DIR = $"($env.HOME)/.wasmer"
let-env WASMER_CACHE_DIR = $"($env.WASMER_DIR)/cache"

let nupaths = ([$env.HOME .config nushell nupaths.txt] | path join)
let-env PATH = if ($nupaths | path exists) {
    $env.PATH | split row (char esep) | prepend (open --raw $nupaths | lines) | uniq
} else {
    $env.PATH
}

def create_my_right_prompt [] {
    let time_segment = ([
        (date now | date format)
    ] | str collect)
    $time_segment
}

# Run command on piped list of files or directories
def gather [
  cmd: string # Command to run
] {
  let all_items = ($in | get name)
  run-external $cmd $all_items
}

# Filter piped list for files that contain search pattern
def pgrep [
  --after_context (-A): int # Number of lines to show after each match
  --before_context (-B): int # Number of lines to show before each match
  --fixed_string (-F) # Treat pattern as fixed string
  search_pattern: string # Pattern to search
] {
  let inp = $in
  let acon = (if $after_context == null {0} else {$after_context})
  let bcon = (if $before_context == null {0} else {$before_context})
  let coln = 'found_' + ($search_pattern | str replace -a '[^a-zA-Z0-9]' '_')
  $inp | where type == file | par-each {
    |it| $it | insert $coln (
      if $fixed_string {
        rg -F -A $acon -B $bcon -n $search_pattern $it.name | lines
      } else {
        rg -A $acon -B $bcon -n $search_pattern $it.name | lines
      }
    )
  } | where ($it | get $coln | length) > 0 | sort-by name
}
