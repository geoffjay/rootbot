source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.0'

gem 'bootsnap', '>= 1.4.4', require: false
gem 'jbuilder', '~> 2.7'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rails', '~> 6.1.4', '>= 6.1.4.1'
gem 'redis', '~> 4.0'
gem 'sass-rails', '>= 6'
gem 'sidekiq'
gem 'tailwindcss-rails', '~> 0.5.4'
gem 'turbolinks', '~> 5'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
gem 'webpacker', '~> 5.4.0'

# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
end

group :development do
  gem 'listen', '~> 3.3'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'rubocop', require: false
  gem 'rubocop-rails', require: false
  gem 'spring'
  gem 'web-console', '>= 4.1.0'
end

group :test do
  gem 'capybara', '>= 3.26'
  gem 'database_cleaner'
  gem 'factory_bot_rails', '~> 4.0'
  gem 'faker'
  gem 'rspec-rails'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers', '~> 3.1'
  gem 'webdrivers'
end
