require "spec_helper"

describe PromisePay::User do
  let(:request) { double("PromisePay::Request", execute: sample_response) }

  before do
    PromisePay::Request.stub(:new) { request }
  end

  describe ".find" do
    let(:sample_response) { File.read("./spec/support/fixtures/user_find.json") }
    let(:user_id)         { 1 }

    it "returns a hash representation of the user" do
      expect(described_class.find(user_id)).to be_a_kind_of Hash
    end

    it "instantiates PromisePay::Request with the correct path" do
      valid_path = "users/#{user_id}"
      PromisePay::Request.should_receive(:new).with(path: valid_path)
      described_class.find(user_id)
    end
  end

  describe ".all" do
    let(:sample_response) { File.read("./spec/support/fixtures/user_all.json") }

    it "returns a hash representation of the users" do
      expect(described_class.all).to be_a_kind_of Hash
    end

    it "instantiates PromisePay::Request with the correct path" do
      valid_path = "users/"
      PromisePay::Request.should_receive(:new).with(path: valid_path)
      described_class.all
    end
  end
end
