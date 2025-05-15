module PingdomClientV3
  module Resources
    class BaseResource
      extend Forwardable

      def_delegators :@resource_caller, :get, :post, :put, :delete, :patch

      def initialize(client)
        @resource_caller = client.resource_caller
      end
    end
  end
end

