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
    ]
}
