require "spec_helper"

describe PromisePay::User do
  let(:request) { double("PromisePay::Request", execute: sample_response) }

  before do
    PromisePay::Request.stub(:new) { request }
  end

  describe ".find" do
    let(:sample_response) { File.read("./spec/support/fixtures/user/find.json") }
    let(:user_id)         { 1 }

    it "returns a PromisePay::User object" do
      expect(described_class.find(user_id)).to be_a_kind_of PromisePay::User
    end

    it "returned object has correctly assigned attributes" do
      promise_pay_user = described_class.find(user_id)
      expect(promise_pay_user.id).to eq "1"
      expect(promise_pay_user.email).to eq "seller@email.com"
      expect(promise_pay_user.website).to be_nil
    end

    it "formats created_at and updated_at as Time" do
      promise_pay_user = described_class.find(user_id)
      expect(promise_pay_user.created_at).to be_a_kind_of Time
      expect(promise_pay_user.updated_at).to be_a_kind_of Time
    end

    it "instantiates PromisePay::Request with the correct path" do
      valid_path = "users/#{user_id}"
      PromisePay::Request.should_receive(:new).with(path: valid_path)
      described_class.find(user_id)
    end
  end

  describe ".find_all" do
    let(:sample_response) { File.read("./spec/support/fixtures/user/find_all.json") }

    it "returns an array of PromisePay::User objects" do
      result = described_class.find_all
      expect(result).to be_a_kind_of Array
      expect(result.first).to be_a_kind_of PromisePay::User
    end

    it "returned objects have correctly assigned attributes" do
      promise_pay_user = described_class.find_all.first
      expect(promise_pay_user.id).to eq "2"
      expect(promise_pay_user.email).to eq "buyer@email.com"
      expect(promise_pay_user.website).to be_nil
    end

    it "instantiates PromisePay::Request with the correct path" do
      valid_path = "users/"
      PromisePay::Request.should_receive(:new).with(path: valid_path)
      described_class.find_all
    end
  end
end
