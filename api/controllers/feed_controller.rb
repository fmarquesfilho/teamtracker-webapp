require 'rest-client'

module Sinatra
  module TeamController
    
    module Helpers
      
    end

    def self.registered(app)
      app.helpers TeamController::Helpers
 
      app.get '/protected/feed/:team' do
        content_type :json
        Feed.new({team: params[:team]}, settings.aggregator_url).get
      end
    end
  end
  
  register TeamController
end