require_relative '../spec_helper'
require 'json'

module PingdomClientV3
  RSpec.describe Response do
    let(:original_response) { double }

    subject { described_class.new(original_response) }

    describe '#success?' do
      let(:original_response) { double(:code => code) }

      context 'when code between 200..226' do
        let(:code) { 200 }

        it 'returns true' do
          expect(subject.success?).to be_truthy
        end
      end

      context 'when code is not between 200..226' do
        let(:code) { 500 }

        it 'returns true' do
          expect(subject.success?).to be_falsey
        end
      end
    end

    describe '#failure?' do
      let(:original_response) { double(:code => code) }

      context 'when code is not between 200..226' do
        let(:code) { 500 }

        it 'returns true' do
          expect(subject.failure?).to be_truthy
        end
      end

      context 'when code between 200..226' do
        let(:code) { 200 }

        it 'returns true' do
          expect(subject.failure?).to be_falsey
        end
      end
    end

    describe '#body' do
      let(:hash) { { 'some' => 'response' } }
      let(:original_response) { double(body: JSON.dump(hash)) }

      it 'parses json into a hash' do
        expect(subject.body).to eq hash
      end
    end

    describe '#original_body' do
      let(:hash) { { :some => 'response' } }
      let(:original_response) { double(body: JSON.dump(hash)) }

      it 'returns the raw json' do
        expect(subject.original_body).to eq JSON.dump(hash)
      end
    end

    describe '#response_object' do
      let(:original_response) {double(body: JSON.dump(:code => '1234')) }

      it 'returns a ResponseObject' do
        expect(subject.response_object).to be_a PingdomClientV3::ResponseObject
      end

      context 'when it is an array' do
        let(:original_response) { double(body: JSON.dump([{:code => '1234'}, {:code => '12345'}])) }

        it 'returns an array of ResponseObject' do
          expect(subject.response_object).to be_an Array
          expect(subject.response_object.size).to eq 2
          expect(subject.response_object.first).to be_a PingdomClientV3::ResponseObject
        end
      end
    end
  end
end
