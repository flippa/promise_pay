require "spec_helper"

describe PromisePay::Marketplace do
  describe ".initialize" do
    let(:user)      { "test@email.com" }
    let(:password)  { "password" }

    let(:request)   { double("RestClient::Request") }

    before do
      RestClient::Request.stub(:new) { request }
    end

    it "outputs the generated marketplace token" do
      response = "{\"token\":\"12345\"}"
      allow(request).to receive(:execute) { response }

      message = "Your marketplace token is: 12345 (Store this securely)"
      STDOUT.should_receive(:puts).with(message)

      described_class.initialize(user: user, password: password)
    end

    it "raises an exception if a token already exists" do
      allow(request).to receive(:execute) { raise RestClient::Unauthorized }

      expect { described_class.initialize(user: user, password: password) }.
        to raise_error PromisePay::RequestError
    end
  end
end
