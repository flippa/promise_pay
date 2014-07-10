require "rails/generators/base"
require "promise_pay"

module PromisePay
  module Generators
    class InitGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)

      argument :email,     type: :string
      argument :password,  type: :string

      class_option :test, type: :boolean, default: :false, description: "Initalize to test.api.promisepay.com"

      desc "Request PromisePay API key and setup initializer"

      def marketplace
        @marketplace ||= (
          PromisePay.env = options.test? ? :test : :production
          t = PromisePay::Marketplace.new(user: email, password: password)
          p t.send(:request)
          t
        )
      end

      def token
        @token ||= (
          begin
            marketplace.request_token
          rescue PromisePay::RequestError
            p "WARNING: token generation failed (Check your credentials)"
            "[insert-token-here]"
          end
        )
      end

      def copy_initializer
        template "promise_pay_initializer.rb", "config/initializers/promise_pay.rb"
      end
    end
  end
end
