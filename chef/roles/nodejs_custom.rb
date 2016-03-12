name 'nodejs_custom'
description 'nodeJS custom'

run_list(
  "recipe[nodejs]",
  "recipe[npm_packages]"
)

default_attributes(
  'nodejs' => {
    'version' => '0.10.31',
    'install_method' => 'package'
  },
  'npm_packages' => {
    'packages' => [
      'bower',
      'forever',
      'phantom',
      'phantomjs'
    ]
  }
)
