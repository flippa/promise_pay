require "spec_helper"

describe PromisePay::Request do
  let(:request) { described_class.new(path: "users/") }

  before do
    PromisePay.api_user = "some@email"
    PromisePay.api_key  = "generated_key_123"
  end

  describe "#initialize" do
    it "takes an mandatory path arguement" do
      expect { described_class.new(user: "user@email.com", password: "password") }.
        to raise_error KeyError
    end

    it "takes optional user and password arguements" do
      expect(request).to be_an_instance_of PromisePay::Request
    end

    it "builds a RestClient::Request" do
      expect(request.send(:request)).to be_an_instance_of RestClient::Request
    end

    it "uses the test api endpoint when configured" do
      PromisePay.env = :test

      request_endpoint = request.send(:endpoint)
      expect(request_endpoint.start_with?(PromisePay::TEST_HOST)).to eq(true)
    end

    it "uses the production api endpoint when configured" do
      PromisePay.env = :production

      request_endpoint = request.send(:endpoint)
      expect(request_endpoint.start_with?(PromisePay::API_HOST)).to eq(true)
    end

    it "takes on optional request method arguement" do
      request = described_class.new(path: "users/", method: :post)
      expect(request.send(:method)).to eq(:post)
    end
  end

  describe "#execute" do
    it "calls the RestClient::Request to be exectued" do
      rest_client_request = request.send(:request)
      expect(rest_client_request).to receive(:execute)
      request.execute
    end

    it "re-raises RestClient::Unauthorized exceptions" do
      rest_client_request = request.send(:request)
      allow(rest_client_request).to receive(:execute) { raise RestClient::Unauthorized }

      expect { request.execute }.to raise_error PromisePay::RequestError
    end

    it "re-raises RestClient::BadRequest exceptions" do
      rest_client_request = request.send(:request)
      allow(rest_client_request).to receive(:execute) { raise RestClient::BadRequest }

      expect { request.execute }.to raise_error PromisePay::RequestError
    end

    it "raises exception when no api credentials are present" do
      PromisePay.api_user = nil
      expect { request.execute }.to raise_error PromisePay::RequestError
    end
  end
end
