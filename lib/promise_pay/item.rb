require "promise_pay/lib/dynamic_accessors"
require "json"

module PromisePay
  class Item
    include Lib::DynamicAccessors

    attr_reader :id

    def initialize(options = {})
      @id = options[:id]
      assign_instance_variables({'item' => options})
    end

    class << self
      def find(id)
        new(id: id).find
      end

      def find_all
        new.find_all
      end
    end

    def find
      assign_instance_variables(resource_result)
      self
    end

    def find_all
      resource_result.map do |result|
        self.class.new(result)
      end
    end

    private

    def resource_result
      request = PromisePay::Request.new(path: api_resource)
      response = request.execute
      JSON.parse(response)["items"]
    end

    def api_resource
      "items/#{id}"
    end
  end
end
