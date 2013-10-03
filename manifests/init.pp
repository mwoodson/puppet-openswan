class openswan (
  $ensure                   = 'present',
  $debug_level              = $openswan::params::debug_level,
  $nat_t                    = $openswan::params::nat_t,
  $opportunistic_encryption = $openswan::params::opportunistic_encryption,
  $dumpdir                  = $openswan::params::dumpdir,
  $plutoopts                = $openswan::params::plutoopts,
  $plutostderrlog           = $openswan::params::plutostderrlog,
  $protostack               = $openswan::params::protostack,
  $uniqueid                 = $openswan::params::uniqueid,
  $virtual_private          = $openswan::params::virtual_private
) inherits openswan::params {

  include stdlib

  anchor { 'openswan::begin': }
  -> class { 'openswan::package':
    ensure                   => $ensure,
  }
  -> class { 'openswan::config':
    ensure                   => $ensure,
    debug_level              => $debug_level,
    nat_t                    => $nat_t,
    opportunistic_encryption => $opportunistic_encryption,
    protostack               => $protostack,
    dumpdir                  => $dumpdir,
    plutoopts                => $plutoopts,
    plutostderrlog           => $plutostderrlog,
    uniqueid                 => $uniqueid,
    virtual_private          => $virtual_private,
  }
  ~> class { 'openswan::service': }
  -> anchor { 'openswan::end': }

}
