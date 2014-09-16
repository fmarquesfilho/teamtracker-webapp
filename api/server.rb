require 'rubygems'
require 'thin'
require 'json'
require 'rack'
require 'sinatra'
require "sinatra/reloader" if development?
require 'rack-livereload'

enable :sessions

require_relative '../app/session'
