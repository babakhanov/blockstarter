cookbook_file "/etc/monit/conf.d/nginx.conf" do
  user "root"
  group "root"
  mode "0655"
  notifies :restart, resources(:service => "monit"), :delayed
end

cookbook_file "/etc/monit/conf.d/redis.conf" do
  user "root"
  group "root"
  mode "0655"
  notifies :restart, resources(:service => "monit"), :delayed
end

cookbook_file "/etc/monit/conf.d/sidekiq.conf" do
  user "root"
  group "root"
  mode "0655"
  notifies :restart, resources(:service => "monit"), :delayed
end

