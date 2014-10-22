module Sinatra
  module AuthPolicy
    
    def self.registered(app)
      app.before /protected/ do
        #halt 403, "Not authorized" unless authorized?
      end
    end
  end
  
  register AuthPolicy
end