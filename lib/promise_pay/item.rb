require "json"

module PromisePay
  class Item

    def self.find(item_id)
      new(item_id: item_id).query
    end

    def self.all
      new.query
    end

    def initialize(options = {})
      @item_id = options.fetch :item_id, nil
    end

    def query
      response = PromisePay::Request.new(path: path).execute

      JSON.parse(response)
    end

    private

    def path
      "items/#{item_id}"
    end

    attr_reader :item_id
  end
end
