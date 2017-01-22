describe Bakery::QuantityValidator do

  describe '::validate' do

    let(:subject) { described_class }

    [
      [[3,5], 10, [5,5]],
      [[2 ,5, 8], 14, [8, 2, 2, 2]],
      [[3, 5, 9]], 13, [5, 5, 3]
     ].each do | test_data|
      xit 'returns the smallest amount of quantities needed to purchase the desired amount' do
        product_quantities = test_data[0]
        request_quantity = test_data[1]
        expected_quantities = test_data[2]

        expect(subject.validate(product_quantities, request_quantity)).to eq expected_quantities
      end
    end

  end

end