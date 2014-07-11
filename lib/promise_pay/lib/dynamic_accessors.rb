module PromisePay
  module Lib
    module DynamicAccessors
      class << self
        def define_accessor(attribute, value, object)
          klass = object.class
          if attribute.to_s.end_with? "_at"
            define_date_based_accessors(attribute, value, klass)
          else
            define_standard_accessors(attribute, value, klass)
          end
        end

        private

        def define_date_based_accessors(attribute, value, klass)
          klass.class_eval %Q"
            def #{attribute}=(value)
              @#{attribute} = value.nil? ? nil : Time.parse(value).to_i
            end

            def #{attribute}
              @#{attribute}.nil? ? nil : Time.at(@#{attribute})
            end
          "
        end

        def define_standard_accessors(attribute, value, klass)
          klass.class_eval %Q"
            def #{attribute}=(value)
              @#{attribute} = value
            end

            def #{attribute}
              @#{attribute}
            end
          "
        end
      end
    end
  end
end
