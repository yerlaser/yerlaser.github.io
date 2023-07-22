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
    cat $filename | par-each {|f| if ($f | path exists) {ls -D $f}} | flatten
  } else {
    $inp | lines | par-each {|f| if ($f | path exists) {ls -D $f}} | flatten
  }
}

# Filter files containing search string
export def contents (
  --case_sensitive (-c): bool # Preserve case
  pattern = '' # Pattern to search
  path = '.' # Search path
) {
  let inp = $in
  let inp = if ($inp | is-empty) {
    fd '' $path --type file | ls_lines
  } else {
    $inp | where type == file
  }
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
  let inp = if ($inp | is-empty) {
    fd -t f -t l '' $path | ls_lines
  } else {$inp}
  if ($inp | is-empty) {
    print -e 'Nothing found'
    return
  }
  let $inp = ($inp | where type == file | get name)
  if ($inp | length) > 13 {
    print -e 'Too many files'
    return
  } else {
    if $command == 'vi' {
      ^hx -c $'/tmp/config($env.THEME).toml' $inp
    } else {
      ^$command $inp
    }
  }
}

# Open all files with default editor
export def v (
  path = '.' # Search path
  pattern = '' # Search pattern
) {
  if ($path | is-empty) {
    ^hx -c $'/tmp/config($env.THEME).toml'
  } else if ($path | path type) == file {
    ^hx -c $'/tmp/config($env.THEME).toml' $path
  } else {
    let files = (fd -t f -t l $pattern $path | lines)
    if ($files | is-empty) {
      print -e 'Nothing found'
      return
    } else if ($files | length) > 13 {
      print -e 'Too many files'
      return
    }
    ^hx -c $'/tmp/config($env.THEME).toml' $files
  }
}

# Find files names matching a pattern
export def names (
  --case_sensitive (-c): bool # Preserve case
  pattern = '' # Pattern to search
  path = '.' # Search path
) {
  let inp = $in
  let inp = if ($inp | is-empty) {
    fd '' $path | ls_lines
  } else {
    $inp
  }
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
export def cat (
  file_name: string # File name
) {
  open -r $file_name | lines
}
