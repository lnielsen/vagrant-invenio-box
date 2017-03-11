include base

# Install nginx
class { 'nginx': }
# nginx::resource::upstream { 'upstream':
#   members => [
#     'localhost:5000',
#   ],
# }
# nginx::resource::server { 'invenio.box':
#   proxy => 'http://upstream',
#   ssl   => true,
# }


# Supervisord
include ::supervisord
# supervisord::program { 'myprogram':
#   command             => 'command --args',
#   priority            => '100',
#   program_environment => {
#     'HOME'   => '/home/myuser',
#     'PATH'   => '/bin:/sbin:/usr/bin:/usr/sbin',
#     'SECRET' => 'mysecret'
#   }
# }
