# Railsworks
[![Build Status](https://secure.travis-ci.org/kurtisnelson/railsworks.png)](http://travis-ci.org/kurtisnelson/railsworks)
[![Gem Version](https://badge.fury.io/rb/railsworks.png)](http://badge.fury.io/rb/railsworks)
[![Code Climate](https://codeclimate.com/github/kurtisnelson/railsworks.png)](https://codeclimate.com/github/kurtisnelson/railsworks)
[![Coverage Status](https://coveralls.io/repos/kurtisnelson/railsworks/badge.svg)](https://coveralls.io/r/kurtisnelson/railsworks)
[![Dependency Status](https://gemnasium.com/kurtisnelson/railsworks.png)](https://gemnasium.com/kurtisnelson/railsworks)
[Documentation](http://rubydoc.info/gems/railsworks/)

Useful rake tasks for rails apps deployed via Amazon OpsWorks

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'railsworks'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install railsworks

Import the tasks by adding a line to your Rakefile:

```ruby
require 'railsworks/tasks'
```

Create `config/opsworks.yml` with the IDs from OpsWorks

```
production:
   us-east-1:
     stack_id: "84b1f7e9-bf0a-4c22-8bd9-e95b77347017"
     layer_id: "648680a9-a124-47b5-a05d-9db89f94147d"
     app_id: "997aaf39-f92e-4f6e-884a-f4a7534e84a3"
```

## Usage

To deploy to your production environment with migrations

    $ rake deploy:production

To open a rails console on production

    $ rake console:production

## Contributing

1. Fork it ( https://github.com/[my-github-username]/railsworks/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
