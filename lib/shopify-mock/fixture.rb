module ShopifyAPI
  module Mock
    # The mock fixtures can contain a YAML header and use ERB to provide dynamic
    # content.
    #
    # @example A valid fixture.
    #
    #     ---
    #     headers:
    #       "Content-Type": "application/json"
    #     status: 200
    #     ---
    #     { "Hello": "<%= world %>" }
    #
    # @example Reading the JSON from the above fixture.
    #
    #     path = File.expand_path('../fixtures/test.json', __FILE__)
    #     fixture = Fixture.new(path)
    #
    #     # in this case a context must be provided so Fixture can read the
    #     # variable named 'world'.
    #     world = 'WORLD'
    #     fixture.json(binding)
    #
    class Fixture
      # Contains the untouched data from the fixture.
      #
      # @return [String] The file's exact contents.
      attr_reader :content

      # The full path to the fixture file.
      #
      # @return [String] The fixture's full filename.
      attr_reader :path

      # Constructs a Fixture instance from the supplied file in the given path.
      #
      # @example Reading the JSON from a fixture.
      #
      #     path = File.expand_path('../fixtures/test.json', __FILE__)
      #     fixture = ShopifyAPI::Mock::Fixture.new(path)
      #     fixture.json
      #
      # @param [String] path The full path and filename for the fixture.
      # @return [ShopifyAPI::Mock::Fixture] The fixture.
      def initialize(path)
        @path = path
        @content = File.read(path)
      end

      # Checks if the fixture contains a YAML header.
      #
      # @return [Boolean] Whether or not the fixture contains a YAML header.
      def has_yaml?
        content.start_with?("---\n") && content =~ /---(.|\n)*---/
      end

      # Extracts and parses the YAML from the header of the fixture.
      #
      # @return [Hash] The parsed YAML or an empty Hash if no YAML header found.
      def yaml
        @yaml ||= has_yaml? ? YAML.load(@content) : {}
      end

      # Extracts the JSON data from the file and runs it through an ERB parser.
      #
      # @param [Binding] erb_context The context to use for the ERB parser.
      # @return [String] The JSON data.
      def json(erb_context=nil)
        @json ||= ERB.new(raw_json).result(erb_context)
      end

      # Extracts the raw JSON from the file without parsing with ERB.
      #
      # @return [String] The JSON data.
      def raw_json
        @raw_json ||= @content.gsub(/---(.|\n)*---/, '')
      end
    end
  end
end
