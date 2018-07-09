source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2'

gem 'pg'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# JavaScript asset compiler
gem 'therubyracer', platforms: :ruby

# Gemfile
gem 'webpacker', '~> 3.4'

gem 'versionist'
gem 'swagger-blocks'

gem 'json_api_client'
gem 'colorize'
gem 'roar'
gem 'lev', '~> 9.0'
gem 'faraday'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false
gem 'jwt', '~> 1.5' # can't upgrade until openstax_accounts can update oauth2

gem 'a15k_interactions_api',
    git: 'https://github.com/a15k/interactions-api.git',
    glob: 'clients/0.1.0/ruby/*gemspec',
    ref: '510f2145e501625a541439a968c4f1d63ebe400c'

# do not remove: CoffeeScript is needed for openstax_accounts
gem 'coffee-rails', '~> 4.2'
# OpenStax Accounts integration
gem 'openstax_accounts', github: 'openstax/accounts-rails', branch: 'rails5'
gem 'openstax_api', github: 'openstax/openstax_api', branch: 'rails5'

gem "jquery-rails", "~> 4.3"

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'spring-commands-rspec'
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'dotenv-rails'
  gem 'guard-rspec', require: false
  gem 'faker' # Lorem Ipsum
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara'
  gem 'selenium-webdriver'
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem 'chromedriver-helper'
  gem 'database_cleaner'

  # load the client from it's relative path for testing
  gem 'a15k_client', path: './clients/1.0.0/ruby'

  gem "parallel_tests"
  gem "codecov", require: false
  gem "simplecov", require: false
end
