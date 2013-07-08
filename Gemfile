source "https://rubygems.org"
ruby "1.9.3"

# Server requirements
# gem 'thin' # or mongrel
# gem 'trinidad', :platform => 'jruby'

# Project requirements
gem 'rake'
gem 'sinatra-flash', :require => 'sinatra/flash'

# Component requirements
gem 'bcrypt-ruby', :require => 'bcrypt'
gem 'bcrypt-ruby', :require => "bcrypt"
gem 'sass'
gem 'haml'
gem 'activerecord', "3.2.13", :require => "active_record"


group :production do
  gem 'pg'
end

group :development do
  gem 'pg'
end

# Test requirements
gem 'rspec', :group => "test"
gem 'rack-test', :require => "rack/test", :group => "test"

# Padrino Stable Gem
gem 'padrino', "0.11.2"

gem 'twitter'

# Or Padrino Edge
# gem 'padrino', :git => 'git://github.com/padrino/padrino-framework.git'

# Or Individual Gems
# %w(core gen helpers cache mailer admin).each do |g|
#   gem 'padrino-' + g, '0.10.7'
# end
