require "rest_client"
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
      request = RestClient::Request.new(
        method:   :get,
        url:      end_point,
        user:     user,
        password: password,
        headers:  { accept: :json, content_type: :json }
      )

      begin
        response = request.execute
      rescue RestClient::Unauthorized => e
        raise ::PromisePay::MarketplaceInitializationError, e.message
      end

      token = ::JSON.parse(response)["token"]
      puts "Your marketplace token is: #{token} (Store this securely)"
    end

    private

    def end_point
      #API_ENDPOINT + PATH
      TEST_ENDPOINT + PATH
    end

    attr_reader :user
    attr_reader :password
  end

  class MarketplaceInitializationError < StandardError; end
end
