require "spec_helper"

describe PromisePay::Marketplace do
  let(:request)   { double("RestClient::Request", execute: sample_response) }

  describe ".request_token" do
    let(:sample_response) { File.read("./spec/support/fixtures/token_generation.json") }
    let(:user)            { "test@email.com" }
    let(:password)        { "password" }

    before do
      allow(PromisePay::Request).to receive(:new) { request }
    end

    it "instantiates PromisePay::Request with the correct path" do
      valid_path = "request_token"

      expect(PromisePay::Request).to receive(:new).with(
        path:     valid_path,
        user:     user,
        password: password
      )

      described_class.new(user: user, password: password).request_token
    end

    it "returns the generated marketplace token" do
      expect(described_class.new(user: user, password: password).request_token).to eq("123abc")
    end
  end
end
