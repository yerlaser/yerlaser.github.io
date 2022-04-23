let $config = {
    rm_always_trash: true
    edit_mode: vi
    keybindings: [
        {
            name: complete_word
            modifier: shift
            keycode: enter
            mode: vi_insert
            event: { send: HistoryHintWordComplete }
        }
        {
            name: show_history
            modifier: none
            keycode: delete
            mode: [ vi_insert vi_normal emacs]
            event: {
                until: [
                    { send: menu name: history_menu }
                    { send: menupagenext }
                ]
            }
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
