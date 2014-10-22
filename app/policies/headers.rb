module Sinatra
  module HeadersPolicy
    
    def self.registered(app)
      app.before '/*' do
        headers['Access-Control-Allow-Origin'] = Settings.app_url
        headers['Access-Control-Allow-Methods'] = "GET, POST, PUT, DELETE, OPTIONS"
        headers['Access-Control-Allow-Headers'] ="accept, authorization, origin, content-type, X-PINGOTHER"
        "*"
      end

      app.options "/*" do
        headers['Access-Control-Allow-Origin'] = Settings.app_url
        headers['Access-Control-Allow-Methods'] = "GET, POST, PUT, DELETE, OPTIONS"
        headers['Access-Control-Allow-Headers'] ="accept, authorization, origin, content-type, X-PINGOTHER"
        "*"
      end
    end
  end
  
  register HeadersPolicy
end