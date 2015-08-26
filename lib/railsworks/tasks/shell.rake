# Rakefile
require 'rubygems'
require 'bundler'
Bundler.require if defined?(Bundler)

namespace :shell do
  desc "Connecting to staging console"
  task :staging do
    regions = YAML.load_file('config/opsworks.yml')['staging']
    ip = get_ip(regions)
    path = '/srv/www/' + get_name(regions) + '/current'
    run_interactively(ip, path)
  end

  desc "Connecting to production console"
  task :production do
    regions = YAML.load_file('config/opsworks.yml')['production']
    ip = get_ip(regions)
    path = '/srv/www/' + get_name(regions) + '/current'
    run_interactively(ip, path)
  end

  def get_ip(regions)
    regions.each do |region, value|
      client = Aws::OpsWorks::Client.new(region: region)
      client.describe_instances({layer_id: value['layer_id']}).each do |page|
        page.instances.each do |instance|
          return instance.public_ip if instance.status == "online"
        end
        break
      end
      break
    end
    raise "Could not find online instance"
  end

  def get_name(regions)
    regions.each do |region, value|
      client = Aws::OpsWorks::Client.new(region: region)
      return client.describe_apps({app_ids: [value['app_id']]})[0][0].shortname
    end
  end

  def run_interactively(server, path)
    server = ENV['AWS_USERNAME'] + "@" + server if ENV['AWS_USERNAME']
    exec %Q(ssh #{server} -t 'cd #{path}')  if server && path
  end
end
