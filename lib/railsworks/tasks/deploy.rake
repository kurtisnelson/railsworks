require 'rubygems'
require 'bundler'
Bundler.require if defined?(Bundler)

namespace :deploy do
  desc "Deploy master to prod"
  task :staging do
    regions = YAML.load_file('config/opsworks.yml')['staging']
    regions.each do |region, value|
      client = Aws::OpsWorks::Client.new(region: region)
      client.create_deployment(
        stack_id: value['stack_id'],
        app_id: value['app_id'],
        command: {
          name: "deploy",
        args: {
          "migrate" => ["true"],
        },
        }
      )
    end
  end

  task :production do
    regions = YAML.load_file('config/opsworks.yml')['production']
    regions.each do |region, value|
      client = Aws::OpsWorks::Client.new(region: region)
      client.create_deployment(
        stack_id: value['stack_id'],
        app_id: value['app_id'],
        command: {
          name: "deploy",
        args: {
          "migrate" => ["true"],
        },
        }
      )
    end
  end
end
