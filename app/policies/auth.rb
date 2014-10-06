module Sinatra
  module AuthPolicy
    
    def self.registered(app)
      app.before '*' do
        content_type :json, charset: 'utf-8'
        response.headers['Access-Control-Allow-Origin'] = '*'
      end

      app.before /protected/ do
        halt 403, "Not authorized" unless authorized?
      end
    end
  end
  
  register AuthPolicy
end