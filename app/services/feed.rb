class Feed
  class << self
    def process(*args)
      @@processors = *args
    end
  end
  
  @@processors = []
  
  process :sort
  
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
    
    puts team_str
    
    result += JSON.parse(team_str)
    
    return execute_process(result)
  end
  
  def execute_process(json)
    @@processors.each do |p|
      json = send(p, json)
    end
    
    return json.to_json
  end
  
  def sort(json)
    json.sort_by { |x| Time.iso8601(x["event_time"]) }.reverse!
  end
end