module PromisePay
  module Operators
    module Find
      module ClassMethods
        def find(id = nil)
          unless id.is_a?(String) || id.is_a?(Integer)
            raise PromisePay::InvalidRequest, "#{self}#find requires a unique object id"
          end

          new(id).fetch
        end
      end

      def self.included(base)
        base.extend(ClassMethods)
      end
    end
  end
end
