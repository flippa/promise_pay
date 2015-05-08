require "spec_helper"

describe PromisePay::ItemStatus do
  let(:request) { double("PromisePay::Request", execute: sample_response) }

  before do
    allow(PromisePay::Request).to receive(:new) { request }
  end

  describe ".find" do
    let(:sample_response) { File.read("./spec/support/fixtures/item_status/find.json") }
    let(:item_id)         { "wef9834tg" }

    it "returns a PromisePay::ItemStatus object" do
      expect(described_class.find(item_id)).to be_a_kind_of PromisePay::ItemStatus
    end

    it "returned object has correctly assigned attributes" do
      promise_pay_item = described_class.find(item_id)
      expect(promise_pay_item.id).to eq "wef9834tg"
      expect(promise_pay_item.status).to eq 22200
      expect(promise_pay_item.state).to eq "payment_deposited"
    end

    it "instantiates PromisePay::Request with the correct path" do
      valid_path = "items/#{item_id}/status"
      expect(PromisePay::Request).to receive(:new).with(path: valid_path)
      described_class.find(item_id)
    end
  end
end
