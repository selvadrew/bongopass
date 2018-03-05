class Rack::Attack
  Rack::Attack.cache.store = ActiveSupport::Cache::MemoryStore.new 

  throttle('api/ip', limit: 3, period: 10) do |req|
    req.ip if req.subdomain == 'api'
  end

  throttle('logins_ip', limit: 5, period: 20.seconds) do |req|
    if req.path == '/login' && req.post? 
    	req.params['email'].presence 
    end
  end

  throttle('req/ip', :limit => 500, :period => 5.minutes) do |req|
    req.ip # unless req.path.start_with?('/assets')
  end


  class Request < ::Rack::Request
    def subdomain
      host.split('.').first
    end
  end
end