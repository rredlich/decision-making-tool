# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

gem 'sinatra', require: %w(sinatra/base sinatra/reloader)
gem 'sinatra-contrib'
gem "puma"

group :development do
    gem "byebug"
    gem 'tux'
    gem "sqlite3", "~> 1.4"
end

group :production do 
    gem "pg" # Needed for postgresql on Heroku
end


gem "sinatra-activerecord", "~> 2.0"
gem "rake", "~> 13.0"
