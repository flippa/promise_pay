require "rails/generators/base"

module PromisePay
  module Generators
    class InitializeGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)

      desc "Initalize PromisePay API key"

      def copy_initializer
        template "promise_pay_initializer.rb", "config/initializers/promise_pay.rb"
      end
    end
  end
end
