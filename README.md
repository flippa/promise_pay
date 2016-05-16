# PromisePay

[![Build Status](https://travis-ci.org/iamliamnorton/promise_pay.svg?branch=master)](https://travis-ci.org/iamliamnorton/promise_pay)

PromisePay API calls wrapped in a gem

## NOTICE

This project is unmaintained. I suggest you use the [official gem](https://github.com/PromisePay/promisepay-ruby).

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

    PromisePay.env = :test # probaby should reference config/environments/...

Along with your test environments api user/key. You can generate all this by running:

    $ rails generate promise_pay:init EMAIL PASSWORD --test

Note this will overwrite anything in `config/initializers/promise_pay.rb`, but you will still need to set your fee-ids manually in this config file.

## Usage

All API interations, and therefore all params for these classes can be viewed at the official PromisePay doc website (http://docs.promisepay.com/).

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

# Query for a status of an item (abc123) returning a PromisePay::Item::Status object
user = PromisePay::ItemStatus.find('abc123')
user.state    => "pending"

# Query PromisePay for an item (1s345) returning a PromisePay::Item object
item = PromisePay::Item.find("1s345")
item.amount   => 10
# Note: this is a slow operation, it you just want item status use the Item::Status API

# New PromisePay::Item using params hash for attributes
item = PromisePay::Item.new({id: "1s345"})
item.id   => "1s345"

# Create a fee returning a PromisePay::Feelist object
fee = PromisePay::Feelist.create(fee_params)
fee.id        => "5c07f36a-d18f-4153-9a75-ebf9f4f2f9ef"

# Create a callback
fee = PromisePay::Callback.create(url: "https://our.api/callback", object_type: "items")
fee.id        => "77e4fc66-b695-4e72-90ac-b454c395b867"

```

## Contributing

This project follows [semantic versioning](http://semver.org).

In order to make a change, do so from a feature branch and pull request the
project. Your pull request should not include a version change. Instead, make
an addition to the "head" version in the CHANGELOG that briefly describes the
change and ideally links to the pull request.
