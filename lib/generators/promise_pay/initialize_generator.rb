require "rails/generators/base"

module PromisePay
  module Generators
    class InitializeGenerator < Rails::Generators::Base
      #source_root File.expand_path(File.dirname(__FILE__))

      def copy_initializer
        copy_file "promise_pay_initializer.rb", "config/initializers/promise_pay.rb"
      end
    end
  end
end
