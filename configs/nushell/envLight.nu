alias alacritty_light = zsh -c "~/Applications/Alacritty.app/Contents/MacOS/alacritty --config-file ~/Published/configs/alacritty/macosDark.yml&"
alias delta = delta --light
alias mc = broot --conf ~/Published/configs/broot/light.hjson
alias vi = hx -c /tmp/configLight.toml
let-env EDITOR = 'hx -c /tmp/configLight.toml'
let-env GIT_PAGER = 'delta --light'
let-env VISUAL = 'hx -c /tmp/configLight.toml'

# Tree style listing of files and folders
def dir (
  --long (-l): bool # Long format
  --all (-a): bool # Include ignored files
  directory: string = '.' # Directory to list
  command: string = '' # Extra command to run
) {
  let args = ['--conf' $'($env.HOME)/Published/configs/broot/light.hjson' '-c' $'($command):pt' $directory]
  let args = if $long {$args | append '-gdps'} else {$args}
  let args = if $all {$args | append '-hi'} else {$args}
  broot $args
}

source ~/Published/configs/nushell/env.nu
if ("~/werkstatt/configs/env.nu" | path exists) {
  source "~/werkstatt/configs/env.nu"
}
