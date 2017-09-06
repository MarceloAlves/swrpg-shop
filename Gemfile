ruby '2.4.1'
source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Main
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.10'
gem 'rails', '~> 5.1.3'
gem 'slim-rails'

# Assets
gem 'coffee-rails', '~> 4.2'
gem 'font-awesome-rails'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'
gem 'newrelic_rpm'
gem 'popper_js', '~> 1.12.3'
gem 'sass-rails', '~> 5.0'
gem 'tether-rails'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'
gem 'webpacker'

# Other
gem 'redis', '~> 3.0'
gem 'simple_form'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
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

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# gem 'therubyracer', platforms: :ruby

# gem 'bcrypt', '~> 3.1.7'
