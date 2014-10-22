require 'rubygems'
require 'thin'
require 'json'
require 'rack'
require 'sinatra'
require "sinatra/reloader" if development?
require "sinatra/activerecord"
require 'active_support/all'
require "yaml"
require 'sinatra/cross_origin'

require 'rack-livereload'

require "rack/csrf"

def require_all(_dir)
  Dir[File.expand_path(File.join(File.dirname(File.absolute_path(__FILE__)), _dir)) + "/**/*.rb"].each do |file|
    require file
  end
end

#use Rack::Csrf, :raise => true
set :protection, :except => :json_csrf

require_all('../config/')

configure do
  #To enable cross domain requests
  enable :cross_origin

  set :allow_origin, Settings.app_url
  set :allow_methods, [:head, :get, :post, :options, :delete, :put]
  set :allow_credentials, true
  set :max_age, "86400"
  set :allow_headers, ['*', 'Content-Type', 'Origin', 'Accept', 'X-Requested-With', 'x-xsrf-token']
  set :expose_headers, ['Content-Type']

  set :protection, :origin_whitelist => [Settings.app_url] 

  enable :logging

end

require_all('../app/models')
require_all('../app/services')
require_all('../app/policies')

enable :sessions

set :session_secret, Settings.session_secret

set :database, Settings.database[:name]
set :aggregator_url, Settings.aggregator_url

require_relative './controllers/session_controller'

require_all('./controllers')

