require 'yaml'

module Bakery
  class Config

    DEFAULT_CONFIG_FILE = File.expand_path('../../config/config.yaml', __FILE__)


    class << self

      def load file_path=DEFAULT_CONFIG_FILE
        config = YAML.load_file file_path

        new config
      end

    end

    attr_reader :products

    def initialize config
      @products = config['products']
    end


  end
end