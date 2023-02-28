alias dir = broot --conf ~/Published/configs/brootLight.hjson -c :pt .
alias jour = hx -c /tmp/configLight.toml ~/journal.md
alias boljam = hx -c /tmp/configLight.toml ~/boljam.md
alias ll = broot --conf ~/Published/configs/brootLight.hjson -higsdp -c :pt .
alias mc = broot --conf ~/Published/configs/brootLight.hjson
alias vi = hx -c /tmp/configLight.toml
alias vl = hx -c /tmp/configLight.toml .
let-env EDITOR = 'hx -c /tmp/configLight.toml'
let-env GIT_PAGER = 'delta --light'
let-env VISUAL = 'hx -c /tmp/configLight.toml'

# Launch broot and if it returns a path cd to it
def-env mcd () {
  let p = (broot --conf ~/Published/configs/brootLight.hjson)
  if (($p | str length) < 1) or (($p | size | get lines) > 1) or (not ($p | path exists)) {
    return
  }
  let p = if ($p | path type) == file {$p | path dirname} else {$p}
  cd $p
}

source ~/Published/configs/env.nu
