alias ay = ^cal -A 8
let-env WASMER_DIR = $'($env.HOME)/.wasmer'
let-env WASMER_CACHE_DIR = $'($env.WASMER_DIR)/cache'
let-env DELTA_FEATURES = '+side-by-side'
# let-env CPLUS_INCLUDE_PATH = "/LOCAL/apps/gcc/include/c++/13.0.0"
# let-env LD_LIBRARY_PATH = "/LOCAL/apps/gcc/lib64"
# let-env LD_RUN_PATH = "/LOCAL/apps/gcc/lib64"
# let-env CC = "/LOCAL/apps/gcc/bin/gcc"
# let-env CXX = "/LOCAL/apps/gcc/bin/g++"

let nupaths = ([$env.HOME .config nushell nupaths.txt] | path join)
let-env PATH = if ($nupaths | path exists) {
  $env.PATH | split row (char esep) | prepend (open --raw $nupaths | lines | where {|l| ($l !~ '^\s*#.*') and ($l !~ '^\s*$')} | path expand | filter {|p| path exists}) | uniq
} else {
  $env.PATH
}

# Change dir to a path in paste buffer
def-env bcd () {
  let p = (bput)
  if (($p | str length) < 1) or (($p | size | get lines) > 1) or (not ($p | path exists)) {
    return
  }
  let p = if ($p | path type) == file {$p | path dirname} else {$p}
  cd $p
}

if (
  (
    ('/tmp/configLight.toml' | path exists) and
    (ls /tmp/configLight.toml | get modified) < (ls ~/Published/configs/config.toml | get modified)
  ) or (not ('/tmp/configLight.toml' | path exists))
) {
  echo "theme = 'catppuccin_latte'\n" | save /tmp/configLight.toml
  open --raw ~/Published/configs/config.toml | save --append /tmp/configLight.toml
}

if (
  (
    ('/tmp/configDark.toml' | path exists) and
    (ls /tmp/configDark.toml | get modified) < (ls ~/Published/configs/config.toml | get modified)
  ) or (not ('/tmp/configDark.toml' | path exists))
) {
  echo "theme = 'catppuccin_macchiato'\n" | save /tmp/configDark.toml
  open --raw ~/Published/configs/config.toml | save --append /tmp/configDark.toml
}

# Create a pod with multiple containers and SSH server listening on different ports
def podssh (
  --image (-i): string # Image to use 
  --decimal (-d): int # Decimal for port number (22dn)
  --number (-n): int # Number of containers in the pod (22dn)
  pod_name: string # Name of the pod
) {
  if $decimal > 9 {
    echo 'Decimal can only be up to 9'
    return
  }
  let ports = (1..5 | reduce -f [] {|n,a| $a | append ['-p' $'22($decimal)($n):22($decimal)($n)']})
  podman pod create --name $pod_name $ports 
  for n in 1..$number {
    podman run -d --name $'($pod_name)($n)' --tz 'Europe/Berlin' --pod $pod_name $image bash -c $'sed -i "s/#Port 22/Port 22($decimal)($n)/g" /etc/ssh/sshd_config ; service ssh start ; tail -f /dev/null'
    ssh-keygen -R $'[localhost]:22($decimal)($n)'
    ssh-keyscan -t ed25519 -p $'22($decimal)($n)' localhost | save -a ~/.ssh/known_hosts
  }
}

def create_right_prompt () {
  do -i {git branch --show-current}
}
let-env PROMPT_COMMAND_RIGHT = {create_right_prompt}

# Get last recursive command result
def r () {
  $env.LAST_CMD_RESULT
}

# Recursively search for pattern in file names
def-env rfind (
  --fixed_string (-f) = true # Treat pattern as fixed string (default)
  search_pattern: string # Search pattern
) {
  let-env LAST_CMD_RESULT = (
    if $fixed_string {fd -Fi $search_pattern} else {fd $search_pattern} | lines | wrap 'name'
  )
  $env.LAST_CMD_RESULT
}

# Recursively grep files for pattern
def-env rgrep (
  --fixed_string (-f) = true # Treat pattern as fixed string (default)
  search_pattern: string # Search pattern
) {
  let-env LAST_CMD_RESULT = (
    if $fixed_string {rg -Fil $search_pattern} else {fd -l $search_pattern} | lines | wrap 'name'
  )
  $env.LAST_CMD_RESULT
}

# Run command on row number
def rcmd (
  cmd: string # Command to run
  row_number: int = 100000 # Row number (default last)
) {
  let input = $in
  let input = (if $input == null {$env.LAST_CMD_RESULT} else {$input})
  let ilast = ($input | length) - 1
  let ilast = (if $row_number > $ilast {$ilast} else {$row_number})
  let fpath = ($input | select $ilast | get name | get 0)
  run-external $cmd $fpath
}

# Change dir to the item on the specified row number
def-env rcd (
  row_number: int = 100000 # Row number (default last)
) {
  let input = $in
  let input = (if $input == null {$env.LAST_CMD_RESULT} else {$input})
  let ilast = ($input | length) - 1
  let ilast = (if $row_number > $ilast {$ilast} else {$row_number})
  let fpath = ($input | select $ilast | get name | get 0)
  let dpath = (if ($fpath | path type) == 'file' {$fpath | path dirname} else {$fpath})
  cd $dpath
}

# Open file on the specified row number with vi
def rvi (
  row_number: int = 100000 # Row number (default last)
) {
  let input = $in
  let input = (if $input == null {$env.LAST_CMD_RESULT} else {$input})
  let ilast = ($input | length) - 1
  let ilast = (if $row_number > $ilast {$ilast} else {$row_number})
  let fpath = ($input | select $ilast | get name | get 0)
  vi $fpath
}

# Open file on the specified row number with cat
def rcat (
  row_number: int = 100000 # Row number (default last)
) {
  let input = $in
  let input = (if $input == null {$env.LAST_CMD_RESULT} else {$input})
  let ilast = ($input | length) - 1
  let ilast = (if $row_number > $ilast {$ilast} else {$row_number})
  let fpath = ($input | select $ilast | get name | get 0)
  cat $fpath
}

if ("~/werkstatt/env.nu" | path exists) {
  source ~/werkstatt/env.nu
}
