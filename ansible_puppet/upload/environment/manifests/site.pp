node default { }

node 'puppet2' {
  include 'role::server'
}
node 'puppet3' {
  include 'role::debian_server'
}