let-env config = {
  buffer_editor: $'($env.HOME)/.cargo/bin/hx -c /tmp/config($env.THEME).toml'
  cd: {
    abbreviations: true
  }
  ls: {
    clickable_links: false
  }
  keybindings: [
    {
      name: ignore
      modifier: alt
      keycode: char_-
      mode: [emacs vi_insert]
      event: null
    }
    {
      name: restore_down
      modifier: none
      keycode: esc
      mode: [emacs vi_insert]
      event: {until: [
        {send: menudown}
        {send: down}
      ]}
    }
    {
      name: completion_menu
      modifier: none
      keycode: tab
      mode: [emacs vi_insert]
      event: {until: [
        {send: menu name: completion_menu}
        {send: menunext}
      ]}
    }
  ]
  rm: {
    always_trash: true
  }
  show_banner: false
}

let dark_theme = {
  separator: white
  leading_trailing_space_bg: { attr: n } # no fg, no bg, attr none effectively turns this off
  header: green_bold
  empty: blue
  bool: {|| if $in { 'light_cyan' } else { 'light_gray' } }
  int: white
  filesize: {|e|
    if $e == 0b {
      'white'
    } else if $e < 1mb {
      'cyan'
    } else { 'blue' }
  }
  duration: white
  date: {|| (date now) - $in |
    if $in < 1hr {
      'purple'
    } else if $in < 6hr {
      'red'
    } else if $in < 1day {
      'yellow'
    } else if $in < 3day {
      'green'
    } else if $in < 1wk {
      'light_green'
    } else if $in < 6wk {
      'cyan'
    } else if $in < 52wk {
      'blue'
    } else { 'dark_gray' }
  }
  range: white
  float: white
  string: white
  nothing: white
  binary: white
  cellpath: white
  row_index: green_bold
  record: white
  list: white
  block: white
  hints: dark_gray
  search_result: {bg: red fg: white}

  shape_and: purple_bold
  shape_binary: purple_bold
  shape_block: blue_bold
  shape_bool: light_cyan
  shape_closure: green_bold
  shape_custom: green
  shape_datetime: cyan_bold
  shape_directory: cyan
  shape_external: cyan
  shape_externalarg: green_bold
  shape_filepath: cyan
  shape_flag: blue_bold
  shape_float: purple_bold
  shape_garbage: { fg: white bg: red attr: b}
  shape_globpattern: cyan_bold
  shape_int: purple_bold
  shape_internalcall: cyan_bold
  shape_list: cyan_bold
  shape_literal: blue
  shape_match_pattern: green
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
  shape_vardecl: purple
}

let light_theme = {
  separator: dark_gray
  leading_trailing_space_bg: { attr: n }
  header: green_bold
  empty: blue
  bool: {|| if $in { 'dark_cyan' } else { 'dark_gray' } }
  int: dark_gray
  filesize: {|e|
    if $e == 0b {
    'dark_gray'
    } else if $e < 1mb {
    'cyan_bold'
    } else { 'blue_bold' }
  }
  duration: dark_gray
  date: {|| (date now) - $in |
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

if $env.THEME == 'Light' {
  let-env config = ($env.config | upsert history {
    max_size: 10000
    sync_on_enter: true
    file_format: "plaintext"
  })
  let-env config = ($env.config | upsert color_config $light_theme)
} else {
  let-env config = ($env.config | upsert history {
    max_size: 10000
    sync_on_enter: true
    file_format: "sqlite"
  })
  let-env config = ($env.config | upsert color_config $dark_theme)
}

source ~/.config/nushell/zoxide.nu
