require 'rake'

module Railsworks
  class Tasks
    include Rake::DSL if defined? Rake::DSL
    def install_tasks
      load 'railsworks/tasks/deploy.rake'
      load 'railsworks/tasks/console.rake'
      load 'railsworks/tasks/rollbar.rake'
    end
  end
end
Railsworks::Tasks.new.install_tasks
