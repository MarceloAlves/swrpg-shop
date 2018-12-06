ruby '2.5.0'
source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

# Main
gem 'pg', '~> 1.1'
gem 'puma', '~> 3.12'
gem 'rails', '~> 5.2.1'
gem 'slim-rails'

# Assets
gem 'bootstrap', '~> 4.1.3'
gem 'bootswatch'
gem 'coffee-rails', '~> 4.2'
gem 'font-awesome-rails'
gem 'jbuilder', '~> 2.8'
gem 'jquery-rails'
gem 'newrelic_rpm'
gem 'popper_js', '~> 1.14.3'
gem 'premailer-rails'
gem 'react_on_rails', '11.2.0'
gem 'sass-rails', '~> 5.0'
gem 'tether-rails'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'
gem 'webpacker'

# Other
gem 'devise'
gem 'redis', '~> 4.0'
gem 'simple_form'
gem 'stripe'
gem 'stripe_event'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'capybara'
  gem 'chromedriver-helper'
  gem 'dotenv-rails'
  gem 'rspec-rails', '~> 3.8'
  gem 'selenium-webdriver'
end

group :production do
  gem 'sentry-raven'
end

group :development do
  gem 'annotate'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'pry-rails'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

gem 'fakeredis', group: :test

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

gem 'bootsnap', '1.3.2', require: false

# gem 'therubyracer', platforms: :ruby
