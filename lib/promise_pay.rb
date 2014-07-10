require "promise_pay/version"
require "promise_pay/configuration"
require "promise_pay/request"
require "promise_pay/session_token"
require "promise_pay/marketplace"
require "promise_pay/user"
require "promise_pay/item"

module PromisePay
  API_ENDPOINT  = "https://api.promisepay.com"
  TEST_ENDPOINT = "https://test.api.promisepay.com"

  class << self
    attr_accessor :configuration

    def configure
      yield configuration

      unless configuration.api_user.present? && configuration.api_key.present?
        raise InvalidConfig, "Your API user and key are required"
      end
    end

    def configuration
      @configuration ||= Configuration.new
    end
  end

  class InvalidConfig < StandardError; end
end
