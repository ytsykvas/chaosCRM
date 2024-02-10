# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.2.2'
gem 'importmap-rails'
gem 'pg', '~> 1.1'
gem 'puma', '>= 5.0'
gem 'rails', '~> 7.1.2'
gem 'sprockets-rails'
# gem "turbo-rails"
gem 'bootsnap', require: false
gem 'bootstrap', '~> 5.2'
gem 'font-awesome-sass', '~> 6.1'
gem 'jbuilder'
gem 'prawn' # for pdf export
gem 'pundit'
gem 'rails-i18n'
gem 'sassc'
gem 'sassc-rails'
gem 'simple_form', github: 'heartcombo/simple_form'
gem 'slim-rails'
gem 'spreadsheet' # for EXEL file export
gem 'stimulus-rails'
gem 'tzinfo-data', platforms: %i[windows jruby]
gem 'view_component'
gem 'will_paginate'
gem 'will_paginate-bootstrap'
gem 'will_paginate-bootstrap4'
gem 'awesome_rails_console'

group :development, :test do
  gem 'capybara-selenium' # MIT-License
  gem 'capybara-slow_finder_errors' # MIT-License
  gem 'cucumber-rails', require: false # MIT-License
  gem 'debug', platforms: %i[mri windows]
  gem 'devise'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rails-controller-testing'
  gem 'rspec-rails', '~> 6.1.0'
  gem 'rubocop', require: false
  gem 'selenium-webdriver' # Adds support for Capybara system testing and selenium driver
  gem 'shoulda-matchers', '~> 5.0'
end

group :development do
  gem 'web-console'
end

group :test do
  gem 'database_cleaner-active_record'
end
