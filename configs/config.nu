let-env config = {
    buffer_editor: $'($env.HOME)/.cargo/bin/hx'
    cd_with_abbreviations: true
    keybindings: [
        {
            name: complete_word
            modifier: Control
            keycode: Char_A
            mode: [emacs vi_insert]
            event: {until: [
                {send: HistoryHintWordComplete}
                {edit: MoveWordRight}
            ]}
        }
        {
            name: prev_history
            modifier: Control
            keycode: Char_C
            mode: [emacs vi_insert]
            event: {until: [
                {send: MenuUp}
                {send: Up}
            ]}
        }
        {
            name: prev_history
            modifier: Control
            keycode: Char_E
            mode: [emacs vi_insert]
            event: {until: [
                {send: MenuDown}
                {send: Down}
            ]}
        }
        {
            name: search_history
            modifier: Control
            keycode: Char_R
            mode: [emacs vi_insert vi_normal]
            event: [
                {edit: CutFromLineStart}
                {send: Menu name: history_menu}
            ]
        }
        {
            name: edit_command
            modifier: Control
            keycode: Char_X
            mode: [emacs vi_insert vi_normal]
            event: {send: OpenEditor}
        }
        {
            name: cancel_command
            modifier: None
            keycode: Esc
            mode: [emacs vi_insert vi_normal]
            event: {until: [
                {edit: CutCurrentLine}
                {send: Esc}
                {send: CtrlC}
            ]}
        }
        {
            name: show_help
            modifier: None
            keycode: F1
            mode: emacs
            event: {send: Menu name: help_menu}
        }
        {
            name: disable_right_complete
            modifier: None
            keycode: Right
            mode: [emacs vi_insert]
            event: {until: [
                {send: MenuRight}
                {send: Right}
            ]}
        }
    ]
    rm_always_trash: true
}

source ~/.cache/starship/init.nu
