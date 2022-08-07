let-env config = {buffer_editor: $'($env.HOME)/.cargo/bin/hx'}
let-env config = ($env.config | upsert cd_with_abbreviations true)
# let-env config = ($env.config | upsert edit_mode vi_insert)
let-env config = ($env.config | upsert keybindings [
    {
        name: prev_history
        modifier: None
        keycode: Esc
        mode: [emacs vi_insert]
        event: {until: [
            {send: MenuUp}
            {send: Up}
        ]}
    }
    {
        name: search_history
        modifier: Alt
        keycode: Char__
        mode: [emacs vi_insert]
        event: [
            {edit: CutFromLineStart}
            {send: Menu name: history_menu}
        ]
    }
    {
        name: insert_space
        modifier: Alt
        keycode: Char_^
        mode: [emacs vi_insert]
        event: {edit: InsertChar value: ' '}
    }
    {
        name: enter_normal_mode
        modifier: Control
        keycode: Char_X
        mode: [emacs vi_insert]
        event: {send: Esc}
    }
    {
        name: edit_command
        modifier: Control
        keycode: Char_E
        mode: [emacs vi_insert]
        event: {send: OpenEditor}
    }
    {
        name: show_help
        modifier: None
        keycode: F1
        mode: [emacs vi_insert]
        event: {send: Menu name: help_menu}
    }
])
let-env config = ($env.config | upsert rm_always_trash true)
let-env config = ($env.config | upsert show_banner false)
