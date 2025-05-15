require 'json'
require 'forwardable'

module PingdomClientV3
  class Response
    extend Forwardable

    def_delegators :@original_response, :code, :request, :headers

    def initialize(original_response)
      @original_response = original_response
    end

    def success?
      success_codes.include?(code)
    end

    def failure?
      !success?
    end

    def body
      @body ||= parse_json_safe(original_body)
    end

    def original_body
      @original_response.body
    end

    def response_object
      @response_object ||= initialize_object(body)
    end

    private

    def initialize_object(body)
      if body.is_a?(Array)
        body.map do |item|
          PingdomClientV3::ResponseObject.new(item)
        end
      else
        PingdomClientV3::ResponseObject.new(body)
      end
    end

    def success_codes
      200..226
    end

    def parse_json_safe(json)
      JSON.load(json)
    end
  end
end
