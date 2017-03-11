class base {
  # User and group
  # ==============
  group { 'invenio':
    ensure => 'present',
    gid    => '502',
  }
  user { 'invenio':
    ensure           => 'present',
    gid              => '502',
    home             => '/home/invenio',
    managehome       => true,
    # password: invenio
    password         => '$6$ETMv4oWB$nVdDZSPSo1tt7ZySbqFZXMYpCqKRqwj1Ergz2vCfIOq12JaCJsrPewdDCPXGnoBG01aPlkzbP3/3wJSSU9/4j.',
    password_max_age => '99999',
    password_min_age => '0',
    shell            => '/bin/bash',
    uid              => '502',
  }
  class { 'sudo':
    purge               => false,
    config_file_replace => false,
  }
  sudo::conf { 'admins':
    content => '%invenio ALL=(ALL) NOPASSWD: ALL',
  }

  # Tools
  # =====
  include apt

  # Required libraries for badge generation.
  package {['libcairo2-dev', 'fonts-dejavu', 'libfreetype6-dev',
            'python3-dev']:
    ensure => 'present',
  }

  # NodeJS and related packages needed to build assets.
  class { 'nodejs':
    npm_package_ensure => 'present',
  }
  package {['clean-css@3.4.19', 'uglifyjs@2.4.10', 'requirejs@2.3.3',
            'node-sass@3.8.0']:
    ensure   => 'present',
    provider => 'npm',
  }

  # Python
  class { 'python' :
    version    => 'system',
    pip        => 'present',
    dev        => 'present',
    virtualenv => 'present',
    gunicorn   => 'absent',
  }
  python::virtualenv { '/opt/invenio':
    version => '3',
    owner   => 'invenio',
    group   => 'invenio',
    cwd     => '/opt/invenio',
  }
  python::pip { ['ipython', 'pip', 'setuptools', 'wheel', 'twine',
                'flask-konch']:
    ensure     => latest,
    virtualenv => '/opt/invenio',
    owner      => 'invenio',
  }

  # Services
  # ========
  # PostgreSQL (db: invenio, user: invenio, password: invenio)
  # psql -h localhost -U invenio --password -d invenio
  class { 'postgresql::server':
    # Password for postgres superuser
    postgres_password       => 'invenio',
    # Listen on all ports
    listen_addresses        => '*',
    # Allow login from any remote host
    ip_mask_allow_all_users => '0.0.0.0/0'
  }
  postgresql::server::db { 'invenio':
    user     => 'invenio',
    password => postgresql_password('invenio', 'invenio'),
  }

  # Elasticsearch (no password)
  class { 'elasticsearch':
    java_install      => true,
    manage_repo       => true,
    repo_version      => '2.x',
    restart_on_change => true,
    config            => {
      'network' => {
        'host' => '_site_',
      }
    }
  }
  elasticsearch::instance { 'invenio.box':
  }
  elasticsearch::plugin {['analysis-icu', 'mapper-attachments']:
    instances => 'invenio.box'
  }

  # Redis (no password)
  class { 'redis':
    bind => '192.168.33.3 127.0.0.1',
  }

  # RabbitMQ (vhost: invenio, user: invenio, password: invenio)
  class { '::rabbitmq':
    admin_enable      => true,
    service_ensure    => 'running',
    port              => '5672',
    delete_guest_user => true,
  }
  rabbitmq_user { 'invenio':
    admin    => true,
    password => 'invenio',
    tags     => ['monitoring', ],
  }
  rabbitmq_vhost { 'invenio':
    ensure => present,
  }
  rabbitmq_user_permissions { 'invenio@invenio':
    configure_permission => '.*',
    read_permission      => '.*',
    write_permission     => '.*',
  }
}
