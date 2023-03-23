alias mc = broot --conf $'($env.HOME)/Published/configs/broot/($env.THEME).hjson' -c ':start_end_panel;:panel_left_no_open'
alias vi = hx -c $'/tmp/config($env.THEME).toml'
alias year = ^cal -N -A 10 -B 1
let-env DELTA_FEATURES = '+side-by-side'
let-env EDITOR = $'hx -c /tmp/config($env.THEME).toml'
let-env LC_ALL = 'en_US.UTF-8'
let-env LC_TYPE = 'en_US.UTF-8'
let-env VISUAL = $'hx -c /tmp/config($env.THEME).toml'
let-env WASMER_DIR = $'($env.HOME)/.wasmer'
let-env WASMER_CACHE_DIR = $'($env.WASMER_DIR)/cache'

# Open Zellij with correct theme
def-env zel () {
  if $env.THEME == 'Light' {
    zellij --config $'($env.HOME)/Published/configs/zellij/config.kdl' options --theme catppuccin-latte
  } else {
    zellij --config $'($env.HOME)/Published/configs/zellij/config.kdl' options --theme catppuccin-mocha
  }
}

# Open a shell for each folder
def-env each_dirs () {
  for p in (ls -f | where type == dir | get name) {enter $p}  
  g 0
  g
}

if $env.THEME == 'Light' {
  let-env GIT_PAGER = 'delta --light'
  if ("~/werkstatt/configs/env.nu" | path exists) {
    source "~/werkstatt/configs/env.nu"
  }
} else {
  let-env GIT_PAGER = 'delta'
}

# List files using broot possibly doing additional filter
def tree (
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

let nupaths = ([$env.HOME .config nushell nupaths.txt] | path join)
let-env PATH = if ($nupaths | path exists) {
  $env.PATH | split row (char esep) | prepend (open --raw $nupaths | lines | where {|l| ($l !~ '^\s*#.*') and ($l !~ '^\s*$')} | path expand | filter {|p| path exists}) | uniq
} else {
  $env.PATH
}

# Connects and displays information about SSL certificate of a host
def get_certificate_info (
  --port (-p) = 443 # Port to connect
  url: string # URL of the host
) {
  echo | openssl s_client -showcerts -servername $url -connect $'($url):($port)' | openssl x509 -inform pem -noout -text
}

# Convert raw file names into ls-like output
def il (
  filename = '' # Path to file containing file names
) {
  let $inp = $in
  if ($inp | is-empty) {
    if ($filename | is-empty) {return}
    gl $filename | par-each {|f| if ($f | path exists) {ls -D $f}}
  } else {
    $inp | lines | par-each {|f| if ($f | path exists) {ls -D $f}}
  }
}

# Filter files containing search string
def gr (
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
def oa (
  command = 'vi' # Command to run (default vi)
  path = '.' # Search path
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

# Find files with names matching a pattern
def ff (
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

# Print string at the center filling with specified character
def print_title (
  --character (-c): string # Fill character
  text: string # String to print
) {
  let title_text = ($text | str join ' ')
  let width = (term size).columns
  if ($title_text | str length) > $width {
    print -e 'Text too long'
  } else {
    $title_text | str upcase | fill -a c -c $character -w $width
  }
}

# Print string(s) at the center with dash sign fill
def subtitle (
  ...text # Text to print (in additition to piped input if any)
) {
  let inp = $in
  let inp = if ($text | is-empty) {$inp} else {$inp | append [$text]}
  for l in $inp {print_title -c '-' $l}
}

# Print string(s) at the center with equal sign fill
def title (
  ...text # Text to print (in additition to piped input if any)
) {
  let inp = $in
  let inp = if ($text | is-empty) {$inp} else {$inp | append [$text]}
  for l in $inp {print_title -c '=' $l}
}

# Get lines from a text file
def gl (
  file_name: string # File name
) {
  open $file_name | lines
}

# Merge a mixed list of records and tables into a table
def merge_records () {
  let data_table = $in
  let empty_table = (1..($data_table | length) | reduce -f [] {|i,a| $a | append {}})
  let table_columns = ($data_table | columns)
  $table_columns | reduce -f $empty_table {|i,a| $a | merge ($data_table | get $i | flatten)}
}

# Create a pod with multiple containers and SSH server listening on different ports
def podssh (
  --image (-i): string # Image to use 
  --prefix (-p): int # Port number prefix (<p><n>)
  --number (-n): int # Number of containers in the pod (<p><n>)
  pod_name: string # Name of the pod
) {
  if $prefix > 6552 {
    echo 'Prefix can only be up to 6552'
    return
  }
  let $ports = (1..$number | reduce -f [] {|n,a| $a | append ['-p' $'($prefix)($n):($prefix)($n)']})
  podman pod create --name $pod_name $ports 
  for n in 1..$number {
    podman run -d --name $'($pod_name)($n)' --tz 'Europe/Berlin' --pod $pod_name $image bash -c $'sed -i "s/#Port .*/Port ($prefix)($n)/g" /etc/ssh/sshd_config; service ssh start -D'
    ssh-keygen -R $'[localhost]:($prefix)($n)'
    ssh-keyscan -t ed25519 -p $'($prefix)($n)' localhost | save -a ~/.ssh/known_hosts
  }
}

def create_right_prompt () {
  do -i {git branch --show-current}
}
let-env PROMPT_COMMAND_RIGHT = {|| create_right_prompt}

# Create helix config files with light and dark themes
def helix_configs () {
  if (
    ('/tmp/configLight.toml' | path exists) and
    ((ls /tmp/configLight.toml | get modified) < (ls ~/Published/configs/config.toml | get modified))
  ) {
    rm -p /tmp/configLight.toml
  }

  if (
    ('/tmp/configDark.toml' | path exists) and
    ((ls /tmp/configDark.toml | get modified) < (ls ~/Published/configs/config.toml | get modified))
  ) {
    rm -p /tmp/configDark.toml
  }

  if (not ('/tmp/configLight.toml' | path exists)) {
    echo "theme = 'catppuccin_latte'\n" | save /tmp/configLight.toml
    open --raw ~/Published/configs/config.toml | save --append /tmp/configLight.toml
  }

  if (not ('/tmp/configDark.toml' | path exists)) {
    echo "theme = 'catppuccin_mocha'\n" | save /tmp/configDark.toml
    open --raw ~/Published/configs/config.toml | save --append /tmp/configDark.toml
  }
}

helix_configs
