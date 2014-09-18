module Sinatra
  module TeamController
    
    module Helpers
      
    end

    def self.registered(app)
      app.helpers TeamController::Helpers

      app.get '/feed/:team' do
        Feed.new(team: params[:team], user: current_user_id).get
      end
    end
  end
  
  register TeamController
end