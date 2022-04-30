def create_my_right_prompt [] {
    let time_segment = ([
        (date now | date format)
    ] | str collect)

    $time_segment
}

let-env PROMPT_COMMAND_RIGHT = { create_my_right_prompt }
let-env PROMPT_INDICATOR_VI_INSERT = "〉"
let-env PROMPT_INDICATOR_VI_NORMAL = "〕"
let-env WASMER_DIR = "/home/yerlan/.wasmer"
let-env WASMER_CACHE_DIR = "/home/yerlan/.wasmer/cache"
let-env PATH = if ($'($env.HOME)/.config/nushell/nupaths.txt' | path exists) {
    $env.PATH | split row ':' | prepend (open --raw $'($env.HOME)/.config/nushell/nupaths.txt' | lines) | uniq
} else {
    $env.PATH
}

alias dir = ls -a
alias vi = hx
