alias dir = broot --conf ~/Published/configs/broot/light.hjson -c :pt .
alias la = broot --conf ~/Published/configs/broot/light.hjson -higsdp -c :pt .
alias mc = broot --conf ~/Published/configs/broot/light.hjson
alias vi = hx -c /tmp/configLight.toml
let-env EDITOR = 'hx -c /tmp/configLight.toml'
let-env GIT_PAGER = 'delta --light'
let-env VISUAL = 'hx -c /tmp/configLight.toml'

source ~/Published/configs/nushell/env.nu
if ("~/werkstatt/configs/env.nu" | path exists) {
  source "~/werkstatt/configs/env.nu"
}
