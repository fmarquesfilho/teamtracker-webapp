module Sinatra
  module HeadersPolicy
    
    def self.registered(app)
      app.before '*' do
        content_type :json, charset: 'utf-8'
        response.headers['Access-Control-Allow-Origin'] = $config['headers']['access_control_allow_origin']
        response.headers['Access-Control-Allow-Credentials'] = 'true'
      end
    end
  end
  
  register HeadersPolicy
end