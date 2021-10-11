edit:completion:matcher[argument] = [seed]{ edit:match-substr $seed &ignore-case=$true }
edit:location:pinned = [ /LOCAL/Published/ /LOCAL/Synced/ /LOCAL/apps ]
edit:prompt = { styled (tilde-abbr $pwd) magenta; put ' ' }
edit:rprompt-persistent = $true
edit:rprompt = { styled (date '+%c') magenta }

fn ... { cd ../.. }
fn dir [@a]{ e:ls -FAhl $@a }
fn dirsize [@a]{ e:ls -FAhlrS $@a }
fn dirtime [@a]{ e:ls -FAhlrt $@a }
fn vi [@a]{ e:micro $@a }
