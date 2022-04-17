def create_my_right_prompt [] {
    let time_segment = ([
        (date now | date format)
    ] | str collect)

    $time_segment
}

let-env PROMPT_COMMAND_RIGHT = { create_my_right_prompt }
let-env PROMPT_INDICATOR_VI_INSERT = "〉"
let-env PROMPT_INDICATOR_VI_NORMAL = "〕"

alias dir = ls -a
alias ncal = ^cal
alias vi = hx
