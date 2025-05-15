require 'json'

module PingdomClientV3
  class CustomException < StandardError
    attr_reader :http_response, :original_exception, :error_message

    def initialize(original_exception)
      @original_exception = original_exception
      @http_response = @original_exception.response if @original_exception.respond_to?(:response)
      @error_message = parsed_response if @http_response
      super(@original_exception.to_s)
    end

    private

    def parsed_response
      @json_error_parser ||= parse_json_body
    end

    def parse_json_body
      JSON.load(@http_response.body)
    rescue
      ''
    end
  end

  class ConnectionError < CustomException; end
  class StandardError < CustomException; end
  class BadResponse < CustomException; end
end
