alias dir = broot --conf ~/Published/configs/brootDark.hjson -c :pt .
alias ll = broot --conf ~/Published/configs/brootDark.hjson -higsdp -c :pt .
let-env GIT_PAGER = 'delta'

# Launch broot; if it returns a folder path cd to it or if it returns file path open it
def-env mc () {
  let p = (broot --conf ~/Published/configs/brootDark.hjson)
  if (($p | str length) < 1) or (($p | size | get lines) > 1) or (not ($p | path exists)) {
    return
  }
  if ($p | path type) == file {
    hx -c ~/Published/configs/config.toml $p
  } else {
    cd $p
  }
}

source ~/Published/configs/env.nu
