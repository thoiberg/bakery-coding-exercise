describe Bakery::Products do

  let(:product_class) { Bakery::Product }
  let(:product_code) { Faker::StarWars.unique.wookie_sentence }

  describe '::load' do

    let(:product_name) { Faker::StarWars.unique.droid }
    let(:quantities) { {Faker::Number.unique.digit.to_i => Faker::Number.digit.to_i} }
    let(:product_config) do
      [
        {
            name: product_name,
            code: product_code,
            quantities: quantities
        },
        {
            name: Faker::StarWars.droid,
            code: Faker::StarWars.wookie_sentence,
            quantities: {Faker::Number.digit.to_i => Faker::Number.digit}
        }
      ]
    end
    let(:product_1) { instance_double product_class }
    let(:product_2) { instance_double product_class }

    let(:subject) { described_class.load product_config }

    before do
      allow(product_class).to receive(:new).and_return product_1, product_2

      subject
    end

    it 'creates a Product for each product config supplied' do
      expect(product_class).to have_received(:new).twice
    end

    it 'creates a Product using the name from the config' do
      expect(product_class).to have_received(:new).with product_name, anything, anything
    end

    it 'creates a Product using the code from the config' do
      expect(product_class).to have_received(:new).with anything, product_code, anything
    end

    it 'creates a Product using the quantities from the config' do
      expect(product_class).to have_received(:new).with anything, anything, quantities
    end

    it 'initialises itself with the Products that were created' do
      expect(subject.products).to eq [product_1, product_2]
    end

  end

  describe '#find_product_for' do


    let(:product_1) { instance_double product_class, has_product_code?: true }
    let(:product_2) { instance_double product_class, has_product_code?: false }
    let(:products) { [product_1, product_2] }
    let(:subject) { described_class.new products }

    context 'when there is a product that has the matching product code' do

      it 'returns the product' do
        expect(subject.find_product_for product_code).to eq product_1
      end

    end

    context 'when there are no products that match the product code' do

      let(:product_1) { instance_double product_class, has_product_code?: false }

      it 'returns nil' do
        expect(subject.find_product_for product_code).to eq nil
      end

    end

  end

end