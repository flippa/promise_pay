require "spec_helper"

describe PromisePay::Callback do
  let(:request) { double("PromisePay::Request", execute: sample_response) }

  before do
    allow(PromisePay::Request).to receive(:new) { request }
  end

  describe ".create" do
    let(:sample_response) { File.read("./spec/support/fixtures/callback/create.json") }

    let(:params) do
      {
        description:  "Our callback endpoint",
        enabled:      true,
        object_type:  "items",
        url:          "https://foo.bar/baz",
      }
    end

    it "returns a PromisePay::Callback object" do
      expect(described_class.create(params)).to be_a_kind_of PromisePay::Callback
    end

    it "PromisePay::Callback has correctly assigned attributes" do
      promise_pay_callback = described_class.create(params)

      aggregate_failures do
        expect(promise_pay_callback.id).to eq("77e4fc66-b695-4e72-90ac-b454c395b867")
        expect(promise_pay_callback.description).to eq("Our callback endpoint")
        expect(promise_pay_callback.enabled).to eq(true)
        expect(promise_pay_callback.object_type).to eq("items")
        expect(promise_pay_callback.url).to eq("https://foo.bar/baz")
      end
    end

    it "instantiates PromisePay::Request with the correct path" do
      expect(PromisePay::Request).
        to receive(:new).
        with(hash_including(path: PromisePay::Callback::ENDPOINT))

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
