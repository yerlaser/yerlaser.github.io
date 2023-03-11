alias jour = hx -c /tmp/configDark.toml ~/pense.md ~/jour.md
alias mc = broot --conf ~/Published/configs/broot/dark.hjson
alias vi = hx -c /tmp/configDark.toml
let-env EDITOR = 'hx -c /tmp/configDark.toml'
let-env GIT_PAGER = 'delta'
let-env VISUAL = 'hx -c /tmp/configDark.toml'

# Tree style listing of files and folders
def dir (
  --long (-l): bool # Long format
  --all (-a): bool # Include ignored files
  directory: string = '.' # Directory to list
  command: string = '' # Extra command to run
) {
  let args = ['--conf' $'($env.HOME)/Published/configs/broot/dark.hjson' '-c' $'($command):pt' $directory]
  let args = if $long {$args | append '-gdps'} else {$args}
  let args = if $all {$args | append '-hi'} else {$args}
  broot $args
}

source ~/Published/configs/nushell/env.nu
