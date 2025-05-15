module PingdomClientV3
  module Resources
    class Check < BaseResource
      def index(params = {})
        get("/checks?#{URI.encode_www_form(params)}")
      end

      def show(check_id)
        get("/checks/#{check_id}")
      end

      def create(payload)
        post("/checks", payload)
      end

      def destroy(check_id)
        delete("/checks/#{check_id}")
      end
    end
  end
end
