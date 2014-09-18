require 'octokit'

#use Rack::Session::Pool, :expire_after => 2592000
module Sinatra
  module SessionController
    
    module Helpers
      def authorized?
        Session.new(session).authorized?
      end

      def authorize_url
        Session.new(session).authorize_url
      end

      def login(code)
        Session.new(session).login(code)
      end

      def current_gh_user
        Session.new(session).current_gh_user
      end
      
      def current_user
        Session.new(session).current_user
      end
    end

    def self.registered(app)
      app.helpers SessionController::Helpers

      app.get '/login_url' do
        content_type :json
        return { url: authorize_url }.to_json
      end

      app.get '/callback' do
        content_type :json
        login(params[:code])
        return current_user.name
      end

      app.get '/profile' do
        content_type :json
        return { 
          user: current_user.to_attrs
        }.to_json
      end
    end
  end
  
  register SessionController
end