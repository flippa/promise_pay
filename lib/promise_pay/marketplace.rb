require "json"

module PromisePay
  class Marketplace

    attr_reader :token

    def initialize(options = {})
      @user     = options.fetch :user
      @password = options.fetch :password
    end

    def request_token
      response = PromisePay::Request.new(
        path:     api_resource,
        user:     user,
        password: password
      ).execute

      @token = JSON.parse(response)["token"]
      token
    end

    private

    def api_resource
      "request_token"
    end

    attr_reader :user
    attr_reader :password
  end
end
