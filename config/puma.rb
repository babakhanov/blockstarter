#!/usr/bin/env puma

app_path = File.expand_path(File.dirname(File.dirname(__FILE__))).split("/") # /home/deployer/sites/auth
app_path = app_path.map{|e| e != 'releases' && e !~ /^\d{14}$/ ? e : nil; }.compact.join('/')

Dir.mkdir(File.join(app_path, "shared")) unless Dir.exists?(File.join(app_path, "shared"))
Dir.mkdir(File.join(app_path, "shared", "tmp")) unless Dir.exists?(File.join(app_path, "shared", "tmp"))
Dir.mkdir(File.join(app_path, "shared", "log")) unless Dir.exists?(File.join(app_path, "shared", "log"))
Dir.mkdir(File.join(app_path, "shared", "tmp", "sockets")) unless Dir.exists?(File.join(app_path, "shared", "tmp", "sockets"))
Dir.mkdir(File.join(app_path, "shared", "tmp", "pids")) unless Dir.exists?(File.join(app_path, "shared", "tmp", "pids"))

directory "#{app_path}/current"

rackup "#{app_path}/current/config.ru"

daemonize true

pidfile "#{app_path}/shared/tmp/pids/puma.pid"

state_path "#{app_path}/shared/tmp/pids/puma.state"

stdout_redirect "#{app_path}/shared/log/puma_stdout.log", "#{app_path}/shared/log/puma_stderr.log"

threads 6, 6

bind "unix:#{app_path}/shared/tmp/sockets/puma.sock"

workers 2

preload_app!

tag app_path.split('/').last
