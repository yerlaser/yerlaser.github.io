let-env config = {
    buffer_editor: $'($env.HOME)/.cargo/bin/hx'
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
            modifier: control
            keycode: char_x
            mode: [emacs vi_insert vi_normal]
            event: {send: OpenEditor}
        }
        {
            name: prev_history
            modifier: alt
            keycode: char__
            mode: [emacs vi_insert vi_normal]
            event: {until: [
                {send: menuup}
                {send: up}
            ]}
        }
        {
            name: search_history
            modifier: alt
            keycode: char_p
            mode: [emacs vi_insert vi_normal]
            event: {until: [
                {send: menu name: history_menu}
                {send: menupagenext}
            ]}
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
