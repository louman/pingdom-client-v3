require_relative '../spec_helper'

module PingdomClientV3
  RSpec.describe ResponseObject do
    let(:original_response) { double }

    subject { described_class.new(attrs) }

    describe '#initialize' do
      let(:attrs) { { :method_1 => 'value', :method_2 => 'value 2', :PascalCase => 1 } }

      it 'transform hash keys into methods' do
        expect(subject[:method_1]).to eq 'value'
        expect(subject[:method_2]).to eq 'value 2'
      end
    end
  end
end
