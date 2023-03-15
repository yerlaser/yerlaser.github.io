alias an = ^cal -N -A 10 -B 1
alias tout = for p in (ls -f | where type == dir | get name) {enter $p}
let-env WASMER_DIR = $'($env.HOME)/.wasmer'
let-env WASMER_CACHE_DIR = $'($env.WASMER_DIR)/cache'
let-env DELTA_FEATURES = '+side-by-side'

let nupaths = ([$env.HOME .config nushell nupaths.txt] | path join)
let-env PATH = if ($nupaths | path exists) {
  $env.PATH | split row (char esep) | prepend (open --raw $nupaths | lines | where {|l| ($l !~ '^\s*#.*') and ($l !~ '^\s*$')} | path expand | filter {|p| path exists}) | uniq
} else {
  $env.PATH
}

# Get lines from a text file
def get_lines (
  file_name: string # File name
) {
  open $file_name | lines
}

# Flatten array of mixed records and tables
def flatten_array (
  --data_format (-f) = 'json' # Data format
) {
  let data_array = $in
  let data_table = (
    if $data_format == 'json' {
      $data_array | each {|r| $r | from json}
    } else if $data_format == 'toml' {
      $data_array | each {|r| $r | from toml}
    }
  )
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
let-env PROMPT_COMMAND_RIGHT = {create_right_prompt}

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
