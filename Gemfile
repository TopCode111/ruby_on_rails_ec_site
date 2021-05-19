source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.0'
# Use sqlite3 as the database for Active Record
gem 'pg', '~> 1.1'
# Use Puma as the app server
gem 'puma', '~> 4.3'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'

gem 'pry-rails', '~> 0.3.6'

gem 'devise', '~> 4.5'

gem 'activeadmin'

gem 'carrierwave', '~> 1.2'
gem 'fog-aws'

gem 'rmagick'
gem 'chosen-rails'

#soft delete
gem "paranoia", "~> 2.2"
gem 'rails-i18n'

gem 'kaminari'

#payment method
gem 'stripe'

gem 'dotenv-rails'
gem "cocoon"

gem 'draper', github: 'drapergem/draper'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false
gem 'slim'
gem 'bootstrap', '~> 4.1.3'
gem 'jquery-rails'
gem 'clipboard-rails'
gem "font-awesome-rails"
gem 'airbrake', '~> 7.3'

#client-side vallidation
gem 'parsley-rails', '~> 2.7'

#search
gem 'pg_search', '~> 2.1'

#breadcrumbs
gem 'gretel'

#slug
gem 'friendly_id', '~> 5.2.0'

#active admin theme
gem 'arctic_admin'
gem 'delayed_job_active_record'
gem "daemons"


#comment
gem 'acts_as_commentable_with_threading'


#follow
gem 'acts_as_follower', github: 'tcocca/acts_as_follower', branch: 'master'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails', '~> 3.8'
  gem 'letter_opener'
  gem "rubocop-rails_config"
  gem 'factory_bot_rails'
  gem 'shoulda-matchers', '4.0.0.rc1'
  gem 'rails-controller-testing'
  gem 'simplecov', require: false
  gem 'simplecov-rcov'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'html2slim'
  gem 'capistrano'
  gem 'capistrano-rails'
  gem 'capistrano-rvm'
  gem 'capistrano-bundler'
  gem "annotate"
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15', '< 4.0'
  gem 'selenium-webdriver'
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem 'chromedriver-helper'
  gem 'database_cleaner'
  gem 'rubocop-rspec'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
