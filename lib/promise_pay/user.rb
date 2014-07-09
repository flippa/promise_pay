require "json"

module PromisePay
  class User
    PATH = "/users/"

    def self.find(user_id)
      new(user_id: user_id).query
    end

    def self.all
      new.query
    end

    def initialize(options = {})
      @user_id = options.fetch :user_id, nil
    end

    def query
      response = PromisePay::Request.new(endpoint: endpoint).execute

      JSON.parse(response)
    end

    private

    def endpoint
      #API_ENDPOINT + PATH + user_id.to_s
      TEST_ENDPOINT + PATH + user_id.to_s
    end

    attr_reader :user_id
  end
end
