require "json"

module PromisePay
  class Item
    PATH = "/items/"

    def self.find(item_id)
      new(item_id: item_id).query
    end

    def initialize(options = {})
      @item_id = options.fetch :item_id
    end

    def query
      response = PromisePay::Request.new(endpoint: endpoint).execute

      JSON.parse(response)
    end

    private

    def endpoint
      #API_ENDPOINT + PATH + user_id.to_s
      TEST_ENDPOINT + PATH + item_id.to_s
    end

    attr_reader :item_id
  end
end
