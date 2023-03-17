old-alias jour = hx -c /tmp/configDark.toml ~/pense.md ~/jour.md
old-alias mc = broot --conf ~/Published/configs/broot/dark.hjson -c ':start_end_panel;:panel_left_no_open'
old-alias vi = hx -c /tmp/configDark.toml
old-alias zellij = zellij --config ~/Published/configs/zellij/configDark.kdl
let-env EDITOR = 'hx -c /tmp/configDark.toml'
let-env GIT_PAGER = 'delta'
let-env VISUAL = 'hx -c /tmp/configDark.toml'

# Tree style listing of files and folders
def dir (
  --all (-a): bool # Include ignored files
  --long (-l): bool # Long format
  --extended (-e): bool # Show extended attributes
  --sort_by_size (-S): bool # Sort by size
  --sort_by_modification_time (-t): bool # Sort by modification time
  directory: string = '.' # Directory to list
  command: string = '' # Extra command to run
) {
  let args = ['--conf' $'($env.HOME)/Published/configs/broot/dark.hjson']
  let args = if $all {$args | append '-hi'} else {$args}
  let args = if $long {$args | append '-gds'} else {$args}
  let args = if $extended {$args | append '-p'} else {$args}
  let cmd = ':pt'
  let cmd = if $sort_by_size {$cmd | prepend ':sort_by_size'} else {$cmd}
  let cmd = if $sort_by_modification_time {$cmd | prepend ':sort_by_date'} else {$cmd}
  let args = ($args | append ['-c' $'($command)($cmd | str join ";")' $directory])
  broot $args
}

source ~/Published/configs/nushell/env.nu
