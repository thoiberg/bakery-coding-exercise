module Bakery
  class QuantityValidator
    class << self

      def validate product_quantities, requested_quantity
        sorted_quantities = sort_by_highest product_quantities

      end

      private

      def sort_by_highest quantities
        quantities.sort.reverse
      end


      def first_attempt product_quantities, requested_quantity
        difference = requested_quantity
        valid_amounts = []

        while difference != 0
          next_num = 0
          found = false
          product_quantities.each do |pq|
            new_diff = difference - pq
            if new_diff < difference
              found = true
              next_num = pq
              difference = new_diff
            end
          end

          if not found
            raise 'requested amount can\'t broken up into sellable amounts'
          end

          difference += next_num
          valid_amounts << next_num
        end

        valid_amounts

      end

    end
  end
end