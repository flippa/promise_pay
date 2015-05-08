require "promise_pay/lib/dynamic_accessors"
require "json"

module PromisePay
  class ItemStatus
    include Lib::DynamicAccessors

    attr_reader :id

    def initialize(id = nil, options = {})
      @id = id

      assign_instance_variables({'item' => options})
    end

    class << self
      def find(id)
        new(id).find
      end
    end

    def find
      assign_instance_variables(resource_result)
      self
    end

    private

    def resource_result
      request = PromisePay::Request.new(path: api_resource)
      response = request.execute
      JSON.parse(response)["items"]
    end

    def api_resource
      "items/#{id}/status"
    end
  end
end
