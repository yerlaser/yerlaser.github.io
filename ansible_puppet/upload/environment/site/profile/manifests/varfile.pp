class profile::varfile {
  $var_location = lookup('var_location', {value_type => String, default_value => '/tmp'})

  file { "${var_location}/varfile.txt":
    ensure  => present,
    owner   => 'luser',
    group   => 'luser',
    mode    => '0664',
    content => "puppet 'varfile' profile 'production' environment"
  }
}
