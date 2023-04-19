function nslookup
  switch (uname)
    case Darwin
      dscacheutil -q host -a name $argv
    case Linux
      systemd-resolve $hostname
    case '*'
      command nslookup $hostname
  end
end

function get_certificate_info
  argparse --min-args 1 --max-args 1 'p/port=!_validate_int --min 1 --max 65535' -- $argv
  or return
  if set -q _flag_port
    set port $_flag_port
  else
    set port 443
  end
  echo | openssl s_client -showcerts -servername $argv -connect "$argv:$port" | openssl x509 -inform pem -noout -text
end
