alias jour = hx -c /tmp/configDark.toml ~/pense.md ~/jour.md
alias mc = broot --conf ~/Published/configs/broot/dark.hjson -c ':start_end_panel;:panel_left_no_open'
alias vi = hx -c /tmp/configDark.toml
alias zellij = zellij --config ~/Published/configs/zellij/configDark.kdl
let-env EDITOR = 'hx -c /tmp/configDark.toml'
let-env GIT_PAGER = 'delta'
let-env VISUAL = 'hx -c /tmp/configDark.toml'

# Tree style listing of files and folders
def dir (
  --all (-a): bool # Include ignored files
  --long (-l): bool # Long format
  --extended (-e): bool # Show extended attributes
  directory: string = '.' # Directory to list
  command: string = '' # Extra command to run
) {
  let args = ['--conf' $'($env.HOME)/Published/configs/broot/dark.hjson' '-c' $'($command):pt' $directory]
  let args = if $all {$args | append '-hi'} else {$args}
  let args = if $long {$args | append '-gds'} else {$args}
  let args = if $extended {$args | append '-p'} else {$args}
  broot $args
}

source ~/Published/configs/nushell/env.nu
