ruby '2.6.5'
source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

# Main
gem 'pg', '~> 1.1'
gem 'puma'
gem 'rails', '~> 6.0.2'
gem 'slim-rails'

# Assets
gem 'bootstrap', '~> 4.3.0'
gem 'bootswatch', '4.3.1'
gem 'coffee-rails'
gem 'font-awesome-rails'
gem 'jbuilder', '~> 2.8'
gem 'jquery-rails'
gem 'newrelic_rpm'
gem 'popper_js', '~> 1.14.3'
gem 'premailer-rails'
gem 'react-rails'
gem 'sass-rails', '>= 6'
gem 'tether-rails'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'
gem 'webpacker', '~> 4.0'

# Other
gem 'devise'
gem 'redis', '~> 4.0'
gem 'simple_form', '4.1.0'
gem 'stripe'
gem 'stripe_event'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'capybara'
  gem 'dotenv-rails'
  gem 'rspec-rails'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end

group :production do
  gem 'sentry-raven'
end

group :development do
  gem 'annotate'
  gem 'listen'
  gem 'pry-rails'
  gem 'spring'
  gem 'spring-watcher-listen'
  gem 'web-console'
end

gem 'fakeredis', group: :test

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

gem 'bootsnap', '>= 1.4.2', require: false

# gem 'therubyracer', platforms: :ruby
