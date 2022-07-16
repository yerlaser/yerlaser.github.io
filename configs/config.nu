let-env config = {
    buffer_editor: $'($env.HOME)/.cargo/bin/hx'
    cd_with_abbreviations: true
    keybindings: [
        {
            name: complete_word
            modifier: control
            keycode: char_r
            mode: [emacs vi_insert]
            event: {send: HistoryHintWordComplete}
        }
        {
            name: edit_command
            modifier: control
            keycode: char_x
            mode: [emacs vi_insert vi_normal]
            event: {send: OpenEditor}
        }
        {
            name: prev_history
            modifier: control
            keycode: char_e
            mode: [emacs vi_insert]
            event: {until: [
                {send: menudown}
                {send: down}
            ]}
        }
        {
            name: prev_history
            modifier: control
            keycode: char_c
            mode: [emacs vi_insert]
            event: {until: [
                {send: menuup}
                {send: up}
            ]}
        }
        {
            name: search_history
            modifier: control
            keycode: char_a
            mode: [emacs vi_insert vi_normal]
            event: [
                {edit: CutFromLineStart}
                {send: menu name: history_menu}
            ]
        }
        {
            name: show_help
            modifier: none
            keycode: f1
            mode: emacs
            event: {send: menu name: help_menu}
        }
    ]
    rm_always_trash: true
}
