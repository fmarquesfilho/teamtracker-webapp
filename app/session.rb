require 'octokit'

#use Rack::Session::Pool, :expire_after => 2592000
module Sinatra
  module Session
    
    module Helpers
      def authorized?
        session[:access_token]
      end

      def authorize_url
        return Octokit::Client.new.authorize_url(client_id, scope: 'public_repo, user')
      end

      def login(code)
        session[:access_token] = Octokit.exchange_code_for_token(params[:code], client_id, client_secret)[:access_token]
      end

      def current_user
        @user ||= Octokit::Client.new(access_token: session[:access_token]).user
      end

      def client_id
        ENV['GH_BASIC_CLIENT_ID']
      end

      def client_secret
        ENV['GH_BASIC_SECRET_ID']
      end
    end

    def self.registered(app)
      app.helpers Session::Helpers

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
  
  register Session
end