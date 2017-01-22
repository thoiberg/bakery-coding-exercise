module Bakery
  class Product

    def initialize product_name, code, quantities
      @product_name = product_name
      @code = code
      @quantities = quantities
    end

    def has_product_code? code
      @code == code
    end

    def sellable_quantities
      @quantities.keys
    end

  end
end