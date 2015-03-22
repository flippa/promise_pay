require "promise_pay/item"
require "promise_pay/marketplace"
require "promise_pay/request"
require "promise_pay/session"
require "promise_pay/user"
require "promise_pay/fee"
require "promise_pay/version"
require "promise_pay/collection"
require "promise_pay/country"

module PromisePay
  API_HOST  = "https://secure.api.promisepay.com/"
  TEST_HOST = "https://test.api.promisepay.com/"

  class << self
    attr_accessor :api_user
    attr_accessor :api_key
    attr_accessor :env
  end

  class InvalidRequest < StandardError; end
  class InvalidSessionRequest < StandardError; end
end
