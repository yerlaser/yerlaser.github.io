# List files in long format with selected columns
export def ll (
  path = '.' # Path
) {
  ls -la $path | select name size modified mode user group target
}

# List files using broot possibly doing additional filter
export def tree (
  --all (-a) # Include ignored files
  --long (-l) # Long format
  --extended (-e) # Show extended attributes
  --filter_pattern (-s): string = '' # Search pattern
  folder: string = '.' # Folder to list
) {
  let all = if ($all | is-empty) {false} else {$all}
  let long = if ($long | is-empty) {false} else {$long}
  let extended = if ($extended | is-empty) {false} else {$extended}
  let args = ['--conf' $'($env.HOME)/Published/configs/broot/($env.THEME).hjson']
  let args = if $all {$args | append '-hi'} else {$args}
  let args = if $long {$args | append '-ds'} else {$args}
  let args = if $extended {$args | append '-gp'} else {$args}
  let cmd = ':pt'
  let args = ($args | append ['-c' $'($filter_pattern)($cmd | str join ";")' $folder])
  broot $args
}

# Open files with vi possibly filtering files
export def vi (
  --filter_pattern (-f): string # Search pattern
  --exclude_pattern (-x): string # Exclude pattern
  --max_number (-m): int = 13 # Max number of items to open
  ...paths # Paths to open or search (if only one or and not a file)
) {
  if ($filter_pattern | is-empty) and ($exclude_pattern | is-empty) {
    if ($paths | is-empty) {
      ^hx -c $'/tmp/config($env.THEME).toml'
    } else if ($paths | length) > 1 {
      ^hx -c $'/tmp/config($env.THEME).toml' $paths
    } else if ($paths | get 0 | path type) == dir or (
      ($paths | get 0 | path type) == symlink and (ls -l $"($paths | get 0)*" | get target) == dir
    ) {
      l -m ($max_number) ($paths | get 0) -e
    } else {
      ^hx -c $'/tmp/config($env.THEME).toml' $paths
    }
  } else if ($paths | length) > 1 {
    print "Error multiple paths with search pattern are not allowed"
  } else {
    if ($paths | is-empty) {
      l -m ($max_number) -f $filter_pattern -x $exclude_pattern -e
    } else {
      l -m ($max_number) -f $filter_pattern -x $exclude_pattern ($paths | get 0) -e
    }
  }
}

# Open files with vi possibly filtering files
export def l (
  --filter_pattern (-f): string # Search pattern
  --exclude_pattern (-x): string # Exclude pattern
  --edit (-e) # Edit files (up to max number of items)
  --max_number (-m): int = 13 # Max number of items to open
  path: string = '.' # Path to search
) {
  let path = ($path | str trim -r -c '/')
  let path = if $path == '.' { '**/*' } else { $"($path)/**/*" }
  let expression = if ($filter_pattern | is-empty) { $path } else { $"($path)\(?i)($filter_pattern)*" }
  let excludes = ['**/node_modules/**' '**/target/**' '**/.git/**' '**/zig-out/**' '**/zig-cache/**' '**/.*' '**/.*/**' '**/Cargo.lock']
  let excludes = if ($exclude_pattern | is-empty) { $excludes } else { $excludes | append $"**/*\(?i\)($exclude_pattern)*" }
  if $edit {
    ^hx -c $'/tmp/config($env.THEME).toml' (glob -D $expression -n $excludes | take $max_number)
  } else {
    glob -D $expression -n $excludes
  }
}

# Get lines from a text file
export def cat (
  path: string # File path
) {
  open -r $path | lines
}
