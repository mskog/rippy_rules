module RippyRules
  class Client
    include HTTParty
    base_uri "https://what.cd"
    maintain_method_across_redirects
    format :json

    def initialize(username, password)
      @username = username
      @password = password
      authenticate
    end

    def method_missing(method, *params)
      raise APIError unless params.first.is_a?(Hash)
      perform_request(method.to_s,params.first)
    end

    def perform_request(method, query={})
      self.class.get("/ajax.php?action=#{method}", :query => query)
    end

    private

    def authenticate
      body = {:username => @username, :password => @password, :keeplogged => 1}
      response = self.class.post('/login.php', :body => body, :follow_redirects => false)
      raise AuthenticationError if response.headers['set-cookie'].nil?
      cookies(response.headers['set-cookie'])
    end

    def cookies(cookie)
      cookie_jar = HTTParty::CookieHash.new
      cookie_jar.add_cookies cookie
      self.class.cookies cookie_jar
    end
  end
  class AuthenticationError < StandardError; end
  class APIError < StandardError; end
end