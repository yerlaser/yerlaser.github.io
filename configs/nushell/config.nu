let-env config = {
    buffer_editor: $'($env.HOME)/.cargo/bin/hx'
    cd: {
        abbreviations: true
    }
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
            keycode: Char_C
            mode: [emacs vi_insert]
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
            modifier: None
            keycode: Esc
            mode: [emacs vi_insert]
            event: {send: OpenEditor}
        }
    ]
    rm: {
        always_trash: true
    }
    show_banner: false
}
