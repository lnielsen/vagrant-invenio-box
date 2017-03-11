class ils {
  include base

  python::pip { 'invenio-app-ils[postgresql,elasticsearch2]':
    ensure     => latest,
    virtualenv => '/opt/invenio',
  }->
  file {['/opt/invenio/var/', '/opt/invenio/var/instance/']:
    ensure => directory,
    owner  => 'invenio',
    group  => 'invenio',
  }->
  file { '/opt/invenio/var/instance/invenio.cfg':
    ensure  => file,
    content => file('ils/invenio.cfg'),
    mode    => '0644',
    owner   => 'invenio',
    group   => 'invenio',
  }->
  file { '/opt/invenio/provision.sh':
    ensure  => file,
    content => file('ils/provision.sh'),
    mode    => '0755',
    owner   => 'invenio',
    group   => 'invenio'
  }->
  exec { '/opt/invenio/provision.sh':
    user    => 'invenio',
    group   => 'invenio',
    cwd     => '/opt/invenio',
    creates => '/opt/invenio/var/instance/static/package.json',
    path    => ['/opt/invenio/bin', '/usr/bin', ],
    require => [
      Class['Base'],
    ]
  }
}
