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

    $ rails generate promise_pay:init EMAIL PASSWORD [--test]

You're set to go!

## Extra Info

To use PromisePay's test API, set the following in `config/initializers/promise_pay.rb`:

    PromisePay.env = :test

Along with your test API credentials, you can generate your test API key using
the `--test` option with the generator above. Note that running the generator
could overwrite `config/initializers/promise_pay.rb`.

## Usage

```ruby
# Generate a PromisePay session, passing a hash of params
PromisePay::SessionToken.generate_for(session_params) => "8cfd23e3-196e-4a45-ab16-d1213094871e"

# Or create a `SessionToken` object to build up (TODO: this)
session_token = PromisePay::SessionToken.new(session_params)
session_token.buyer_email = "updated@email"
session_token.generate => "8cfd23e3-196e-4a45-ab16-d1213094871e"

# Query PromisePay for all users returning a hash of results
PromisePay::User.all

# Query PromisePay for one user (12345) returning a hash for that user
PromisePay::User.find(12345)

# Query PromisePay for all items returning a hash of results
PromisePay::Item.all

# Query PromisePay for one item (1s345) returning a hash for that item
PromisePay::Item.find("1s345")
```

## TODO:

1. Wrap all return objects in a PromisePay::Type
2. Move the API key generation into a generator

## Contributing

1. Fork it ( http://github.com/<my-github-username>/promise_pay/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
