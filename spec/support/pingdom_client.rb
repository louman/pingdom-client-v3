shared_context :pingdom_client do
  let(:pingdom_api_key) { ENV['PINGDOM_API_KEY'] }
  let(:pingdom_api_url) { 'https://api.pingdom.com/api/3.1' }
  let(:pingdom_client) { PingdomClientV3::Client.new(pingdom_api_key, pingdom_api_url) }
end
