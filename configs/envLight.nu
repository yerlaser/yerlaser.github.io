alias dir = broot --conf ~/Published/configs/brootLight.hjson -c :pt .
alias jour = hx -c /tmp/configLight.toml ~/jour.md
alias pense = hx -c /tmp/configLight.toml ~/pense.md
alias ll = broot --conf ~/Published/configs/brootLight.hjson -higsdp -c :pt .
alias mc = broot --conf ~/Published/configs/brootLight.hjson
alias mcd = (broot --conf ~/Published/configs/brootLight.hjson | pbcopy)
alias vi = hx -c /tmp/configLight.toml
alias vl = hx -c /tmp/configLight.toml .
let-env EDITOR = 'hx -c /tmp/configLight.toml'
let-env GIT_PAGER = 'delta --light'
let-env VISUAL = 'hx -c /tmp/configLight.toml'

source ~/Published/configs/env.nu

if ("~/werkstatt/env.nu" | path exists) {
  source ~/werkstatt/env.nu
}
