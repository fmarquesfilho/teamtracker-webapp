module Sinatra
  module TeamController
    
    module Helpers
      
    end

    def self.registered(app)
      app.helpers TeamController::Helpers

      app.get '/protected/teams' do
        content_type :json
        return Team.all.to_json
      end
      
      app.get '/protected/teams/:team' do
        content_type :json
        return Team.find(params[:team]).to_json
      end
      
      app.post '/protected/teams' do
        content_type :json
        puts params.inspect
        team = Team.find_by(name: params[:name]) || 
          Team.create(name: params[:name], gh_organization: params[:gh_organization], slack_team_id: params[:slack_team_id])
        
        Membership.create(user_id: current_user.id, team_id: team.id) if Membership.find_by(user_id: current_user.id, team_id: team.id).nil?
        return { success_url: Settings.app_url + "/styleguide.html" }.to_json
      end
      
      app.get '/protected/teams/:team/members' do
        content_type :json
        return Team.find(params[:team]).users.to_json
      end

      app.post '/protected/teams/:team/members' do
        content_type :json
        Membership.create(team_id: params[:team], user_id: params[:user_id])
        return 200
      end
    end
  end
  
  register TeamController
end