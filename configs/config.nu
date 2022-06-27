let-env config = {
    buffer_editor: $'($env.HOME)/.cargo/bin/hx'
    keybindings: [
        {
            name: complete_word
            modifier: shift
            keycode: right
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
            modifier: shift
            keycode: left
            mode: [emacs vi_insert]
            event: {until: [
                {send: menuup}
                {send: up}
            ]}
        }
        {
            name: search_history
            modifier: control
            keycode: char_s
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
