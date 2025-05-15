require 'json'

module PingdomClientV3
  class ResourceCaller
    def initialize(resource)
      @resource = resource
    end

    def get(path)
      wrap_exception { @resource[path].get }
    end

    def post(path, payload = {})
      send_payload(:post, path, payload)
    end

    def put(path, payload = {})
      send_payload(:put, path, payload)
    end

    def patch(path, payload = {})
      send_payload(:patch, path, payload)
    end

    def delete(path)
      wrap_exception { @resource[path].delete }
    end

    private

    def send_payload(method, path, payload)
      wrap_exception { @resource[path].send(method, hash_to_json(payload), json_headers) }
    end

    def hash_to_json(hash)
      JSON.dump(hash)
    end

    def json_headers
      { 'Content-Type' => 'application/json' }
    end

    def wrap_exception
      PingdomClientV3::Response.new(yield)
    rescue RestClient::ExceptionWithResponse => e
      raise PingdomClientV3::BadResponse.new(e)
    rescue RestClient::Exception, SocketError => e
      raise PingdomClientV3::ConnectionError.new(e)
    rescue => e
      raise PingdomClientV3::StandardError.new(e)
    end
  end
end
