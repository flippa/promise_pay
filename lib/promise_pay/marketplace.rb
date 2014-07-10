require "json"

module PromisePay
  class Marketplace

    def initialize(options = {})
      @user     = options.fetch :user
      @password = options.fetch :password
    end

    def request_token
      response = PromisePay::Request.new(
        path:     path,
        user:     user,
        password: password
      ).execute

      JSON.parse(response)["token"]
    end

    private

    def path
      "request_token"
    end

    attr_reader :user
    attr_reader :password
  end
end
