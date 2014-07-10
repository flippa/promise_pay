require "json"

module PromisePay
  class Marketplace

    def initialize(options = {})
      @user     = options.fetch :user
      @password = options.fetch :password
      @request  = build_request
    end

    def request_token
      response = request.execute

      JSON.parse(response)["token"]
    end

    private

    def build_request
      PromisePay::Request.new(
        path:     path,
        user:     user,
        password: password
      )
    end

    def path
      "request_token"
    end

    attr_reader :user
    attr_reader :password
    attr_reader :request
  end
end
