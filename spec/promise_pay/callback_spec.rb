require "spec_helper"

describe PromisePay::Callback do
  let(:request) { double("PromisePay::Request", execute: sample_response) }

  before { allow(PromisePay::Request).to receive(:new).and_return(request) }

  describe ".index" do
    let(:sample_response) { File.read("./spec/support/fixtures/callback/index.json") }

    it "PromisePay::Callback has correctly assigned attributes" do
      promise_pay_callback = described_class.index

      expect(promise_pay_callback.callbacks).not_to eq(nil)
    end

    it "instantiates PromisePay::Request with the correct path" do
      expect(PromisePay::Request).
        to receive(:new).
        with(hash_including(path: PromisePay::Callback::ENDPOINT))

      described_class.index
    end

    it "instantiates PromisePay::Request with the correct method" do
      expect(PromisePay::Request).
        to receive(:new).
        with(hash_including(method: :get))

      described_class.index
    end
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

  describe ".delete" do
    let(:sample_response) { File.read("./spec/support/fixtures/callback/delete.json") }

    let(:params) do
      { id: "77e4fc66-b695-4e72-90ac-b454c395b867" }
    end

    it "PromisePay::Callback has correctly assigned attributes" do
      promise_pay_callback = described_class.delete(params)

      expect(promise_pay_callback.id).to eq("77e4fc66-b695-4e72-90ac-b454c395b867")
    end

    it "instantiates PromisePay::Request with the correct path" do
      expect(PromisePay::Request).
        to receive(:new).
        with(
          hash_including(
            path: PromisePay::Callback::ENDPOINT + "77e4fc66-b695-4e72-90ac-b454c395b867"
          )
        )

      described_class.delete(params)
    end

    it "instantiates PromisePay::Request with the correct method" do
      expect(PromisePay::Request).
        to receive(:new).
        with(hash_including(method: :delete))

      described_class.delete(params)
    end
  end
end
