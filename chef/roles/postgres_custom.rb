name 'postgres_custom'
description 'postgres role'

run_list(
  "recipe[postgresql::server]",
  "recipe[postgresql::server_dev]",
  "recipe[postgresql::client]",
)

default_attributes(
  'postgresql' => {
    'version' => '9.3',
    'users' => [
      {
        'username' => 'deployer',
        'encrypted_password' => 'bdd55d54e2384e0583e5c5355fc72e51',
        'superuser' => true,
        'createdb' => true,
        'login' => true
      },
      {
        'username' => 'test',
        'encrypted_password' => '34819d7beeabb9260a5c854bc85b3e44',
        'superuser' => true,
        'createdb' => true,
        'login' => true
      }
    ],
    'databases' => [
      {
        'name' => 'blockstarter_production',
        'owner' => 'deployer',
        'template' => 'template0',
        'encoding' => 'UTF-8',
        'locale' => 'en_US.UTF-8'
      }
    ]
  }
)
