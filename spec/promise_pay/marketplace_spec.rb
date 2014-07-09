require "spec_helper"

describe PromisePay::Marketplace do
  let(:request)   { double("RestClient::Request", execute: sample_response) }

  describe ".initialize" do
    let(:sample_response) { File.read("./spec/support/fixtures/token_generation.json") }
    let(:user)            { "test@email.com" }
    let(:password)        { "password" }

    before do
      PromisePay::Request.stub(:new) { request }
      STDOUT.stub(:puts) { "" }
    end

    it "instantiates PromisePay::Request with the correct endpoint" do
      valid_endpoint = PromisePay::TEST_ENDPOINT + PromisePay::Marketplace::PATH

      PromisePay::Request.should_receive(:new).with(
        endpoint: valid_endpoint,
        user:     user,
        password: password
      )

      described_class.initialize(user: user, password: password)
    end

    it "outputs the generated marketplace token" do
      expected_output = "Your marketplace token is: 123abc (Store this securely)"
      STDOUT.should_receive(:puts).with(expected_output)
      described_class.initialize(user: user, password: password)
    end
  end
end
