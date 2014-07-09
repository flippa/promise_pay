# PromisePay

PromisePay API calls wrapped in a gem

## Installation

Add this line to your application's Gemfile:

    gem 'promise_pay'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install promise_pay

Generate your API key by jumping into a console and running:

    irb PromisePay::Marketplace.initialize(user: "your-email-address", password: "your-promisepay-password")

Add the following to `/config/initializers/promise_pay.rb`:

```ruby
PromisePay.configure do |config|
  config.api_user = "api_email_address" # substitute with your PromisePay api email
  config.api_key = "api_key" # substitute with your PromisePay api key (generated above)
end
```

You're set to go!

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it ( http://github.com/<my-github-username>/promise_pay/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
