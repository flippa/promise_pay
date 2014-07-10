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

    it "uses the test api when configured" do
      expect { PromisePay.env = :test }.
        to change { request.send(:endpoint).start_with? PromisePay::TEST_HOST }.
        from(false).to(true)
    end

    it "builds a RestClient::Request" do
      expect(request.send(:request)).to be_an_instance_of RestClient::Request
    end
  end

  describe "#execute" do
    it "calls the RestClient::Request to be exectued" do
      rest_client_request = request.send(:request)
      rest_client_request.should_receive(:execute)
      request.execute
    end

    it "re-raises RestClient::Unauthorized exceptions" do
      RestClient::Request.any_instance.stub(:execute) { raise RestClient::Unauthorized }
      expect { request.execute }.to raise_error PromisePay::RequestError
    end

    it "re-raises RestClient::BadRequest exceptions" do
      RestClient::Request.any_instance.stub(:execute) { raise RestClient::BadRequest }
      expect { request.execute }.to raise_error PromisePay::RequestError
    end

    it "raises exception when no api credentials are present"
  end
end
