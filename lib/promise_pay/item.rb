require "promise_pay/lib/dynamic_accessors"
require "json"

module PromisePay
  class Item
    attr_reader :id

    def initialize(id = nil, options = {})
      @id = id
      assign_instance_variables({'item' => options}) unless options.empty?
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
      resource_result.map do |result|
        self.class.new(nil, result)
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

    def assign_instance_variables(result)
      result.each do |attribute, value|
        if value.is_a?(Hash)
          value.each { |att, val| initialize_property(att, val) }
        else
          initialize_property(attribute, value)
        end
      end
      self
    end

    def initialize_property(attribute, value)
      attribute = attribute.gsub(/s$/, '_id') if ["buyers","sellers"].include? attribute
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
