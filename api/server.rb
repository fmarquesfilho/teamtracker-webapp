require 'rubygems'
require 'thin'
require 'json'
require 'rack'
require 'sinatra'
require "sinatra/reloader" if development?
require "sinatra/activerecord"
require "yaml"

require 'rack-livereload'

require "rack/csrf"

use Rack::Csrf, :raise => true

def require_all(_dir)
  Dir[File.expand_path(File.join(File.dirname(File.absolute_path(__FILE__)), _dir)) + "/**/*.rb"].each do |file|
    require file
  end
end

$config = YAML.load_file('config/environments/development.yml')

require_all('../app/models')
require_all('../app/services')
require_all('../app/policies')

enable :sessions

set :session_secret, $config['session_secret']

set :database, $config['database']['name']
set :aggregator_url, $config['aggregator_url']

require_relative './controllers/session_controller'

require_all('./controllers')

