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

# Open files with vi possibly filtering files
export def vi (
  --exclude_pattern (-x): string # Exclude pattern
  --filter_pattern (-f): string # Search pattern
  ...paths # Paths to open or search (if only one or and not a file)
) {
  let paths = if ($paths | is-empty) { ['.'] } else { $paths }
  let paths = if ($paths | get 0 | path type) == symlink { (ls -l $"($paths | get 0)*" | get target) } else { $paths }
  if ($paths | get 0) == '.' and ($filter_pattern | is-empty) {
    ^hx -c $'/tmp/config($env.THEME).toml'
  } else if ($paths | length) > 1 {
    ^hx -c $'/tmp/config($env.THEME).toml' $paths
  } else if not (($paths | get 0 | path type) == dir) {
    ^hx -c $'/tmp/config($env.THEME).toml' $paths
  } else {
    let path = if ($paths | get 0) == '.' { '**/*' } else { $"($paths | get 0 | str trim -r -c '/')/**/*" }
    let expression = if ($filter_pattern | is-empty) { $path } else { $"($path)\(?i\)($filter_pattern)*" }
    let excludes = ['**/node_modules/**' '**/target/**' '**/.git/**' '**/zig-out/**' '**/zig-cache/**' '**/.*' '**/.*/**']
    let excludes = if ($exclude_pattern | is-empty) { $excludes } else { $excludes | append $"**/*\(?i\)($exclude_pattern)*" }
    let files = glob -D $expression -n $excludes
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
