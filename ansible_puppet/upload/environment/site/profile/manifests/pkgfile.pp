class profile::pkgfile (
  String $file_location,
  String $file_name,
  String $file_owner
) {
  $var_location = lookup('var_location', {value_type => String, default_value => '/tmp'})

  file { "${var_location}/${file_location}":
    ensure => directory,
    owner => $file_owner,
    group => root
  }

  file { "${var_location}/${file_location}/${file_name}":
    ensure => file,
    owner => $file_owner,
    group => root,
    mode => '0644',
    source => 'puppet:///modules/profile/file.txt'
  }
}
