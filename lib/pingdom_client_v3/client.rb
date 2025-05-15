require 'rest-client'

module PingdomClientV3
  class Client
    def initialize(api_token, api_url='https://api.pingdom.com/api/3.1')
      @api_token = api_token
      @api_url = api_url
    end

    def check
      @check ||= PingdomClientV3::Resources::Check.new(self)
    end

    def resource_caller
      PingdomClientV3::ResourceCaller.new(http_resource)
    end

    private

    def http_resource
      RestClient::Resource.new(@api_url, headers: { 'Authorization' => "Bearer #{@api_token}" })
    end
  end
end
