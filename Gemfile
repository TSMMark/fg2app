source 'https://rubygems.org'

gem 'rails', '3.2.13'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

group :development do
  gem "nifty-generators"
end

group :development, :test do
	gem 'sqlite3'
	gem 'commands'

  # rspec testing suite
  gem 'rspec-rails', '~> 2.0'
  # factory girl !
  gem "factory_girl_rails", "~> 4.0"

  # used to clean the test database before specs
  gem "database_cleaner", "~> 1.0.1"

end


group :test do
  #gem 'faker'
  #gem 'capybara'
  gem 'guard-rspec'
  gem 'launchy'
  gem "mocha", :require => false
end


group :production do
	gem 'pg'
end


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'coffee-rails', '~> 3.2.1'

  #gem 'sass-rails',   '~> 3.2.3'
  #gem 'bootstrap-sass', '~> 2.2.2.0'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'sass-rails',   '~> 3.2.3'
gem 'bootstrap-sass', '~> 2.2.2.0'


gem 'font-awesome-rails'

gem 'jquery-rails'

gem "strip_attributes", "~> 1.2"

# Slim, html slimmifier
gem 'slim'

# set ENV variables from this gem
gem 'figaro'

# authenticate
gem 'devise'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'oauth2'

# authorize
gem 'cancan'
# hide attrs to certain user groups
gem 'strong_parameters'
gem 'cancan_strong_parameters'

# facebook graph API
gem 'fbgraph'

# for sorting widget order in a tab
gem 'acts_as_list'

# backbone.js
gem 'backbone-on-rails'

# allow getting by symbol or string in hash
gem 'insensitive_hash'

# API attributes
gem 'acts_as_api'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'

