class openswan::config(
  $ensure                       = 'present',
  $debug_level                  = undef,
  $nat_t                        = undef,
  $opportunistic_encryption     = undef,
  $dumpdir                      = undef,
  $plutoopts                    = undef,
  $plutostderrlog               = undef,
  $protostack                   = undef,
  $uniqueid                     = undef,
  $virtual_private              = undef,
) {

  if !($ensure in ['present', 'absent']) {
    fail("ensure = ${ensure} must be either 'present' or 'absent'")
  }

  $ensure_dir = $ensure ? {
    'present' => 'directory',
    default   => $ensure,
  }

  File {
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }

  file { '/etc/ipsec.conf':
    ensure  => $ensure,
    content => template('openswan/ipsec.conf.erb'),
  }
  file { '/etc/ipsec.secrets':
    ensure => $ensure,
    mode   => '0600',
    source => 'puppet:///modules/openswan/ipsec.secrets',
  }
  file { '/etc/ipsec.d':
    ensure => $ensure_dir,
    mode   => '0755',
  }
  file { '/etc/ipsec.d/connections':
    ensure => $ensure_dir,
    mode   => '0755',
  }
  file { '/etc/ipsec.d/secrets':
    ensure => $ensure_dir,
    mode   => '0600',
  }
  file { '/etc/ipsec.d/connections/index.conf':
    ensure => $ensure,
  }
}
