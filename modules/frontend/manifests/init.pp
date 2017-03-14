# Install nginx
class { 'nginx': }
nginx::resource::upstream { 'upstream':
  members => [
    'localhost:5000',
  ],
}
nginx::resource::server { 'invenio.box':
  proxy => 'http://upstream',
  ssl   => true,
}

# Supervisord
include ::supervisord
supervisord::program { 'gunicorn':
  command  => '/opt/invenio/bin/gunicorn -A invenio_app.wsgi',
  priority => '100',
}
