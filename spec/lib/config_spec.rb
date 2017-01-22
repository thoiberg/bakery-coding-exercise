describe Bakery::Config do

  describe '::load' do

    let(:subject) { described_class.load }
    let(:products) { [{name: Faker::TwinPeaks.character}] }
    let(:yaml_config) { {'products' => products} }

    before do
      allow(YAML).to receive(:load_file).and_return(yaml_config)

      subject
    end

    context 'when the file path is passed in' do

      let(:subject) { described_class.load config_file_path }
      let(:config_file_path) { 'sfefefef' }


      it 'loads the yaml config from file' do
        expect(YAML).to have_received(:load_file).with config_file_path
      end

    end

    context 'when the file path is not passed in' do

      it 'loads the default yaml file' do
        default_file_path = File.expand_path('../../../config/config.yaml', __FILE__)

        expect(YAML).to have_received(:load_file).with default_file_path
      end

    end

    it 'returns an object of itself with the products as an attribute' do
      expect(subject.products).to eq(products)
    end

  end

end