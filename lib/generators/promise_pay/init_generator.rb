require "rails/generators/base"

module PromisePay
  module Generators
    class InitGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)

      arguement :email,     type: :string
      arguement :password,  type: :string

      desc "Initalize PromisePay API key"

      # run the marketplace token request command
      # write the output to the initializer

      def custom_method_call
        puts "Yesss i got called..."
      end

      def copy_initializer
        template "promise_pay_initializer.rb", "config/initializers/promise_pay.rb"
      end
    end
  end
end
