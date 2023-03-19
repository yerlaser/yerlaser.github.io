old-alias delta = delta --light
old-alias mc = broot --conf ~/Published/configs/broot/light.hjson -c ':start_end_panel;:panel_left_no_open'
old-alias vi = hx -c /tmp/configLight.toml
old-alias zellij = zellij --config ~/Published/configs/zellij/configLight.kdl
let-env EDITOR = 'hx -c /tmp/configLight.toml'
let-env GIT_PAGER = 'delta --light'
let-env VISUAL = 'hx -c /tmp/configLight.toml'

# List files using broot possibly doing additional filter
def tree (
  --all (-a): bool # Include ignored files
  --long (-l): bool # Long format
  --extended (-e): bool # Show extended attributes
  folder: string = '.' # Folder to list
  filter: string = '' # Filter or addtional command
) {
  let args = ['--conf' $'($env.HOME)/Published/configs/broot/light.hjson']
  let args = if $all {$args | append '-hi'} else {$args}
  let args = if $long {$args | append '-ds'} else {$args}
  let args = if $extended {$args | append '-gp'} else {$args}
  let cmd = ':pt'
  let args = ($args | append ['-c' $'($filter)($cmd | str join ";")' $folder])
  broot $args
}

source ~/Published/configs/nushell/env.nu
if ("~/werkstatt/configs/env.nu" | path exists) {
  source "~/werkstatt/configs/env.nu"
}
