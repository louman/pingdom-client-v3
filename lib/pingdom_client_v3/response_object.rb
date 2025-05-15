require 'delegate'

module PingdomClientV3
  class ResponseObject < SimpleDelegator
    def initialize(attributes)
      __setobj__(attributes)
    end
  end
end
