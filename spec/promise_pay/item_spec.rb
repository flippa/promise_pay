require "spec_helper"

describe PromisePay::Item do
  let(:request) { double("PromisePay::Request", execute: sample_response) }

  describe ".find" do
    let(:item_id) { "wef9834tg" }

    let(:sample_response) { File.read("./spec/support/fixtures/item_find.json") }

    it "returns a hash representation of the item" do
      PromisePay::Request.any_instance.stub(:execute) { sample_response }
      expect(described_class.find(item_id)).to be_a_kind_of Hash
    end

    it "instantiates PromisePay::Request with the correct endpoint" do
      valid_endpoint = PromisePay::TEST_ENDPOINT + PromisePay::Item::PATH + item_id.to_s
      PromisePay::Request.should_receive(:new).with(endpoint: valid_endpoint) { request }
      described_class.find(item_id)
    end
  end

  describe ".all" do
    let(:sample_response) { File.read("./spec/support/fixtures/item_all.json") }

    it "returns a hash representation of the items" do
      PromisePay::Request.any_instance.stub(:execute) { sample_response }
      expect(described_class.all).to be_a_kind_of Hash
    end

    it "instantiates PromisePay::Request with the correct endpoint" do
      valid_endpoint = PromisePay::TEST_ENDPOINT + PromisePay::Item::PATH
      PromisePay::Request.should_receive(:new).with(endpoint: valid_endpoint) { request }
      described_class.all
    end
  end
end
