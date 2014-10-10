class Session
  def initialize(session)
    @session = session
  end
  
  def authorized?
    @session[:access_token]
  end

  def login(code)
    @session[:access_token] = Octokit.exchange_code_for_token(code, client_id, client_secret)[:access_token]
    
    user = current_gh_user
    User.create(name: user.login, gh_login: user.login) if current_user.nil?
  end

  def current_gh_user
    @current_gh_user ||= Octokit::Client.new(access_token: @session[:access_token]).user
  end

  def current_user
    User.find_by(gh_login: current_gh_user.login)
  end

  def authorize_url
    return Octokit::Client.new.authorize_url(client_id, scope: 'repo, user, read:org')
  end
  
  def client_id
    ENV['GH_BASIC_CLIENT_ID']
  end

  def client_secret
    ENV['GH_BASIC_SECRET_ID']
  end
end