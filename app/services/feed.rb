class Feed
  def initialize(params, aggregator_url)
    @team = Team.find(params[:team])
    @repos = @team.repos
    @aggregator_url = aggregator_url
  end
  
  def get
    result = []
    
    @repos.each do |repo|
      repo_str = RestClient.get("http://#{@aggregator_url}/api/repos/#{repo.full_name}")
      repo_hash = JSON.parse(repo_str)
      result += repo_hash
    end    
    
    team_str = RestClient.get("http://#{@aggregator_url}/api/teams/#{@team.slack_team_id}")
    
    result += JSON.parse(team_str)
    
    return result.to_json
  end
  
end