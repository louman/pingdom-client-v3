require_relative '../spec_helper'

module PingdomClientV3
  RSpec.describe ResourceCaller do
    let(:resource) { double(:resource) }

    subject { described_class.new(resource) }

    describe '#post' do
      let(:payload) { { :name => 'John' } }
      let(:json_payload) { JSON.dump(payload) }
      let(:result) { subject.post('some_path', payload) }
      let(:post_resource) { double(:post_resource) }
      let(:headers) { { 'Content-Type' => 'application/json' } }

      context 'when request is successful' do
        let(:fake_response) { double(:fake_response) }

        before do
          allow(resource).to receive(:[]).with('some_path').and_return(post_resource)
          allow(post_resource).to receive(:post).with(json_payload, headers).and_return(fake_response)
        end

        it 'returns a PingdomClientV3::Response' do
          expect(result).to be_a PingdomClientV3::Response
        end
      end

      context 'when resource raises a RestClient::ExceptionWithResponse' do
        let(:http_code) { 422 }
        let(:exception) { RestClient::ExceptionWithResponse.new }

        before do
          allow(exception).to receive(:http_code).and_return(http_code)
          allow(resource).to receive(:[]).with('some_path').and_return(post_resource)
          allow(post_resource).to receive(:post).with(json_payload, headers).and_raise(exception)
        end

        it 'raises a PingdomClientV3::BadResponse' do
          expect { result }.to raise_error PingdomClientV3::BadResponse
        end
      end

      context 'when resource raises a RestClient::Exception' do
        before do
          allow(resource).to receive(:[]).with('some_path').and_return(post_resource)
          allow(post_resource).to receive(:post).with(json_payload, headers).and_raise(RestClient::Exception.new)
        end

        it 'raises a PingdomClientV3::ConnectionError' do
          expect { result }.to raise_error PingdomClientV3::ConnectionError
        end
      end

      context 'when resource raises a SocketError' do
        before do
          allow(resource).to receive(:[]).with('some_path').and_return(post_resource)
          allow(post_resource).to receive(:post).with(json_payload, headers).and_raise(SocketError.new)
        end

        it 'raises a PingdomClientV3::ConnectionError' do
          expect { result }.to raise_error PingdomClientV3::ConnectionError
        end
      end

      context 'when resource raises any other error' do
        before do
          allow(resource).to receive(:[]).with('some_path').and_return(post_resource)
          allow(post_resource).to receive(:post).with(json_payload, headers).and_raise(StandardError.new('some_error'))
        end

        it 'raises a PingdomClientV3::ConnectionError' do
          expect { result }.to raise_error PingdomClientV3::StandardError
        end
      end
    end

    describe '#put' do
      let(:payload) { { :name => 'John' } }
      let(:json_payload) { JSON.dump(payload) }
      let(:result) { subject.put('some_path', payload) }
      let(:post_resource) { double(:post_resource) }
      let(:headers) { { 'Content-Type' => 'application/json' } }

      context 'when request is successful' do
        let(:fake_response) { double(:fake_response) }

        before do
          allow(resource).to receive(:[]).with('some_path').and_return(post_resource)
          allow(post_resource).to receive(:put).with(json_payload, headers).and_return(fake_response)
        end

        it 'returns a PingdomClientV3::Response' do
          expect(result).to be_a PingdomClientV3::Response
        end
      end

      context 'when resource raises a RestClient::ExceptionWithResponse' do
        let(:http_code) { 422 }
        let(:exception) { RestClient::ExceptionWithResponse.new }

        before do
          allow(exception).to receive(:http_code).and_return(http_code)
          allow(resource).to receive(:[]).with('some_path').and_return(post_resource)
          allow(post_resource).to receive(:put).with(json_payload, headers).and_raise(exception)
        end

        it 'raises a PingdomClientV3::BadResponse' do
          expect { result }.to raise_error PingdomClientV3::BadResponse
        end
      end

      context 'when resource raises a RestClient::Exception' do
        before do
          allow(resource).to receive(:[]).with('some_path').and_return(post_resource)
          allow(post_resource).to receive(:put).with(json_payload, headers).and_raise(RestClient::Exception.new)
        end

        it 'raises a PingdomClientV3::ConnectionError' do
          expect { result }.to raise_error PingdomClientV3::ConnectionError
        end
      end

      context 'when resource raises a SocketError' do
        before do
          allow(resource).to receive(:[]).with('some_path').and_return(post_resource)
          allow(post_resource).to receive(:put).with(json_payload, headers).and_raise(SocketError.new)
        end

        it 'raises a PingdomClientV3::ConnectionError' do
          expect { result }.to raise_error PingdomClientV3::ConnectionError
        end
      end

      context 'when resource raises any other error' do
        before do
          allow(resource).to receive(:[]).with('some_path').and_return(post_resource)
          allow(post_resource).to receive(:put).with(json_payload, headers).and_raise(StandardError.new('some_error'))
        end

        it 'raises a PingdomClientV3::ConnectionError' do
          expect { result }.to raise_error PingdomClientV3::StandardError
        end
      end
    end

    describe '#get' do
      let(:result) { subject.get('some_path') }
      let(:get_resource) { double(:get_resource) }

      context 'when request is successful' do
        let(:fake_response) { double(:fake_response) }

        before do
          allow(resource).to receive(:[]).with('some_path').and_return(get_resource)
          allow(get_resource).to receive(:get).and_return(fake_response)
        end

        it 'returns a PingdomClientV3::Response' do
          expect(result).to be_a PingdomClientV3::Response
        end
      end

      context 'when resource raises a RestClient::ExceptionWithResponse' do
        before do
          allow(resource).to receive(:[]).with('some_path').and_return(get_resource)
          allow(get_resource).to receive(:get).and_raise(RestClient::ExceptionWithResponse.new)
        end

        it 'raises a PingdomClientV3::BadResponse' do
          expect { result }.to raise_error PingdomClientV3::BadResponse
        end
      end

      context 'when resource raises a RestClient::Exception' do
        before do
          allow(resource).to receive(:[]).with('some_path').and_return(get_resource)
          allow(get_resource).to receive(:get).and_raise(RestClient::Exception.new)
        end

        it 'raises a PingdomClientV3::ConnectionError' do
          expect { result }.to raise_error PingdomClientV3::ConnectionError
        end
      end

      context 'when resource raises a SocketError' do
        before do
          allow(resource).to receive(:[]).with('some_path').and_return(get_resource)
          allow(get_resource).to receive(:get).and_raise(SocketError.new)
        end

        it 'raises a PingdomClientV3::ConnectionError' do
          expect { result }.to raise_error PingdomClientV3::ConnectionError
        end
      end

      context 'when resource raises any other error' do
        before do
          allow(resource).to receive(:[]).with('some_path').and_return(get_resource)
          allow(get_resource).to receive(:get).and_raise(StandardError.new('some_error'))
        end

        it 'raises a PingdomClientV3::ConnectionError' do
          expect { result }.to raise_error PingdomClientV3::StandardError
        end
      end
    end

    describe '#delete' do
      let(:result) { subject.delete('some_path') }
      let(:get_resource) { double(:get_resource) }

      context 'when request is successful' do
        let(:fake_response) { double(:fake_response) }

        before do
          allow(resource).to receive(:[]).with('some_path').and_return(get_resource)
          allow(get_resource).to receive(:delete).and_return(fake_response)
        end

        it 'returns a PingdomClientV3::Response' do
          expect(result).to be_a PingdomClientV3::Response
        end
      end

      context 'when resource raises a RestClient::ExceptionWithResponse' do
        before do
          allow(resource).to receive(:[]).with('some_path').and_return(get_resource)
          allow(get_resource).to receive(:delete).and_raise(RestClient::ExceptionWithResponse.new)
        end

        it 'raises a PingdomClientV3::BadResponse' do
          expect { result }.to raise_error PingdomClientV3::BadResponse
        end
      end

      context 'when resource raises a RestClient::Exception' do
        before do
          allow(resource).to receive(:[]).with('some_path').and_return(get_resource)
          allow(get_resource).to receive(:delete).and_raise(RestClient::Exception.new)
        end

        it 'raises a PingdomClientV3::ConnectionError' do
          expect { result }.to raise_error PingdomClientV3::ConnectionError
        end
      end

      context 'when resource raises a SocketError' do
        before do
          allow(resource).to receive(:[]).with('some_path').and_return(get_resource)
          allow(get_resource).to receive(:delete).and_raise(SocketError.new)
        end

        it 'raises a PingdomClientV3::ConnectionError' do
          expect { result }.to raise_error PingdomClientV3::ConnectionError
        end
      end

      context 'when resource raises any other error' do
        before do
          allow(resource).to receive(:[]).with('some_path').and_return(get_resource)
          allow(get_resource).to receive(:delete).and_raise(StandardError.new('some_error'))
        end

        it 'raises a PingdomClientV3::ConnectionError' do
          expect { result }.to raise_error PingdomClientV3::StandardError
        end
      end
    end
  end
end
