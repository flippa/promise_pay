module PromisePay
  module Lib
    module DynamicAccessors
      def assign_instance_variables(result)
        return if result.empty?

        result.each do |attribute, value|
          if value.is_a?(Hash)
            value.each { |att, val| initialize_property(att, val) }
          else
            initialize_property(attribute, value)
          end
        end
        self
      end

      def initialize_property(attribute, value)
        attribute = attribute.gsub(/s$/, '_id') if ["buyers","sellers"].include? attribute
        define_accessor(attribute, value, self) unless accessor_defined?(attribute)
        set_property(attribute, value)
      end

      def accessor_defined?(attribute)
        respond_to?(attribute) && respond_to?("#{attribute}=")
      end

      def set_property(attribute, value)
        setter_method = "#{attribute}="
        self.send(setter_method, value)
      end

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
