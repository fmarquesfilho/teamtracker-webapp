require 'rubygems'
require 'thin'
require 'json'
require 'rack'
require 'sinatra'
require "sinatra/reloader" if development?
require "sinatra/activerecord"
require 'active_support/all'
require "yaml"

require 'rack-livereload'

require "rack/csrf"

use Rack::Csrf, :raise => true


def require_all(_dir)
  Dir[File.expand_path(File.join(File.dirname(File.absolute_path(__FILE__)), _dir)) + "/**/*.rb"].each do |file|
    require file
  end
end

require_all('../config/')
require_all('../app/models')
require_all('../app/services')
require_all('../app/policies')

enable :sessions

set :session_secret, Settings.session_secret

set :database, Settings.database[:name]
set :aggregator_url, Settings.aggregator_url

require_relative './controllers/session_controller'

require_all('./controllers')

