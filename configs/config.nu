let-env config = {buffer_editor: $'($env.HOME)/.cargo/bin/hx'}
let-env config = ($env.config | upsert cd {abbreviations: true})
let-env config = ($env.config | upsert edit_mode vi_insert)
let-env config = ($env.config | upsert keybindings [
    {
        name: completion_menu
        modifier: None
        keycode: Tab
        mode: [emacs vi_insert]
        event: {until: [
            {send: Menu name: completion_menu}
            {send: MenuNext}
        ]}
    }
    {
        name: search_history
        modifier: Shift
        keycode: Down
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
let-env config = ($env.config | upsert rm {always_trash: true})
let-env config = ($env.config | upsert show_banner false)
