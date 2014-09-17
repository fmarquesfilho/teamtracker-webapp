module Sinatra
  module TeamController
    
    module Helpers
      
    end

    def self.registered(app)
      app.helpers TeamController::Helpers

      app.get '/teams' do
        content_type :json
        return Team.all.to_json
      end
      
      app.get '/teams/:team' do
        content_type :json
        return Team.find(params[:team]).to_json
      end
      
      app.post '/teams' do
        content_type :json
        Team.create(name: params[:name], organization: params[:organization])
        return 200
      end
      
      app.get '/teams/:team/members' do
        content_type :json
        return Team.find(params[:team]).users.to_json
      end

      app.post '/teams/:team/members' do
        content_type :json
        Membership.create(team_id: params[:team], user_id: params[:user_id])
        return 200
      end
    end
  end
  
  register TeamController
end