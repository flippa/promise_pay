require "spec_helper"

describe PromisePay::Item do
  let(:request) { double("PromisePay::Request", execute: sample_response) }

  before do
    PromisePay::Request.stub(:new) { request }
  end

  describe ".find" do
    let(:sample_response) { File.read("./spec/support/fixtures/item_find.json") }
    let(:item_id)         { "wef9834tg" }

    it "raises an exception with no valid arg" do
      expect { described_class.find }.to raise_error PromisePay::InvalidRequest
    end

    it "returns a PromisePay::Item object" do
      expect(described_class.find(item_id)).to be_a_kind_of PromisePay::Item
    end

    it "returns object has correctly assigned attributes" do
      promise_pay_item = described_class.find(item_id)
      expect(promise_pay_item.id).to eq "wef9834tg"
      expect(promise_pay_item.name).to eq "ItemName"
      expect(promise_pay_item.amount).to eq 10
      expect(promise_pay_item.state).to eq "pending"
    end

    it "formats created_at and updated_at as Time" do
      promise_pay_item = described_class.find(item_id)
      expect(promise_pay_item.created_at).to be_a_kind_of Time
      expect(promise_pay_item.updated_at).to be_a_kind_of Time
    end

    it "instantiates PromisePay::Request with the correct path" do
      valid_path = "items/#{item_id}"
      PromisePay::Request.should_receive(:new).with(path: valid_path)
      described_class.find(item_id)
    end
  end
end
