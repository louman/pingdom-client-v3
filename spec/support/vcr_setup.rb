require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/vcr_cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
  c.before_record do |i|
    i.response.body.force_encoding('UTF-8')
  end

  c.preserve_exact_body_bytes do |http_message|
    http_message.body.encoding.name == 'ASCII-8BIT' ||
    !http_message.body.valid_encoding?
  end

  c.filter_sensitive_data('<AUTHORIZATION_TOKEN>') do |interaction|
    interaction.request.headers['Authorization']&.first
  end
end
