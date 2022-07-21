require 'rubygems'
require 'securerandom'

# require all of the gems in the gemfile
require 'bundler'
Bundler.require(:default, ENV.fetch('RACK_ENV', 'development'))

require './app'
use Rack::MethodOverride

run MyApp
