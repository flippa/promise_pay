require "spec_helper"

describe PromisePay::User do
  describe ".find" do
    let(:user_id) { 1 }

    let(:sample_response) do
      "{\"links\":{\"users_items\":\"/users/{users.id}/items\"},\"user\":{\"id\":\"1\",\"email\":\"seller@email.com\",\"firstname\":\"Alex\",\"lastname\":\"Jones\",\"companyname\":null,\"created_at\":\"2014-07-08T17:10:11.232+10:00\",\"updated_at\":\"2014-07-08T17:10:11.232+10:00\",\"abn\":null,\"phone\":null,\"fax\":null,\"website\":null,\"mobile\":null,\"fullname\":\"Alex Jones\",\"href\":\"/users/1\",\"address\":{\"addressline1\":null,\"addressline2\":null,\"city\":null,\"state\":null,\"postcode\":null,\"country\":\"Australia\"},\"links\":{\"items\":[\"wef9834tg\"]}}}"
    end

    it "returns user data for the id specified" do
      PromisePay::Request.any_instance.stub(:execute) { sample_response }
      expect(described_class.find(user_id)).to be_a_kind_of Hash
    end

    it "instantiates PromisePay::Request with the correct endpoint" do
      valid_endpoint = PromisePay::TEST_ENDPOINT + PromisePay::User::PATH + user_id.to_s
      request = double("PromisePay::Request", execute: sample_response)

      PromisePay::Request.should_receive(:new).with(endpoint: valid_endpoint) { request }

      described_class.find(user_id)
    end
  end
end
