require "json"

module PromisePay
  class Marketplace

    def self.initialize(options = {})
      new(options).request_token
    end

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

      token = ::JSON.parse(response)["token"]
      puts "Your marketplace token is: #{token} (Store this securely)"
    end

    private

    def path
      "request_token"
    end

    attr_reader :user
    attr_reader :password
  end
end
