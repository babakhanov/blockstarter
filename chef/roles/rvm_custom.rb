name 'rvm_custom'
description 'custom rvm'

run_list(
  "recipe[rvm::user]"
)

default_attributes(
  'rvm' => {
    'user_installs' => [{
      'user' => 'deployer',
      'default_ruby' => '2.2.3@global',
      'rubies' => ['2.2.0', '2.2.3']
    }]
  }
)
