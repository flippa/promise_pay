require "spec_helper"

describe PromisePay::User do
  let(:request) { double("PromisePay::Request", execute: sample_response) }

  before do
    PromisePay::Request.stub(:new) { request }
  end

  describe ".find" do
    let(:sample_response) { File.read("./spec/support/fixtures/user_find.json") }
    let(:user_id)         { 1 }

    it "raises an exception with no valid arg" do
      expect { described_class.find }.to raise_error PromisePay::InvalidRequest
    end

    it "returns a PromisePay::User object" do
      expect(described_class.find(user_id)).to be_a_kind_of PromisePay::User
    end

    it "returns object has correctly assigned attributes" do
      promise_pay_user = described_class.find(user_id)
      expect(promise_pay_user.id).to eq "1"
      expect(promise_pay_user.email).to eq "seller@email.com"
      expect(promise_pay_user.website).to be_nil
      expect(promise_pay_user.country).to eq "Australia"
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
end
