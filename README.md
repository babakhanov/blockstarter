blockstarter
=========

## Icomoon
`gem install icomoon_as_well`

### Usage

`doc/selection.json` it's an icomoon project which is up to date with iconset because of `icomoon_as_well` gem and it's ready to import into [icomoon.io](https://icomoon.io)  to work with iconset

Once you downloaded `icomoon.zip` from [icomoon.io](https://icomoon.io) and have instaled `icomoon_as_well` gem
type in a terminal `icomoon_as_well /path/to/icomoon.zip /path/to/project --rails` to unzip iconset to a project

`http://localhost:3000/stubs/icons` shows which icons available to use

## Deploy
### Chef
`cd /path/to/project/chef`
`librarian-chef install`
`knife solo cook deployer@parkstation.pp.ua`
### Capistrano
`cd /path/to/project`
`cap production deploy:setup`
`cap production deploy`
## demo
[blockstarter.pp.ua](http://blockstarter.pp.ua)