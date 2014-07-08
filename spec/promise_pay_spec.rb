require "spec_helper"

describe PromisePay do
  describe ".test" do
    it "returns the test string" do
      expect(described_class.test).to eq("testing 1,2,3")
    end
  end
end
