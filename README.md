# PromisePay

PromisePay API calls wrapped in a gem

## Installation

Add this line to your application's Gemfile:

    gem 'promise_pay'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install promise_pay

Generate your PromizePay API key and the rails promise_pay initializer:

    $ rails generate promise_pay:init EMAIL PASSWORD

You're set to go!

## Extra Info

To use PromisePay's test API, set the following in `config/initializers/promise_pay.rb`:

    PromisePay.env = :test

Along with your test environments api user/key. You can generate all this by running:

    $ rails generate promise_pay:init EMAIL PASSWORD --test

Note this will overwrite anything in `config/initializers/promise_pay.rb`

## Usage

```ruby
# A new PromisePay::Session that generates a session token
session = PromisePay::Session.new(session_params)
session.amount = 10
session.token           => nil
session.request_token   => "8cfd23e3-196e-4a45-ab16-d1213094871e"
session.token           => "8cfd23e3-196e-4a45-ab16-d1213094871e"

# Query PromisePay for a user (12345) returning a PromisePay::User object
user = PromisePay::User.find(12345)
user.email    => "email@addr"

# Query PromisePay for an item (1s345) returning a PromisePay::Item object
item = PromisePay::Item.find("1s345")
item.amount   => 10

```

## TODO:

1. Move all errors into shared file

## Contributing

1. Fork it ( http://github.com/<my-github-username>/promise_pay/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
