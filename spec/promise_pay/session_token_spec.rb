require "spec_helper"

describe PromisePay::SessionToken do
  describe "#generate_for" do
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

    valid_params.each do |param|
      it "raises a key error if #{param[0]} option is missing" do
        invalid_params = valid_params.reject { |k, v| k == param[0] }
        expect { PromisePay::SessionToken.generate_for(invalid_params) }.to raise_error KeyError
      end
    end

    context "with valid params" do
      let(:request) { double("RestClient::Request") }

      before do
        RestClient::Request.stub(:new) { request }
      end

      it "returns the generated session token from PromisePay" do
        json_response = "{\"token\":\"123abc\"}"
        allow(request).to receive(:execute) { json_response }

        expect(PromisePay::SessionToken.generate_for(valid_params)).to eq("123abc")
      end

      it "raises an exception when RestClient raises an Unauthorized exception" do
        allow(request).to receive(:execute) { raise RestClient::Unauthorized }
        expect { PromisePay::SessionToken.generate_for(valid_params) }.
          to raise_error PromisePay::SessionTokenGenerationError
      end

      it "raises an exception when a RestClient raises a BadRequest excpetion" do
        allow(request).to receive(:execute) { raise RestClient::BadRequest }
        expect { PromisePay::SessionToken.generate_for(valid_params) }.
          to raise_error PromisePay::SessionTokenGenerationError
      end
    end
  end
end
