require "spec_helper"

describe PromisePay::User do
  let(:request) { double("PromisePay::Request", execute: sample_response) }

  describe ".find" do
    let(:user_id) { 1 }

    let(:sample_response) { File.read("./spec/support/fixtures/user_find.json") }

    it "returns user data for the id specified" do
      PromisePay::Request.any_instance.stub(:execute) { sample_response }
      expect(described_class.find(user_id)).to be_a_kind_of Hash
    end

    it "instantiates PromisePay::Request with the correct endpoint" do
      valid_endpoint = PromisePay::TEST_ENDPOINT + PromisePay::User::PATH + user_id.to_s

      PromisePay::Request.should_receive(:new).with(endpoint: valid_endpoint) { request }

      described_class.find(user_id)
    end
  end

  describe ".all" do
    let(:sample_response) { File.read("./spec/support/fixtures/user_all.json") }

    it "returns user data" do
      PromisePay::Request.any_instance.stub(:execute) { sample_response }

      expect(described_class.all).to be_a_kind_of Hash
    end

    it "instantiates PromisePay::Request with the correct endpoint" do
      valid_endpoint = PromisePay::TEST_ENDPOINT + PromisePay::User::PATH

      PromisePay::Request.should_receive(:new).with(endpoint: valid_endpoint) { request }

      described_class.all
    end
  end
end
