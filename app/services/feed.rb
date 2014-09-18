class Feed
  def initialize(params)
    @membership = Membership.find(user_id: params[:user], team_id: params[:user])
    @team = @membership.team
    @user = @membership.user
    @repos = @team.repos
  end
  
  #TODO implement pagination
  def get
    result = ""
    
    @repos.each do |repo|
      result += RestClient.get("http://#{settings.aggregator_url}/#{repo}").body
    end
    
    return JSON.parse(result)
  end
  
  def aggregate
     
  end
end