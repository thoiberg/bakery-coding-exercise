describe Bakery::Products do

  describe '::load' do

    let(:product_name) { Faker::StarWars.unique.droid }
    let(:product_code) { Faker::StarWars.unique.wookie_sentence }
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
    let(:product_1) { instance_double Bakery::Product }
    let(:product_2) { instance_double Bakery::Product }

    let(:subject) { described_class.load product_config }

    before do
      allow(Bakery::Product).to receive(:new).and_return product_1, product_2

      subject
    end

    it 'creates a Product for each product config supplied' do
      expect(Bakery::Product).to have_received(:new).twice
    end

    it 'creates a Product using the name from the config' do
      expect(Bakery::Product).to have_received(:new).with product_name, anything, anything
    end

    it 'creates a Product using the code from the config' do
      expect(Bakery::Product).to have_received(:new).with anything, product_code, anything
    end

    it 'creates a Product using the quantities from the config' do
      expect(Bakery::Product).to have_received(:new).with anything, anything, quantities
    end

    it 'initialises itself with the Products that were created' do
      expect(subject.products).to eq [product_1, product_2]
    end

  end

end