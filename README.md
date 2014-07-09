# PromisePay

PromisePay API calls wrapped in a gem

## Installation

Add this line to your application's Gemfile:

    gem 'promise_pay'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install promise_pay

Generate your API key by jumping into a rails console and running:

    irb(main):001:0> PromisePay::Marketplace.initialize(user: "your@email", password: "your-promisepay-password")

Add the following to `/config/initializers/promise_pay.rb`:

```ruby
PromisePay.configure do |config|
  config.api_user = "api_email" # substitute with your PromisePay API email
  config.api_key = "api_key" # substitute with your PromisePay API key (generated above)
end
```

You're set to go!

## Usage

Some basic usage instructions are below:

Generating a PromisePay session:

    PromisePay::SessionToken.generate_for(session_params)

Query PromisePay for all users:

    PromisePay::User.all

Query PromisePay for one user (12345):

    PromisePay::User.find(12345)

Query PromisePay for all items:

    PromisePay::Item.all

Query PromisePay for one item (1s345):

    PromisePay::User.find("1s345")


## Contributing

1. Fork it ( http://github.com/<my-github-username>/promise_pay/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
