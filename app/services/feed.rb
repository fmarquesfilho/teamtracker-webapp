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
    
    team_json = process_team_json(JSON.parse(team_str))
    
    result += team_json
    
    return sort(result).to_json
  end
  
  private
  def process_team_json(json)
    users = {}
    
    json.each do |obj|
      recipient_id = obj["event_recipient"][1..-1]
      sender_id = obj["user_id"]
      
      users[sender_id] ||= Membership.find_by(slack_id: obj["user_id"]).user
      obj["sender"] = users[sender_id].as_json
      add_avatar(obj["sender"])
      
      if obj["event_recipient"] == "!channel"
        users[recipient_id] = { name: 'Channel' }
      else
        users[recipient_id] ||= Membership.find_by(slack_id: recipient_id).user
      end
      
      obj["recipient"] = users[recipient_id].as_json
      add_avatar(obj["recipient"])
    end
  end
  
  def add_avatar(json)
    return json["avatar_url"] = "http://i60.tinypic.com/2j2dgqq.png" unless json['gh_login']
    json["avatar_url"] = "https://avatars.githubusercontent.com/" + json['gh_login']
  end
  
  def sort(json)
    json.sort_by { |x| Time.iso8601(x["event_time"]) }.reverse!
  end
end