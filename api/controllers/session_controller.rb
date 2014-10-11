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
      
      def octokit_client
        Session.new(session).octokit_client
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
        redirect params[:redirect_to]
      end

      app.get '/protected/profile' do
        content_type :json
        
        orgs = { orgs: octokit_client.organizations }
        
        orgs[:orgs].each do |org|
          org[:repos] = octokit_client.repositories(org.login)
        end
        
        return { 
          user: current_gh_user.to_attrs
          .merge(orgs)
        }.to_json
      end
    end
  end
  
  register SessionController
end