alias delta = delta --light
alias ll = broot --conf ~/Published/configs/broot/light.hjson -higsdp -c :pt .
alias mc = broot --conf ~/Published/configs/broot/light.hjson
alias vi = hx -c /tmp/configLight.toml
let-env EDITOR = 'hx -c /tmp/configLight.toml'
let-env GIT_PAGER = 'delta --light'
let-env VISUAL = 'hx -c /tmp/configLight.toml'

# Tree style listing of files and folders
def dir (
  --command (-c): string = '' # Extra command to run
  directory: string = '.' # Directory to list
) {
  broot --conf ~/Published/configs/broot/dark.hjson -c $'($command):pt' $directory
}

source ~/Published/configs/nushell/env.nu
if ("~/werkstatt/configs/env.nu" | path exists) {
  source "~/werkstatt/configs/env.nu"
}
