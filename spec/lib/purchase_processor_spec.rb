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

  end

end