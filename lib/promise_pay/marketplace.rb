require "json"

module PromisePay
  class Marketplace
    PATH = "/request_token"

    def self.initialize(options = {})
      new(options).request_token
    end

    def initialize(options = {})
      @user     = options.fetch :user
      @password = options.fetch :password
    end

    def request_token
      response = PromisePay::Request.new(
        endpoint:   endpoint,
        user:       user,
        password:   password
      ).execute

      token = ::JSON.parse(response)["token"]
      puts "Your marketplace token is: #{token} (Store this securely)"
    end

    private

    def endpoint
      #API_ENDPOINT + PATH
      TEST_ENDPOINT + PATH
    end

    attr_reader :user
    attr_reader :password
  end
end
