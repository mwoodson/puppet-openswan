define openswan::shared_secret (
  $hosts,
  $psk
) {

  File {
    owner => 'root',
    group => 'root',
    mode  => '0600',
  }

  $host_line = join($hosts, ' ')

  file { "/etc/ipsec.d/secrets/${name}.secret":
    ensure  => file,
    mode    => '0600',
    content => "${host_line} : PSK \"${psk}\"\n",
    notify  => Class['openswan::service'],
  }
}
