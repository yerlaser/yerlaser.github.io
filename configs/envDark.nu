alias dir = broot --conf ~/Published/configs/brootDark.hjson -c :pt .
alias ll = broot --conf ~/Published/configs/brootDark.hjson -higsdp -c :pt .
alias mc = broot --conf ~/Published/configs/brootDark.hjson
let-env GIT_PAGER = 'delta'

# Launch broot and if it returns a path cd to it
def-env mcd () {
  let p = (broot --conf ~/Published/configs/brootDark.hjson)
  if (($p | str length) < 1) or (($p | size | get lines) > 1) or (not ($p | path exists)) {
    return
  }
  let p = if ($p | path type) == file {$p | path dirname} else {$p}
  cd $p
}

source ~/Published/configs/env.nu
