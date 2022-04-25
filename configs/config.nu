let-env config = {
    rm_always_trash: true
    edit_mode: vi
    keybindings: [
        {
            name: complete_word
            modifier: alt
            keycode: char_g
            mode: vi_insert
            event: { send: HistoryHintWordComplete }
        }
        {
            name: complete_line
            modifier: shift
            keycode: enter
            mode: vi_insert
            event: { send: HistoryHintComplete }
        }
        {
            name: show_history
            modifier: alt
            keycode: char_p
            mode: [ vi_insert emacs ]
            event: [
                { until: [
                    { send: menu name: history_menu }
                    { send: menupagenext }
                ] }
            ]
        }
        {
            name: show_help
            modifier: none
            keycode: f1
            mode: [ vi_insert vi_normal emacs]
            event: { send: menu name: help_menu }
        }
    ]
}
