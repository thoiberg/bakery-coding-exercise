module Bakery
  class Products

    attr_reader :products

    class << self

      def load products_config
        products = products_config.map do |product_config|
          Product.new product_config[:name], product_config[:code], product_config[:quantities]
        end

        new products
      end

    end

    def initialize products
      @products = products
    end

  end

end