require_relative '../spec_helper'
require 'json'

module PingdomClientV3
  RSpec.describe CustomException do
    it 'inherits from StandardError' do
      expect(described_class.superclass).to be ::StandardError
    end

    subject { described_class.new(original_exception) }

    describe '#original_exception' do
      let(:original_exception) { double }

      specify { expect(subject.original_exception).to eq original_exception }
    end

    describe '#http_response' do
      let(:original_exception) { double(:response => 'a response object') }

      specify { expect(subject.http_response).to eq 'a response object' }
    end

    describe '#error_message' do
      let(:original_exception) { double }
      let(:response) { double }
      let(:body) { JSON.dump({ :some => 'response' }) }

      before do
        expect(original_exception).to receive(:response).and_return(response)
        expect(response).to receive(:body).and_return(body)
      end

      specify { expect(subject.error_message).to eq({ 'some' => 'response' }) }
    end
  end
end
