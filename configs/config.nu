let-env config = {
    rm_always_trash: true
    buffer_editor: hx
    keybindings: [
        {
            name: complete_word
            modifier: alt
            keycode: char_g
            mode: emacs
            event: {send: HistoryHintWordComplete}
        }
        {
            name: complete_line
            modifier: shift
            keycode: enter
            mode: emacs
            event: {send: HistoryHintComplete}
        }
        {
            name: edit_command
            modifier: none
            keycode: esc
            mode: emacs
            event: {send: OpenEditor}
        }
        {
            name: show_history
            modifier: alt
            keycode: char_p
            mode: emacs
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
}
