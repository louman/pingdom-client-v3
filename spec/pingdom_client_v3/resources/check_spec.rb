require_relative '../../spec_helper'

module PingdomClientV3
  RSpec.describe Resources::Check do
    include_context :pingdom_client

    subject { described_class.new(pingdom_client) }

    describe '#index', vcr: { cassette_name: 'resources/check/index' } do
      let(:response) { subject.index }

      it 'returns a PingdomClientV3::Response' do
        expect(response).to be_a PingdomClientV3::Response
      end

      it 'is successful' do
        expect(response.success?).to be_truthy
      end

      it 'returns a hash' do
        expect(response.body).to be_a Hash
      end

      context 'sanity check' do
        let(:check) { response.response_object['checks'].first }

        it 'is a check' do
          expect(check['id']).to eq 13904858
          expect(check['name']).to eq 'google'
          expect(check['hostname']).to eq 'google.com'
        end
      end
    end

    describe '#show', vcr: { cassette_name: 'resources/check/show' } do
      let(:response) { subject.show(13904898) }

      it 'returns a PingdomClientV3::Response' do
        expect(response).to be_a PingdomClientV3::Response
      end

      it 'is successful' do
        expect(response.success?).to be_truthy
      end

      it 'returns a hash' do
        expect(response.body).to be_a Hash
      end

      context 'sanity check' do
        let(:check) { response.response_object['check'] }

        it 'is a check' do
          expect(check['id']).to eq 13904898
          expect(check['name']).to eq 'a test check'
          expect(check['hostname']).to eq 'google.com'
        end
      end
    end

    describe '#create', vcr: { cassette_name: 'resources/check/create' } do
      let(:payload) do
        {
          host: 'google.com',
          name: 'a test check',
          type: 'http'
        }
      end
      let(:response) { subject.create(payload) }

      it 'returns a PingdomClientV3::Response' do
        expect(response).to be_a PingdomClientV3::Response
      end

      it 'is successful' do
        expect(response.success?).to be_truthy
      end

      it 'returns a hash' do
        expect(response.body).to be_a Hash
      end

      context 'sanity check' do
        let(:check) { response.response_object['check'] }

        it 'is a check' do
          expect(check['id']).to eq 13904898
          expect(check['name']).to eq 'a test check'
        end
      end
    end

    describe '#destroy', vcr: { cassette_name: 'resources/check/destroy' } do
      let(:payload) do
        {
          host: 'google.com',
          name: 'a test check to destroy',
          type: 'http'
        }
      end
      let(:create_response) { subject.create(payload) }
      let(:response) { subject.destroy(create_response.response_object['check']['id']) }

      it 'returns a PingdomClientV3::Response' do
        expect(response).to be_a PingdomClientV3::Response
      end

      it 'is successful' do
        expect(response.success?).to be_truthy
      end

      it 'returns a hash' do
        expect(response.body).to be_a Hash
      end

      context 'sanity check' do
        let(:message) { response.response_object['message'] }

        it 'deletes the check' do
          expect(message).to eq 'Deletion of check was successful!'
        end
      end
    end
  end
end
