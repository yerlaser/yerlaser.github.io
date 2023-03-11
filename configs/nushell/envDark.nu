# alias dir = 
alias jour = hx -c /tmp/configDark.toml ~/pense.md ~/jour.md
alias ll = broot --conf ~/Published/configs/broot/dark.hjson -higsdp -c :pt .
alias mc = broot --conf ~/Published/configs/broot/dark.hjson
alias vi = hx -c /tmp/configDark.toml
let-env EDITOR = 'hx -c /tmp/configDark.toml'
let-env GIT_PAGER = 'delta'
let-env VISUAL = 'hx -c /tmp/configDark.toml'

# Tree style listing of files and folders
def dir (
  --command (-c): string = '' # Extra command to run
  directory: string = '.' # Directory to list
) {
  broot --conf ~/Published/configs/broot/dark.hjson -c $'($command):pt' $directory
}

source ~/Published/configs/nushell/env.nu
