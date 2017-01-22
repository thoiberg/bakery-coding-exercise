module Bakery
  class PurchaseProcessor
    class << self

      def process product_code, quantity
        validate_input product_code, quantity

        config = Config.load

        product = find_requested_product config, product_code
        quantities_and_prices = get_cost_of_quantities(product, quantity)

        puts "#{format_for_output(quantities_and_prices)}"
      end

      private

      def validate_input product_code, quantity
        raise 'Product code must be supplied' if product_code.nil?
        raise 'Quantity must be supplied' if quantity.nil?
      end

      def get_cost_of_quantities product, quantity
        quantities = QuantityValidator.validate product.sellable_quantities, quantity

        cost_of_quantities = quantities.map do |quantity|
          product.price_of(quantity)
        end

        quantities.zip cost_of_quantities
      end

      def find_requested_product(config, product_code)
        products = Products.load config.products
        product = products.find_product_for product_code

        raise 'Product code does not match any products on the system' if product.nil?

        product
      end

      def format_for_output quantities_and_prices
        output_string = ''

        quantities_and_prices.each do |quantity, price|
          output_string << "#{quantity} - $#{price}"
          output_string << "\n"
        end
      end

    end
  end
end