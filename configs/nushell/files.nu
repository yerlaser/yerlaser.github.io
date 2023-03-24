# Open a shell for each folder
export def-env pushd_all () {
  for p in (ls -f | where type == dir | get name) {enter $p}; g 0; g
}

# List files using broot possibly doing additional filter
export def tree (
  --all (-a): bool # Include ignored files
  --long (-l): bool # Long format
  --extended (-e): bool # Show extended attributes
  folder: string = '.' # Folder to list
  filter: string = '' # Filter or addtional command
) {
  let args = ['--conf' $'($env.HOME)/Published/configs/broot/($env.THEME).hjson']
  let args = if $all {$args | append '-hi'} else {$args}
  let args = if $long {$args | append '-ds'} else {$args}
  let args = if $extended {$args | append '-gp'} else {$args}
  let cmd = ':pt'
  let args = ($args | append ['-c' $'($filter)($cmd | str join ";")' $folder])
  broot $args
}

# Convert raw file names into ls-like output
export def ls_lines (
  filename = '' # Path to file containing file names
) {
  let $inp = $in
  if ($inp | is-empty) {
    if ($filename | is-empty) {return}
    get_lines $filename | par-each {|f| if ($f | path exists) {ls -D $f}}
  } else {
    $inp | lines | par-each {|f| if ($f | path exists) {ls -D $f}}
  }
}

# Filter files containing search string
export def grep_contents (
  --case_sensitive (-c): bool # Preserve case
  pattern = '' # Pattern to search
  path = '.' # Search path
) {
  let inp = $in
  let inp = if ($inp | is-empty) {ls $'($path)/**/*' | where type == file} else {$inp | where type == file}
  if ($pattern | is-empty) {
    $inp
  } else {
    let dp = ($pattern | str downcase)
    if ($case_sensitive or $dp != $pattern) {
      $inp | par-each {|f| if not (open -r $f.name | find -r $pattern | is-empty) {ls $f.name}}
    } else {
      $inp | par-each {|f| if not (open -r $f.name | find -i -r $pattern | is-empty) {ls $f.name}}
    }
  }
}

# Open all piped filenames with provided command
export def open_all (
  path = '.' # Search path
  command = 'vi' # Command to run (default vi)
) {
  let inp = $in
  let inp = if ($inp | is-empty) {ls $'($path)/**/*'} else {$inp}
  let $inp = ($inp | get name)
  if ($inp | length) > 13 {
    print -e 'Too many files'
    return
  } else {
    if $command == 'vi' {
      vi $inp
    } else {
      ^$command $inp
    }
  }
}

# Find files names matching a pattern
export def grep_names (
  --case_sensitive (-c): bool # Preserve case
  pattern = '' # Pattern to search
  path = '.' # Search path
) {
  let inp = $in
  let inp = if ($inp | is-empty) {ls $'($path)/**/*'} else {$inp}
  if ($pattern | is-empty) {
    $inp
  } else {
    let dp = ($pattern | str downcase)
    if ($case_sensitive or $dp != $pattern) {
      $inp | where name =~ $pattern
    } else {
      $inp | par-each {|f| if ($f.name | str downcase) =~ $dp {ls $f.name}}
    }
  }
}

# Get lines from a text file
export def get_lines (
  file_name: string # File name
) {
  open -r $file_name | lines
}
