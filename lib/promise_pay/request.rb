require "rest_client"

module PromisePay
  class Request

    def initialize(options = {})
      @path     = options.fetch :path
      @user     = options.fetch :user,          PromisePay.api_user
      @password = options.fetch :password,      PromisePay.api_key
      @request  = build_request
    end

    def execute
      begin
        raise request.inspect
        response = request.execute
      rescue RestClient::Unauthorized, RestClient::BadRequest => e
        raise RequestError, e.message
      end

      response
    end

    private

    def build_request
      RestClient::Request.new(
        method:   :get,
        url:      endpoint,
        user:     user,
        password: password,
        headers:  { accept: :json, content_type: :json }
      )
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
    attr_reader :request
  end

  class RequestError < StandardError; end
end
