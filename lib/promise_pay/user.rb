require "promise_pay/lib/dynamic_accessors"
require "json"

module PromisePay
  class User
    include Lib::DynamicAccessors

    attr_reader :id

    def initialize(id = nil, options = {})
      @id = id

      assign_instance_variables({'user' => options})
    end

    class << self
      def find(id)
        new(id).find
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
      resource_result["users"].map do |result|
        self.class.new(nil, result)
      end
    end

    private

    def resource_result
      request = PromisePay::Request.new(path: api_resource)
      response = request.execute
      JSON.parse(response)
    end

    def api_resource
      "users/#{id}"
    end
  end
end
