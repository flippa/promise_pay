require "spec_helper"

describe PromisePay::Configuration do
  let(:configuration) { described_class.new }

  it "defaults the api_user to nil" do
    expect(configuration.api_user).to be_nil
  end

  it "defaults the api_user to nil" do
    expect(configuration.api_key).to be_nil
  end
end
