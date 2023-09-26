# List files in long format with selected columns
export def ll (
  path = '.' # Path
) {
  ls -la $path | select name size modified mode user group target
}

# List files using broot possibly doing additional filter
export def tree (
  --all (-a): bool # Include ignored files
  --long (-l): bool # Long format
  --extended (-e): bool # Show extended attributes
  --filter_pattern (-s): string = '' # Search pattern
  folder: string = '.' # Folder to list
) {
  let args = ['--conf' $'($env.HOME)/Published/configs/broot/($env.THEME).hjson']
  let args = if $all {$args | append '-hi'} else {$args}
  let args = if $long {$args | append '-ds'} else {$args}
  let args = if $extended {$args | append '-gp'} else {$args}
  let cmd = ':pt'
  let args = ($args | append ['-c' $'($filter_pattern)($cmd | str join ";")' $folder])
  broot $args
}

# Open all files with default editor
export def vi (
  --filter_pattern (-f): string # Search pattern
  ...paths # Paths to open or search (if only one or and not a file)
) {
  if ($paths | is-empty) and ($filter_pattern | is-empty) {
    ^hx -c $'/tmp/config($env.THEME).toml'
  } else if ($paths | length) > 1 or ($paths | get 0 | path type) == file {
    ^hx -c $'/tmp/config($env.THEME).toml' $paths
  } else {
    let $paths = if ($paths | is-empty) {['.']} else {$paths}
    let $filter_pattern = if ($filter_pattern | is-empty) {''} else {$filter_pattern}
    let files = (fd -t f -t l -F $filter_pattern $paths | lines)
    if ($files | is-empty) or (($files | length) > 13) {
      ^hx -c $'/tmp/config($env.THEME).toml' $paths
    } else {
      ^hx -c $'/tmp/config($env.THEME).toml' $files
    }
  }
}

# Get lines from a text file
export def cat (
  path string # File path
) {
  open -r $path | lines
}
