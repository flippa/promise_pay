require "promise_pay/version"
require "promise_pay/request"
require "promise_pay/session_token"
require "promise_pay/marketplace"
require "promise_pay/user"
require "promise_pay/item"

module PromisePay
  API_ENDPOINT  = "https://api.promisepay.com"
  TEST_ENDPOINT = "https://test.api.promisepay.com"


  class << self
    attr_accessor :api_user
    attr_accessor :api_key
  end
end
