# PingdomClientV3

Lightweight ruby gem for connecting to Pingdom's API V3.

NOTE: This gem DOES NOT cover all API endpoints since all I needed was managing checks. Feel free to open a PR to add new endpoints or even rewrite part of the gem to use a more generic approach that makes it easier to add new endpoints.

## About Pingdom

[https://www.pingdom.com/](https://www.pingdom.com/)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'pingdom_client_v3'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pingdom_client_v3

## Usage

```
client = PingdomClientV3::Client.new('api-key');


# test connection

response = client.checks #=> PingdomClientV3::Response
response.success? #=> Boolean
checks = response.response_object['checks'] #=> Array
checks.first.name #=> 'you check name'
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.
