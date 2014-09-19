require 'rubygems'
require 'thin'
require 'json'
require 'rack'
require 'sinatra'
require "sinatra/reloader" if development?
require "sinatra/activerecord"

require 'rack-livereload'

def require_all(_dir)
  Dir[File.expand_path(File.join(File.dirname(File.absolute_path(__FILE__)), _dir)) + "/**/*.rb"].each do |file|
    require file
  end
end

require_all('../app/models')
require_all('../app/services')
require_all('../app/policies')

enable :sessions

require_relative './controllers/session_controller'

set :database, "sqlite3:tt.db"
set :aggregator_url, "colabore.herokuapp.com"

require_all('../app/controllers')

