require "spec_helper"

describe PromisePay::Fee do
  let(:request) { double("PromisePay::Request", execute: sample_response) }

  before do
    allow(PromisePay::Request).to receive(:new) { request }
  end

  describe ".create" do
    let(:sample_response) { File.read("./spec/support/fixtures/fee/create.json") }

    let(:params) do
      {
        name:         "Transaction fee",
        fee_type_id:  1,
        amount:       1500,
        cap:          nil,
        min:          nil,
        max:          nil,
        to:           'seller'
      }
    end

    it "returns a PromisePay::Fee object" do
      expect(described_class.create(params)).to be_a_kind_of PromisePay::Fee
    end

    it "PromisePay::Feelist has correctly assigned attributes" do
      promise_pay_fee = described_class.create(params)

      expect(promise_pay_fee.id).to eq "5c07f36a-d18f-4153-9a75-ebf9f4f2f9ef"
      expect(promise_pay_fee.name).to eq "Transaction fee"
      expect(promise_pay_fee.fee_type_id).to eq 1
      expect(promise_pay_fee.amount).to eq 1500
      expect(promise_pay_fee.cap).to eq nil
      expect(promise_pay_fee.min).to eq nil
      expect(promise_pay_fee.max).to eq nil
      expect(promise_pay_fee.to).to eq 'seller'
    end

    it "instantiates PromisePay::Request with the correct path" do
      expect(PromisePay::Request).
        to receive(:new).
        with(hash_including(path: 'fees'))

      described_class.create(params)
    end

    it "instantiates PromisePay::Request with the correct method" do
      expect(PromisePay::Request).
        to receive(:new).
        with(hash_including(method: :post))

      described_class.create(params)
    end

    it "instantiates PromisePay::Request with the correct payload" do
      expect(PromisePay::Request).
        to receive(:new).
        with(hash_including(payload: params))

      described_class.create(params)
    end
  end
end
