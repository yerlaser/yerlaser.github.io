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

# Change dir to a path in paste buffer
def-env bcd () {
  let p = (pbpaste)
  if (($p | str length) < 1) or (($p | size | get lines) > 1) or (not ($p | path exists)) {
    return
  }
  let p = if ($p | path type) == file {$p | path dirname} else {$p}
  cd $p
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
    podman run -d --name $'($pod_name)($n)' --tz 'Europe/Berlin' --pod $pod_name $image bash -c $'sed -i "s/#Port 22/Port 22($decimal)($n)/g" /etc/ssh/sshd_config ; service ssh start -D'
    ssh-keygen -R $'[localhost]:22($decimal)($n)'
    ssh-keyscan -t ed25519 -p $'22($decimal)($n)' localhost | save -a ~/.ssh/known_hosts
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
