let $config = ($config | upsert edit_mode vi | upsert keybindings [{
    name: complete_word
    modifier: shift
    keycode: enter
    mode: vi_insert
    event: { send: HistoryHintWordComplete }
}])
