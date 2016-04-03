source 'https://rubygems.org'

# rails
gem 'rails', '~> 4.2.5'

# gems that have to be in order
gem 'twitter-bootstrap-rails'
gem 'bootstrap-generators'

# the rest
gem 'annotate'
gem 'attr_encrypted'
gem 'coffee-rails', '~> 4.0.0'
gem 'database_cleaner'
gem 'devise'
gem 'execjs'
gem 'figaro'
gem 'font-awesome-rails'
gem 'i18n'
gem 'jquery-rails'
gem 'mechanize'
gem 'pg'
gem 'paranoia'
gem 'puma'
gem 'ransack'
gem 'rolify'
gem 'rollbar'
gem 'sass-rails', '>= 3.2'
gem 'scenic'
gem 'sidekiq'
gem 'sidekiq-rate-limiter', require: 'sidekiq-rate-limiter/server'
gem 'sidekiq-scheduler'
gem 'sinatra', require: nil
gem 'uglifier', '>= 1.3.0'
gem 'will_paginate'

gem 'lending_club',
  github: 'lendinghedge/lending_club'
  # path: '../lending_club'

group :development do
  gem 'better_errors'
  gem 'guard-rspec'
  gem 'guard-zeus'
  gem 'quiet_assets'
  gem 'pry'
  gem 'pry-doc'
  gem 'shoulda-matchers'
  gem 'spring'
  gem 'binding_of_caller'
end

group :development, :test do
  gem 'capybara'
  gem 'factory_girl_rails'
  gem 'rspec-rails'

  gem 'capistrano', '~> 3.1'
  gem 'capistrano-bundler', '~> 1.1.2'
  gem 'capistrano-sidekiq'
  gem 'capistrano-rails', '~> 1.1'
  gem 'capistrano-rbenv', '~> 2.0'
  gem 'capistrano3-puma', github: 'seuros/capistrano-puma'
  gem 'slackistrano'
end
