let-env config = {
    buffer_editor: hx
    edit_mode: vi
    keybindings: [
        {
            name: complete_word
            modifier: alt
            keycode: char_g
            mode: [emacs vi_insert]
            event: {send: HistoryHintWordComplete}
        }
        {
            name: complete_line
            modifier: shift
            keycode: enter
            mode: [emacs vi_insert]
            event: {send: HistoryHintComplete}
        }
        {
            name: edit_command
            modifier: none
            keycode: char_o
            mode: vi_normal
            event: {send: OpenEditor}
        }
        {
            name: show_history
            modifier: alt
            keycode: char_g
            mode: vi_normal
            event: [
                {until: [
                    {send: menu name: history_menu}
                    {send: menupagenext}
                ]}
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
