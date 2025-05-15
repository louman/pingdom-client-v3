require_relative '../spec_helper'

module PingdomClientV3
  RSpec.describe Client do
    include_context :pingdom_client

    subject { pingdom_client }

    describe '#check' do
      specify { expect(subject.check).to be_a PingdomClientV3::Resources::Check }

      specify do
        expect(PingdomClientV3::Resources::Check).to receive(:new).with(subject)
        subject.check
      end
    end

    describe '#resource_caller' do
      let(:resource) { double(:resource) }

      before do
        allow(RestClient::Resource).to receive(:new).with(pingdom_api_url, headers: { 'Authorization' => "Bearer #{pingdom_api_key}" }).and_return(resource)
      end

      specify do
        expect(PingdomClientV3::ResourceCaller).to receive(:new).with(resource).and_call_original
        expect(subject.resource_caller).to be_a PingdomClientV3::ResourceCaller
      end
    end
  end
end
