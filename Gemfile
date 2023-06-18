source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.7.6"
gem "rails", "~> 7.0.4"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "jbuilder"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false
gem 'dotenv-rails', '~> 2.1', '>= 2.1.1'

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem "rack-cors"

group :development do
  gem "web-console"
end

group :development, :test do
  gem 'rspec-rails'
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'factory_girl_rails'
  gem 'factory_bot'
  gem 'faker'
end
