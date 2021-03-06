source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.1'
# Use mysql as the database for Active Record
gem 'mysql2'
gem 'pg'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
# gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
#gem 'bcrypt-ruby', '3.1.5', :require => 'bcrypt'
gem 'bcrypt', git: 'https://github.com/codahale/bcrypt-ruby.git', :require => 'bcrypt'
gem 'rails_12factor'
# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
gem 'elasticsearch'
gem 'elasticsearch-model'
gem 'elasticsearch-persistence', require: 'elasticsearch/persistence/model'
gem 'elasticsearch-api'
gem 'elasticsearch-transport'
gem 'elasticsearch-dsl'
gem 'devise'
gem 'devise-bootstrap-views'
gem 'to_bool'
gem 'hashie'
group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :heroku do
  ruby '2.3.3'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'wdm', '>= 0.1.0' if Gem.win_platform?
gem 'rails-i18n'
gem 'multi-select-rails'

gem 'sprockets', '~> 3.7', '>= 3.7.1'
gem 'bootstrap-sass', '~> 3.3', '>= 3.3.7'
gem 'bootstrap-social-rails', '~> 4.12'
gem 'jquery-datatables-rails', '~> 3.4'
gem 'flot-rails', '~> 0.0.7'
gem 'font-awesome-rails', '~> 4.7', '>= 4.7.0.2'
gem 'jquery-rails', '~> 4.3', '>= 4.3.1'
gem 'jquery-ui-rails', '~> 6.0', '>= 6.0.1'
gem 'morris.js-rails'
gem 'raphael-rails', '~> 2.1', '>= 2.1.2'
gem 'd3_rails', '~> 4.1', '>= 4.1.1'
gem 'highcharts-rails', '~> 5.0', '>= 5.0.7'
