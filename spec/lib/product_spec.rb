describe Bakery::Product do

  let(:name) { Faker::StarWars.droid }
  let(:code) { Faker::StarWars.unique.wookie_sentence }
  let(:quantity) { {Faker::Number.digit.to_i => Faker::Number.digit} }

  let(:subject) { described_class.new name, code, quantity }

  describe '#has_product_code?' do

    let(:has_product_code) { subject.has_product_code? requested_product_code }

    context 'when the product has the same product code' do

      let(:requested_product_code) { code }

      it 'returns true' do
        expect(has_product_code).to eq true
      end

    end

    context 'when the product does not have the same product code' do

      let(:requested_product_code) { Faker::StarWars.unique.wookie_sentence }

      it 'returns true' do
        expect(has_product_code).to eq false
      end

    end

  end


end