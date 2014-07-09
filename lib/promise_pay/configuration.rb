module PromisePay
  class Configuration
    attr_accessor :api_user
    attr_accessor :api_key

    def initialize(options = {})
      @api_user = options[:api_user]
      @api_key  = options[:api_key]
    end
  end
end
