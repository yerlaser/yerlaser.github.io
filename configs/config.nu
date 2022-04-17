let $config = ($config | upsert edit_mode vi | upsert keybindings [{
    name: comple_word
    modifier: shift
    keycode: enter
    mode: vi_insert
    event: { send: HistoryHintWordComplete }
}])
