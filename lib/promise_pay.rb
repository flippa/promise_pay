require "promise_pay/version"
require "promise_pay/request"
require "promise_pay/session_token"
require "promise_pay/marketplace"
require "promise_pay/user"
require "promise_pay/item"

module PromisePay
  API_HOST  = "https://api.promisepay.com/"
  TEST_HOST = "https://test.api.promisepay.com/"

  def initialize(params = {})
    @env = params.fetch(:env, :production)
  end

  class << self
    attr_accessor :api_user
    attr_accessor :api_key
    attr_accessor :env
  end
end
