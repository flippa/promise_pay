require "promise_pay/operators/find"
require "promise_pay/lib/dynamic_accessors"
require "json"

module PromisePay
  class User
    include Operators::Find

    attr_reader :id

    def initialize(id = nil)
      @id = id
    end

    def fetch
      request = PromisePay::Request.new(path: api_resource)
      response = request.execute
      result = JSON.parse(response)

      assign_instance_variables(result)
      self
    end

    private

    def api_resource
      "users/#{id}"
    end

    def assign_instance_variables(result)
      result["user"].each do |attribute, value|
        if value.is_a?(Hash)
          value.each { |att, val| initialize_property(att, val) }
        else
          initialize_property(attribute, value)
        end
      end
      self
    end

    def initialize_property(attribute, value)
      Lib::DynamicAccessors.define_accessor(attribute, value, self) unless accessor_defined?(attribute)
      set_property(attribute, value)
    end

    def accessor_defined?(attribute)
      respond_to?(attribute) && respond_to?("#{attribute}=")
    end

    def set_property(attribute, value)
      setter_method = "#{attribute}="
      self.send(setter_method, value)
    end
  end
end
