name 'base'
description 'base role'

run_list(
  'recipe[sudo]',
  'recipe[chef-solo-search]',
  'recipe[users::sysadmins]',
  'recipe[nginx::source]',
  'recipe[monit]',
  'role[nodejs_custom]',
  'role[rvm_custom]',
  'recipe[imagemagick::devel]',
  'role[postgres_custom]',
  'recipe[vsftpd]',
  'recipe[rg-nginx]',
  'recipe[rg-monit]',
  'recipe[swap_tuning]',
  'role[redis]',
  'role[ssh-security]',
  'recipe[afterinstall]'
)

default_attributes(
  'authorization' => {
    'sudo' => {
      'groups' => ['deployer'],
      'users' => ['deployer'],
      'passwordless' => 'false'
    }
  },
  'users' => ['deployer'],
  'nginx' => {
    'version' => '1.7.4',
    'default_site_enabled' => false,
    'source' => {
      'modules' => ['nginx::http_gzip_static_module'],
      'checksum' => '935c5a5f35d8691d73d3477db2f936b2bbd3ee73668702af3f61b810587fbf68'
    }
  },
  'monit' => {
    'port' => 2812,
    'with start delay' => 1,
    'address' => '0.0.0.0',
    'allow' => ['localhost']
  },
  'firewall' => {
    'rules' => [
      {
        'web server http' =>   { 'port' => '80',   'protocol' => 'tcp' },
        'redis' =>             { 'port' => '6379', 'protocol' => 'tcp' },
        'monit http' =>        { 'port' => '2812', 'protocol' => 'tcp' }
      }
    ]
  },
  'swap_tuning' => {
    'minimum_size' => 1024
  },
)
