alias dir = broot --conf ~/Published/configs/broot/dark.hjson -c :pt .
alias jour = hx -c /tmp/configDark.toml ~/pense.md ~/jour.md
alias ll = broot --conf ~/Published/configs/broot/dark.hjson -higsdp -c :pt .
alias mc = broot --conf ~/Published/configs/broot/dark.hjson
alias vi = hx -c /tmp/configDark.toml
alias vl = hx -c /tmp/configDark.toml .
let-env EDITOR = 'hx -c /tmp/configDark.toml'
let-env GIT_PAGER = 'delta'
let-env VISUAL = 'hx -c /tmp/configDark.toml'

source ~/Published/configs/nushell/env.nu
