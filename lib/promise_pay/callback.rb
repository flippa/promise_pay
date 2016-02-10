require "promise_pay/lib/dynamic_accessors"
require "json"

module PromisePay
  class Callback
    include Lib::DynamicAccessors

    ENDPOINT = 'callbacks'

    attr_reader :id
    attr_reader :url
    attr_reader :description
    attr_reader :object_type
    attr_reader :enabled

    def self.create(options = {})
      new(options).create
    end

    def initialize(options = {})
      @url          = options.fetch(:url)
      @description  = options.fetch(:description) { "" }
      @object_type  = options.fetch(:object_type)
      @enabled      = options.fetch(:enabled) { true }

      assign_instance_variables(options)
    end

    def create
      assign_instance_variables(resource_result)
      self
    end

    private

    def resource_result
      JSON.parse(response)
    end

    def response
      request.execute
    end

    def request
      PromisePay::Request.new(
        path: ENDPOINT,
        method: :post,
        payload: payload
      )
    end

    def payload
      {
        description:  description,
        enabled:      enabled,
        object_type:  object_type,
        url:          url,
      }
    end
  end
end
