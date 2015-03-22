require "promise_pay/lib/dynamic_accessors"
require "json"

module PromisePay
  class Feelist
    include Lib::DynamicAccessors

    attr_reader :id
    attr_reader :name
    attr_reader :fee_type_id
    attr_reader :amount
    attr_reader :cap
    attr_reader :min
    attr_reader :max
    attr_reader :to

    def self.create(options = {})
      new(options).create
    end

    def initialize(options = {})
      @name         = options.fetch(:name)
      @fee_type_id  = options.fetch(:fee_type_id)
      @amount       = options.fetch(:amount)
      @cap          = options.fetch(:cap)
      @min          = options.fetch(:min)
      @max          = options.fetch(:max)
      @to           = options.fetch(:to)

      assign_instance_variables({'feelist' => options})
    end

    def create
      assign_instance_variables(resource_result)
      self
    end

    private

    def resource_result
      request = PromisePay::Request.new(
        path: api_resource,
        method: :post,
        payload: payload
      )

      response = request.execute
      JSON.parse(response)["fees"]
    end

    def api_resource
      "fees"
    end

    def payload
      {
        name:         name,
        fee_type_id:  fee_type_id,
        amount:       amount,
        cap:          cap,
        min:          min,
        max:          max,
        to:           to
      }
    end
  end
end
