require "spec_helper"

describe PromisePay do
  describe "#configure" do
    before { PromisePay.configuration = PromisePay::Configuration.new }

    context "with valid config" do
      before do
        PromisePay.configure do |config|
          config.api_user = "user@email.com"
          config.api_key  = "abc123"
        end
      end

      it "allows setting of the api_user" do
        expect(PromisePay.configuration.api_user).to eq("user@email.com")
      end

      it "allows setting of the api_key" do
        expect(PromisePay.configuration.api_key).to eq("abc123")
      end
    end

    it "raises an InvalidConfig exception when no api_user is set" do
      expect do
        PromisePay.configure do |config|
          config.api_key = "abc123"
        end
      end.to raise_error PromisePay::InvalidConfig
    end

    it "raises an InvalidConfig exception when no api_key is set" do
      expect do
        PromisePay.configure do |config|
          config.api_user = "user@email.com"
        end
      end.to raise_error PromisePay::InvalidConfig
    end
  end
end
