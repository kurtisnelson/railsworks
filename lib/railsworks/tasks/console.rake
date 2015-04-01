# Rakefile
require 'rubygems'
require 'bundler'
Bundler.require if defined?(Bundler)

namespace :console do
  desc "Connecting to staging console"
  task :staging do
    regions = YAML.load_file('config/opsworks.yml')['staging']
    ip = get_ip(regions)
    path = '/srv/www/' + get_name(regions) + '/current'
    environment = setup_environment(regions)
    run_interactively("#{environment} bundle exec rails console --environment=production", ip, path)
  end

  desc "Connecting to production console"
  task :production do
    regions = YAML.load_file('config/opsworks.yml')['production']
    ip = get_ip(regions)
    path = '/srv/www/' + get_name(regions) + '/current'
    environment = setup_environment(regions)
    run_interactively("#{environment} bundle exec rails console --environment=production", ip, path)
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

  def setup_environment(regions)
    cmd = []
    regions.each do |region, value|
      client = Aws::OpsWorks::Client.new(region: region)
      env = client.describe_apps({app_ids: [value['app_id']]})[0][0].environment
      env.each do |v|
        cmd << v.key+'="'+v.value+'"' unless v.secure
      end
    end
    cmd.join ' '
  end

  def get_name(regions)
    regions.each do |region, value|
      client = Aws::OpsWorks::Client.new(region: region)
      return client.describe_apps({app_ids: [value['app_id']]})[0][0].shortname
    end
  end

  def run_interactively(command, server, path)
    exec %Q(ssh #{server} -t 'cd #{path} && sudo #{command}') if server && path
  end
end
