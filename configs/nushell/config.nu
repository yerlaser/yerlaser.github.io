let-env config = {
    buffer_editor: $'($env.HOME)/.cargo/bin/hx'
    cd: {
        abbreviations: true
    }
    cursor_shape: {
        vi_insert: line
        vi_normal: block
    }
    edit_mode: vi
    ls: {
        clickable_links: false
    }
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
            modifier: Control
            keycode: Char_R
            mode: [emacs vi_insert vi_normal]
            event: [
                {edit: CutFromLineStart}
                {send: Menu name: history_menu}
            ]
        }
        {
            name: insert_space
            modifier: Control
            keycode: Space
            mode: [emacs vi_insert]
            event: [
                {send: HistoryHintWordComplete}
                {edit: InsertChar value: ' '}
            ]
        }
        {
            name: edit_command
            modifier: Control
            keycode: Char_P
            mode: vi_normal
            event: {send: OpenEditor}
        }
    ]
    rm: {
        always_trash: true
    }
    show_banner: false
}
