def create_my_right_prompt [] {
    let time_segment = ([
        (date now | date format)
    ] | str collect)

    $time_segment
}

let-env PROMPT_COMMAND_RIGHT = {create_my_right_prompt}
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

alias dir = ls -a
alias vi = hx
