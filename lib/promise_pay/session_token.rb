require "rest_client"
require "json"
require 'active_support/core_ext/object'

module PromisePay
  class SessionToken
    PATH = "/request_session_token?"

    def self.generate_for(options = {})
      new(options).generate
    end

    def initialize(options = {})
      @current_user_id    = options.fetch :current_user_id
      @currency           = options.fetch :currency
      @item_name          = options.fetch :item_name
      @amount             = options.fetch :amount
      @seller_lastname    = options.fetch :seller_lastname
      @seller_firstname   = options.fetch :seller_firstname
      @buyer_lastname     = options.fetch :buyer_lastname
      @buyer_firstname    = options.fetch :buyer_firstname
      @seller_email       = options.fetch :seller_email
      @buyer_email        = options.fetch :buyer_email
      @external_item_id   = options.fetch :external_item_id
      @external_seller_id = options.fetch :external_seller_id
      @external_buyer_id  = options.fetch :external_buyer_id
      @fee_ids            = options.fetch :fee_ids
      @payment_type_id    = options.fetch :payment_type_id
    end

    def generate
      request = RestClient::Request.new(
        method:   :get,
        url:      end_point,
        user:     "liam.norton@flippa.com",
        password: "ee0003894f34f1854e4d2f1d38d081c8",
        headers:  { accept: :json, content_type: :json }
      )

      begin
        response = request.execute
      rescue RestClient::Unauthorized, RestClient::BadRequest => e
        raise SessionTokenGenerationError, e.message
      end

      JSON.parse(response)["token"]
    end

    private

    def end_point
      #API_ENDPOINT + PATH + query_string
      TEST_ENDPOINT + PATH + query_string
    end

    def query_string
      {
        current_user_id:    current_user_id,
        currency:           currency,
        item_name:          item_name,
        amount:             amount,
        seller_lastname:    seller_lastname,
        seller_firstname:   seller_firstname,
        buyer_lastname:     buyer_lastname,
        buyer_firstname:    buyer_firstname,
        seller_email:       seller_email,
        buyer_email:        buyer_email,
        external_item_id:   external_item_id,
        external_seller_id: external_seller_id,
        external_buyer_id:  external_buyer_id,
        fee_ids:            fee_ids,
        payment_type_id:    payment_type_id
      }.to_param
    end

    attr_reader :current_user_id
    attr_reader :currency
    attr_reader :item_name
    attr_reader :amount
    attr_reader :seller_lastname
    attr_reader :seller_firstname
    attr_reader :buyer_lastname
    attr_reader :buyer_firstname
    attr_reader :seller_email
    attr_reader :buyer_email
    attr_reader :external_item_id
    attr_reader :external_seller_id
    attr_reader :external_buyer_id
    attr_reader :fee_ids
    attr_reader :payment_type_id
  end

  class SessionTokenGenerationError < StandardError; end
end
