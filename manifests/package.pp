class openswan::package(
  $ensure           = 'present'
){
  package { $openswan::params::package_list:
    ensure => $ensure,
  }
}
