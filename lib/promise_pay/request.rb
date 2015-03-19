require "rest_client"

module PromisePay
  class Request

    def initialize(options = {})
      @path     = options.fetch(:path)
      @user     = options.fetch(:user)      { PromisePay.api_user }
      @password = options.fetch(:password)  { PromisePay.api_key }
      @method   = options.fetch(:method)    { :get }
      @payload  = options.fetch(:payload)   { nil }
      @request  = build_request
    end

    def execute
      begin
        response = request.execute
      rescue RestClient::Unauthorized, RestClient::BadRequest => e
        raise RequestError, e.message
      end

      response
    end

    private

    def build_request
      RestClient::Request.new(request_params)
    end

    def request_params
      {
        method:   method,
        url:      endpoint,
        user:     user,
        password: password,
        payload:  payload,
        headers:  { accept: :json, content_type: :json }
      }
    end

    def endpoint
      host + path
    end

    def host
      if PromisePay.env && PromisePay.env == :test
        TEST_HOST
      else
        API_HOST
      end
    end

    attr_reader :path
    attr_reader :user
    attr_reader :password
    attr_reader :method
    attr_reader :payload
    attr_reader :request
  end

  class RequestError < StandardError; end
end
