require 'rubygems'
require 'bundler'
Bundler.require if defined?(Bundler)

namespace :rollbar do
  desc "Send deployment notification"
  task :deploy do
    rollbar_user = ENV['USER'] || ENV['USERNAME']
    rollbar_env = 'production'
    rollbar_token = ENV['ROLLBAR_ACCESS_TOKEN']
    current_revision = `git log -n 1 --pretty=format:"%H"`

    uri    = URI.parse 'https://api.rollbar.com/api/1/deploy/'
    params = {
      :local_username => rollbar_user,
      :access_token   => rollbar_token,
      :environment    => rollbar_env,
      :revision       => current_revision }

    request      = Net::HTTP::Post.new(uri.request_uri)
    request.body = JSON.dump(params)

    Net::HTTP.start(uri.host, uri.port, :use_ssl => true) do |http|
      http.request(request)
    end
  end
end
