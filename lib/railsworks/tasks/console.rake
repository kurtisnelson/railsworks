# Rakefile
require 'rubygems'
require 'bundler'
Bundler.require if defined?(Bundler)

namespace :console do
  desc "Connecting to staging console"
  task :staging do
    regions = YAML.load_file('config/opsworks.yml')['staging']
    ip = get_ip(regions)
    path = '/srv/www/bouncer/current'
    run_interactively("SEGMENT_KEY='' bundle exec rails console --environment=production", ip, path)
  end

  desc "Connecting to production console"
  task :production do
    regions = YAML.load_file('config/opsworks.yml')['production']
    ip = get_ip(regions)
    # Change myapp to your app name
    path = '/srv/www/bouncer/current'
    run_interactively("SEGMENT_KEY='' bundle exec rails console --environment=production", ip, path)
  end

  def get_ip(regions)
    ip = false
    regions.each do |region, value|
      client = Aws::OpsWorks::Client.new(region: region)
      client.describe_instances({layer_id: value['layer_id']}).each do |page|
        ip = page.instances[0].public_ip
        break
      end
      break
    end
    ip
  end

  def run_interactively(command, server, path)
    exec %Q(ssh #{server} -t 'cd #{path} && sudo #{command}') if server && path
  end
end
