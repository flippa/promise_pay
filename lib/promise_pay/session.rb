require "json"
require 'active_support/core_ext/object'

module PromisePay
  class Session

    attr_reader   :token
    attr_accessor :current_user_id
    attr_accessor :item_name
    attr_accessor :amount
    attr_accessor :seller_lastname
    attr_accessor :seller_firstname
    attr_accessor :buyer_lastname
    attr_accessor :buyer_firstname
    attr_accessor :seller_email
    attr_accessor :buyer_email
    attr_accessor :external_item_id
    attr_accessor :external_seller_id
    attr_accessor :external_buyer_id
    attr_accessor :fee_ids
    attr_accessor :payment_type_id
    attr_accessor :seller_country
    attr_accessor :buyer_country

    def initialize(options = {})
      @current_user_id    = options.fetch(:current_user_id)     { nil }
      @item_name          = options.fetch(:item_name)           { nil }
      @amount             = options.fetch(:amount)              { nil }
      @seller_lastname    = options.fetch(:seller_lastname)     { nil }
      @seller_firstname   = options.fetch(:seller_firstname)    { nil }
      @buyer_lastname     = options.fetch(:buyer_lastname)      { nil }
      @buyer_firstname    = options.fetch(:buyer_firstname)     { nil }
      @seller_email       = options.fetch(:seller_email)        { nil }
      @buyer_email        = options.fetch(:buyer_email)         { nil }
      @external_item_id   = options.fetch(:external_item_id)    { nil }
      @external_seller_id = options.fetch(:external_seller_id)  { nil }
      @external_buyer_id  = options.fetch(:external_buyer_id)   { nil }
      @fee_ids            = options.fetch(:fee_ids)             { nil }
      @payment_type_id    = options.fetch(:payment_type_id)     { nil }
      @seller_country     = options.fetch(:seller_country)      { nil }
      @buyer_country      = options.fetch(:buyer_country)       { nil }
    end

    def request_token
      enforce_valid_params!

      request = PromisePay::Request.new(path: api_resource)
      response = request.execute

      @token = JSON.parse(response)["token"]
      token
    end

    private

    def api_resource
      "request_session_token?#{query_string}"
    end

    def query_string
      {
        current_user_id:    current_user_id,
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
        payment_type_id:    payment_type_id,
        seller_country:     PromisePay::Country.code_for(seller_country),
        buyer_country:      PromisePay::Country.code_for(buyer_country)
      }.reject { |k,v| v.nil? }.to_param
    end

    def enforce_valid_params!
      required_params.each do |attr|
        if self.send(attr).blank?
          raise InvalidSessionRequest, "Missing #{attr} value"
        end
      end
    end

    def required_params
      [
        :current_user_id,
        :item_name,
        :amount,
        :seller_firstname,
        :buyer_firstname,
        :seller_email,
        :buyer_email,
        :external_item_id,
        :external_seller_id,
        :external_buyer_id,
        :payment_type_id,
        :seller_country,
        :buyer_country
      ]
    end
  end
end
