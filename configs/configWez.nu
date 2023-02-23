let light_theme = {
    # color for nushell primitives
    separator: dark_gray
    leading_trailing_space_bg: { attr: n } # no fg, no bg, attr none effectively turns this off
    header: green_bold
    empty: blue
    # Closures can be used to choose colors for specific values.
    # The value (in this case, a bool) is piped into the closure.
    bool: { if $in { 'dark_cyan' } else { 'dark_gray' } }
    int: dark_gray
    filesize: {|e|
      if $e == 0b {
        'dark_gray'
      } else if $e < 1mb {
        'cyan_bold'
      } else { 'blue_bold' }
    }
    duration: dark_gray
  date: { (date now) - $in |
    if $in < 1hr {
      'red3b'
    } else if $in < 6hr {
      'orange3'
    } else if $in < 1day {
      'yellow3b'
    } else if $in < 3day {
      'chartreuse2b'
    } else if $in < 1wk {
      'green3b'
    } else if $in < 6wk {
      'darkturquoise'
    } else if $in < 52wk {
      'deepskyblue3b'
    } else { 'dark_gray' }
  }
    range: dark_gray
    float: dark_gray
    string: dark_gray
    nothing: dark_gray
    binary: dark_gray
    cellpath: dark_gray
    row_index: green_bold
    record: white
    list: white
    block: white
    hints: dark_gray

    shape_and: purple_bold
    shape_binary: purple_bold
    shape_block: blue_bold
    shape_bool: light_cyan
    shape_custom: green
    shape_datetime: cyan_bold
    shape_directory: cyan
    shape_external: cyan
    shape_externalarg: green_bold
    shape_filepath: cyan
    shape_flag: blue_bold
    shape_float: purple_bold
    # shapes are used to change the cli syntax highlighting
    shape_garbage: { fg: "#FFFFFF" bg: "#FF0000" attr: b}
    shape_globpattern: cyan_bold
    shape_int: purple_bold
    shape_internalcall: cyan_bold
    shape_list: cyan_bold
    shape_literal: blue
    shape_matching_brackets: { attr: u }
    shape_nothing: light_cyan
    shape_operator: yellow
    shape_or: purple_bold
    shape_pipe: purple_bold
    shape_range: yellow_bold
    shape_record: cyan_bold
    shape_redirection: purple_bold
    shape_signature: green_bold
    shape_string: green
    shape_string_interpolation: cyan_bold
    shape_table: blue_bold
    shape_variable: purple
}

let-env config = {
    buffer_editor: $'($env.HOME)/.cargo/bin/hx'
    cd: {
        abbreviations: true
    }
    edit_mode: vi_insert
    keybindings: [
        {
            name: completion_menu
            modifier: None
            keycode: Tab
            mode: [emacs vi_insert]
            event: {until: [
                {send: Menu name: completion_menu}
                {send: MenuNext}
            ]}
        }
        {
            name: search_history
            modifier: Shift
            keycode: Down
            mode: [emacs vi_insert]
            event: [
                {edit: CutFromLineStart}
                {send: Menu name: history_menu}
            ]
        }
        {
            name: insert_space
            modifier: Alt
            keycode: Char_^
            mode: [emacs vi_insert]
            event: {edit: InsertChar value: ' '}
        }
        {
            name: enter_normal_mode
            modifier: Control
            keycode: Char_X
            mode: [emacs vi_insert]
            event: {send: Esc}
        }
        {
            name: edit_command
            modifier: Control
            keycode: Char_E
            mode: [emacs vi_insert]
            event: {send: OpenEditor}
        }
        {
            name: show_help
            modifier: None
            keycode: F1
            mode: [emacs vi_insert]
            event: {send: Menu name: help_menu}
        }
    ]
    rm: {
        always_trash: true
    }
    show_banner: false
    color_config: $light_theme
}
