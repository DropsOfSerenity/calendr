source 'https://rubygems.org'
source 'https://rails-assets.org'

# angular stuff
gem 'angular-rails-templates'
gem 'angular_rails_csrf'

# rails stuff
gem 'rails', '4.1.8'
gem 'pusher'
gem 'devise'
gem 'rabl'
gem 'newrelic_rpm'
gem 'pg'
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'unicorn'
gem 'sdoc', '~> 0.4.0',          group: :doc
gem 'pickadate-rails'
gem 'font-awesome-rails'

# rails assets
#
# === ANGULAR BREAKING BUG ===
# https://github.com/angular/angular.js/issues/9128
# I'm using a monkey patched version of angular until they get their stuff
# together and fix this bug.
#
# gem 'rails-assets-angular', '=1.3.8'
#
gem 'rails-assets-animate.css'
gem 'rails-assets-angular-ui-router'
gem 'rails-assets-angular-animate', '=1.3.8'
gem 'rails-assets-angular-devise'
gem 'rails-assets-angular-messages', '=1.3.8'
gem 'rails-assets-hammerjs'
gem 'rails-assets-angular-aria'
gem 'rails-assets-moment'
gem 'rails-assets-angular-material', '0.8.0'
gem 'rails-assets-pusher'
gem 'rails-assets-pusher-angular'
gem 'rails-assets-lodash'
gem 'rails-assets-restangular'
gem 'rails-assets-spectrum'

group :development do
  gem 'spring'
end

group :development, :test do
  gem 'web-console'
  gem 'byebug'
  gem 'database_cleaner'
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'rspec-rails'
  gem 'teaspoon'
  gem 'factory_girl_rails'
  gem 'faker'
end

group :test do
  gem 'pusher-fake'
end

group :production do
  gem 'rails_12factor'
  gem 'rails_serve_static_assets'
  gem 'heroku-deflater'
end
