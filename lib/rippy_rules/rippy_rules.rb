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

    def search(str)
      browse({searchstr: str})
    end

    def method_missing(method, *params)
      first_param = params.first
      raise APIError unless first_param.is_a?(Hash)
      perform_request(method.to_s,first_param)
    end

    def perform_request(method, query={})
      self.class.get("/ajax.php", :query => query.merge({action: method}))
    end

    private

    def authenticate
      body = {username: @username, password: @password, keeplogged: 1}
      response = login(body)
      cookies(response.headers['set-cookie'])
    end

    def login(body)
      response = self.class.post('/login.php', :body => body, :follow_redirects => false)
      raise AuthenticationError if response.headers['set-cookie'].nil?
      response
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