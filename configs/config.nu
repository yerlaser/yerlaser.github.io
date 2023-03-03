let-env config = {
    buffer_editor: $'($env.HOME)/.cargo/bin/hx'
    cd: {
        abbreviations: true
    }
    ls: {
        clickable_links: false
    }
    edit_mode: vi_insert
    keybindings: [
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
            name: edit_command
            modifier: Shift
            keycode: Delete
            mode: [emacs vi_insert vi_normal]
            event: {send: OpenEditor}
        }
        {
            name: show_help
            modifier: None
            keycode: F1
            mode: [emacs vi_insert]
            event: {send: Menu name: help_menu}
        }
    ]
    rm: {
        always_trash: true
    }
    show_banner: false
}
