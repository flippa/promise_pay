require "spec_helper"

describe PromisePay::Item do
  let(:request) { double("PromisePay::Request", execute: sample_response) }

  before do
    allow(PromisePay::Request).to receive(:new) { request }
  end

  describe ".find" do
    let(:sample_response) { File.read("./spec/support/fixtures/item/find.json") }
    let(:item_id)         { "wef9834tg" }

    it "returns a PromisePay::Item object" do
      expect(described_class.find(item_id)).to be_a_kind_of PromisePay::Item
    end

    it "returned object has correctly assigned attributes" do
      promise_pay_item = described_class.find(item_id)

      aggregate_failures do
        expect(promise_pay_item.id).to eq "wef9834tg"
        expect(promise_pay_item.name).to eq "ItemName"
        expect(promise_pay_item.amount).to eq 10
        expect(promise_pay_item.state).to eq "pending"
      end
    end

    it "formats created_at and updated_at as Time" do
      promise_pay_item = described_class.find(item_id)

      aggregate_failures do
        expect(promise_pay_item.created_at).to be_a_kind_of Time
        expect(promise_pay_item.updated_at).to be_a_kind_of Time
      end
    end

    it "instantiates PromisePay::Request with the correct path" do
      valid_path = "items/#{item_id}"
      expect(PromisePay::Request).to receive(:new).with(path: valid_path)

      described_class.find(item_id)
    end
  end

  describe ".find_all" do
    let(:sample_response) { File.read("./spec/support/fixtures/item/find_all.json") }

    it "returns an array of PromisePay::Item objects" do
      result = described_class.find_all

      aggregate_failures do
        expect(result).to be_a_kind_of Array
        expect(result.first).to be_a_kind_of PromisePay::Item
      end
    end

    it "returned objects have correctly assigned attributes" do
      promise_pay_user = described_class.find_all.first

      aggregate_failures do
        expect(promise_pay_user.id).to eq "wef9834tg"
        expect(promise_pay_user.name).to eq "ItemName"
        expect(promise_pay_user.amount).to eq 10
      end
    end

    it "instantiates PromisePay::Request with the correct path" do
      valid_path = "items/"
      expect(PromisePay::Request).to receive(:new).with(path: valid_path)

      described_class.find_all
    end
  end
end
