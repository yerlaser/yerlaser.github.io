# Name query
export def nslookup (
  hostname: string # Host name to queery
) {
  let os = (sys).host.name
  if $os == 'Darwin' {
    dscacheutil -q host -a name $hostname
  } else if $os =~ 'inux' {
    systemd-resolve $hostname
  } else {
    ^nslookup $hostname
  }
}

# Open multiple Zellij ssh sessions
export def mssh (
  session: string # Zellij session
  host_base: string # Hostname base
  last: int # Last index
  first: int = 1 # First index
) {
  for n in $first..$last {
    zellij -s $session run -n $'($host_base)($n)' -- ssh $'($host_base)($n)'
  }
  for n in $first..$last {
    zellij -s $session action move-focus up
  }
  for n in $first..$last {
    zellij -s $session action move-focus left
  }
  zellij -s $session action close-pane
}

# Connects and displays information about SSL certificate of a host
export def get_certificate_info (
  --port (-p) = 443 # Port to connect
  url: string # URL of the host
) {
  echo | openssl s_client -showcerts -servername $url -connect $'($url):($port)' | openssl x509 -inform pem -noout -text
}

# Merge a mixed list of records and tables into a table
export def merge_records () {
  let data_table = $in
  let empty_table = (1..($data_table | length) | reduce -f [] {|i,a| $a | append {}})
  let table_columns = ($data_table | columns)
  $table_columns | reduce -f $empty_table {|i,a| $a | merge ($data_table | get $i | flatten)}
}

# Create a pod with multiple containers and SSH server listening on different ports
export def pod_ssh (
  --image (-i): string # Image to use 
  --prefix (-p): int # Port number prefix (<p><n>)
  --number (-n): int # Number of containers in the pod (<p><n>)
  pod_name: string # Name of the pod
) {
  if $prefix > 6552 {
    echo 'Prefix can only be up to 6552'
    return
  }
  let $ports = (1..$number | reduce -f [] {|n,a| $a | append ['-p' $'($prefix)($n):($prefix)($n)']})
  podman pod create --name $pod_name $ports 
  for n in 1..$number {
    podman run -d --name $'($pod_name)($n)' --tz 'Europe/Berlin' --pod $pod_name $image bash -c $'sed -i "s/#Port .*/Port ($prefix)($n)/g" /etc/ssh/sshd_config; service ssh start -D'
    ssh-keygen -R $'[localhost]:($prefix)($n)'
    ssh-keyscan -t ed25519 -p $'($prefix)($n)' localhost | save -a ~/.ssh/known_hosts
  }
}
