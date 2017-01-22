describe Bakery::PurchaseProcessor do

  describe '::process' do

    let(:product_code) { Faker::GameOfThrones.dragon }
    let(:quantity) { Faker::Number.digit.to_i }
    let(:subject) { described_class.process product_code, quantity }

    context 'when the product code is empty' do

      let(:product_code) { nil }

      it 'raises an error' do
        expect{subject}.to raise_error 'Product code must be supplied'
      end

    end

    context 'when the quantity is empty' do

      let(:quantity) { nil }

      it 'raises an error' do
        expect{subject}.to raise_error 'Quantity must be supplied'
      end

    end

    context 'when inputs are valid' do

      let(:products) { instance_double Bakery::Products }
      let(:config_products) { double 'config_products' }
      let(:config) { instance_double Bakery::Config, products: config_products }
      let(:product_quantities) { double 'product_quantities' }
      let(:product) { instance_double Bakery::Product, sellable_quantities: product_quantities }

      before do
        allow(Bakery::Config).to receive(:load).and_return config
        allow(Bakery::Products).to receive(:load).and_return products
        allow(products).to receive(:products)
        allow(products).to receive(:find_product_for).and_return product
        allow(Bakery::QuantityValidator).to receive(:validate)
      end

      it 'loads the config' do
        subject

        expect(Bakery::Config).to have_received :load
      end

      it 'loads the products using the config' do
        subject

        expect(Bakery::Products).to have_received(:load).with config_products
      end

      it 'looks for the  product that has the requested product code' do
        subject

        expect(products).to have_received(:find_product_for).with product_code
      end

      context 'when there is a product with a code that matches the requested product code' do

        before do
          subject
        end

        it 'validates the requested quantity can be distributed amongst the sold quantities' do
          expect(Bakery::QuantityValidator).to have_received(:validate).with product_quantities, quantity
        end

      end

      context 'when there are no products that match the requested product code' do

        before do
          allow(products).to receive(:find_product_for).and_return nil
        end

        it 'raises an exception' do
          expect{subject}.to raise_error 'Product code does not match any products on the system'
        end

      end


    end

  end

end