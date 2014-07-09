require "rest_client"

module PromisePay
  class Request

    def initialize(options = {})
      @endpoint = options.fetch :endpoint
      @config   = options.fetch :configuration, PromisePay.configuration
      @user     = options.fetch :user,          config.api_user
      @password = options.fetch :password,      config.api_key
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
      RestClient::Request.new(
        method:   :get,
        url:      endpoint,
        user:     user,
        password: password,
        headers:  { accept: :json, content_type: :json }
      )
    end

    attr_reader :endpoint
    attr_reader :config
    attr_reader :user
    attr_reader :password
    attr_reader :request
  end

  class RequestError < StandardError; end
end
