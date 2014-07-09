require "spec_helper"

describe PromisePay::SessionToken do
  let(:request) { double("RestClient::Request", execute: sample_response) }

  describe ".generate_for" do
    let(:sample_response) { File.read("./spec/support/fixtures/token_generation.json") }

    valid_params = {
      current_user_id:    "1",
      currency:           "USD",
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
      payment_type_id:    "1"
    }

    context "with valid params" do
      before do
        PromisePay::Request.stub(:new) { request }
      end

      it "instantiates PromisePay::Request with the correct endpoint" do
        valid_endpoint = PromisePay::TEST_ENDPOINT + PromisePay::SessionToken::PATH + valid_params.to_param
        PromisePay::Request.should_receive(:new).with(endpoint: valid_endpoint)
        described_class.generate_for(valid_params)
      end

      it "returns the generated session token from PromisePay" do
        expect(described_class.generate_for(valid_params)).to eq("123abc")
      end
    end

    context "with invalid params" do
      valid_params.each do |param|
        let(:invalid_params) do
          valid_params.reject { |k, v| k == param[0] }
        end

        it "raises a key error if #{param[0]} option is missing" do
          expect { described_class.generate_for(invalid_params) }.
            to raise_error KeyError
        end
      end
    end
  end
end
