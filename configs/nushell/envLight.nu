alias alacritty_dark = zsh -c "~/Applications/Alacritty.app/Contents/MacOS/alacritty --config-file ~/Published/configs/alacritty/macosDark.yml&"
alias delta = delta --light
alias mc = broot --conf ~/Published/configs/broot/light.hjson -c ':start_end_panel;:panel_left_no_open'
alias vi = hx -c /tmp/configLight.toml
alias zellij = zellij --config ~/Published/configs/zellij/configLight.kdl
let-env EDITOR = 'hx -c /tmp/configLight.toml'
let-env GIT_PAGER = 'delta --light'
let-env VISUAL = 'hx -c /tmp/configLight.toml'

# Tree style listing of files and folders
def dir (
  --all (-a): bool # Include ignored files
  --long (-l): bool # Long format
  --extended (-e): bool # Show extended attributes
  directory: string = '.' # Directory to list
  command: string = '' # Extra command to run
) {
  let args = ['--conf' $'($env.HOME)/Published/configs/broot/light.hjson' '-c' $'($command):pt' $directory]
  let args = if $all {$args | append '-hi'} else {$args}
  let args = if $long {$args | append '-gds'} else {$args}
  let args = if $extended {$args | append '-p'} else {$args}
  broot $args
}

source ~/Published/configs/nushell/env.nu
if ("~/werkstatt/configs/env.nu" | path exists) {
  source "~/werkstatt/configs/env.nu"
}
