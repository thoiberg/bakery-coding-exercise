module Bakery
  class PurchaseProcessor
    class << self

      def process product_code, quantity
        validate_input product_code, quantity

        config = Config.load

        products = Products.load config.products

        product = products.find_product_for product_code

        raise 'Product code does not match any products on the system' if product.nil?

      end

      private

      def validate_input product_code, quantity
        raise 'Product code must be supplied' if product_code.nil?
        raise 'Quantity must be supplied' if quantity.nil?
      end

    end
  end
end