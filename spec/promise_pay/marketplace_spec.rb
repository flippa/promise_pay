require "spec_helper"

describe PromisePay::Marketplace do
  describe ".initialize" do
    let(:user)      { "test@email.com" }
    let(:password)  { "password" }

    let(:request)   { double("RestClient::Request") }

    let(:sample_response) { "{\"token\":\"12345\"}" }

    before do
      RestClient::Request.stub(:new) { request }
    end

    it "instantiates PromisePay::Request with the correct endpoint" do
      valid_endpoint = PromisePay::TEST_ENDPOINT + PromisePay::Marketplace::PATH
      request = double("PromisePay::Request", execute: sample_response)

      PromisePay::Request.should_receive(:new).with(
        endpoint: valid_endpoint,
        user:     user,
        password: password
      ) { request }

      described_class.initialize(user: user, password: password)
    end

    it "outputs the generated marketplace token" do
      allow(request).to receive(:execute) { sample_response }

      message = "Your marketplace token is: 12345 (Store this securely)"
      STDOUT.should_receive(:puts).with(message)

      described_class.initialize(user: user, password: password)
    end
  end
end
