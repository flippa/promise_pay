require "json"

module PromisePay
  class User

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
      response = PromisePay::Request.new(path: path).execute

      JSON.parse(response)
    end

    private

    def path
      "users/#{user_id}"
    end

    attr_reader :user_id
  end
end
