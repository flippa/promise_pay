require "rails/generators/base"
require "promise_pay"

module PromisePay
  module Generators
    class InitGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)

      argument :email,     type: :string
      argument :password,  type: :string

      class_option :test, type: :boolean, default: :false, description: "Initalize to test.api.promisepay.com"

      desc "Initalize PromisePay API key"

      def marketplace
        @marketplace ||= (
          PromisePay.env = options.test? ? :test : :production
          t = PromisePay::Marketplace.new(user: email, password: password)
          t
        )
      end

      def token
        #@token ||= marketplace.request_token
        p marketplace.request_token
        "token_test"
      end

      def copy_initializer
        template "promise_pay_initializer.rb", "config/initializers/promise_pay.rb"
      end
    end
  end
end
