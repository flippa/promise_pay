require "spec_helper"

describe PromisePay::Session do
  valid_params = {
    current_user_id:    "1",
    item_name:          "ItemName",
    amount:             "10",
    seller_firstname:   "Alex",
    seller_lastname:    "Jones",
    buyer_firstname:    "Sam",
    buyer_lastname:     "Smith",
    seller_email:       "seller@email.com",
    buyer_email:        "buyer@email.com",
    external_item_id:   "wef9834tg",
    external_seller_id: "1",
    external_buyer_id:  "2",
    fee_ids:            "3bfc26e3-093d-4f75-ac06-d2023294882b",
    payment_type_id:    "1",
    buyer_country:      "AUS",
    seller_country:     "USA"
  }

  let(:request) { double("RestClient::Request", execute: sample_response) }

  describe ".request_token" do
    let(:sample_response) { File.read("./spec/support/fixtures/token_generation.json") }
    let(:session)         { described_class.new(valid_params) }

    context "with valid params" do
      before do
        PromisePay::Request.stub(:new) { request }
      end

      it "returns the generated session token from PromisePay" do
        expect(session.request_token).to eq("123abc")
      end

      it "assigns the token to #token attribute" do
        expect { session.request_token }.to change { session.token }.
          from(nil).to("123abc")
      end

      it "instantiates PromisePay::Request with the correct path" do
        valid_path = "request_session_token?#{valid_params.to_param}"
        PromisePay::Request.should_receive(:new).with(path: valid_path)
        session.request_token
      end
    end

    context "with invalid params" do
      required_params =
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
          :fee_ids,
          :payment_type_id,
          :buyer_country,
          :seller_country
        ]

      required_params.each do |param|
        let(:invalid_params)  { valid_params.reject { |k, v| k == param } }
        let(:session)         { described_class.new(invalid_params) }

        it "raises an error if #{param[0]} option is missing" do
          expect { session.request_token }.
            to raise_error PromisePay::InvalidSessionRequest
        end
      end
    end
  end
end
