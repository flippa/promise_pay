require "promise_pay/lib/dynamic_accessors"
require "json"

module PromisePay
  class Callback
    include Lib::DynamicAccessors

    ENDPOINT = 'callbacks/'

    attr_reader :id
    attr_reader :url
    attr_reader :description
    attr_reader :object_type
    attr_reader :enabled

    attr_reader :method
    attr_reader :endpoint

    def self.index(options = {})
      new(options.merge(method: :get)).execute
    end

    def self.delete(options = {})
      new(options.merge(method: :delete)).execute
    end

    def self.create(options = {})
      new(options.merge(method: :post)).execute
    end

    def initialize(options = {})
      @id           = options.fetch(:id) { nil }
      @url          = options.fetch(:url) { "" }
      @description  = options.fetch(:description) { "" }
      @object_type  = options.fetch(:object_type) { "" }
      @enabled      = options.fetch(:enabled) { true }

      @method       = options.fetch(:method)
      @endpoint     = ENDPOINT + @id.to_s
    end

    def execute
      assign_instance_variables(result)
      self
    end

    private

    def result
      JSON.parse(response)
    end

    def response
      request.execute
    end

    def request
      PromisePay::Request.new(
        path: endpoint,
        method: method,
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
