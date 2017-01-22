module Bakery
  class PurchaseProcessor
    class << self

      def process product_code, quantity
        validate_input product_code, quantity

        config = Config.load

      end

      private

      def validate_input product_code, quantity
        raise 'Product code must be supplied' if product_code.nil?
        raise 'Quantity must be supplied' if quantity.nil?
      end

    end
  end
end